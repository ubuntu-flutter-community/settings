#include "my_application.h"

#include <flutter_linux/flutter_linux.h>
#ifdef GDK_WINDOWING_X11
#include <gdk/gdkx.h>
#endif

#include "flutter/generated_plugin_registrant.h"

struct _MyApplication {
  GtkApplication parent_instance;
  char** dart_entrypoint_arguments;
  GdkDevice* grab_pointer;
  FlView* view;
};

G_DEFINE_TYPE(MyApplication, my_application, GTK_TYPE_APPLICATION)

static const gchar* gdk_grab_status_code(GdkGrabStatus status) {
  switch (status) {
    case GDK_GRAB_SUCCESS:
      return "GDK_GRAB_SUCCESS";
    case GDK_GRAB_ALREADY_GRABBED:
      return "GDK_GRAB_ALREADY_GRABBED";
    case GDK_GRAB_INVALID_TIME:
      return "GDK_GRAB_INVALID_TIME";
    case GDK_GRAB_NOT_VIEWABLE:
      return "GDK_GRAB_NOT_VIEWABLE";
    case GDK_GRAB_FROZEN:
      return "GDK_GRAB_FROZEN";
    case GDK_GRAB_FAILED:
      return "GDK_GRAB_FAILED";
    default:
      return "GDK_GRAB_???";
  }
}

static const gchar* gdk_grab_status_message(GdkGrabStatus status) {
  switch (status) {
    case GDK_GRAB_SUCCESS:
      return "The resource was successfully grabbed.";
    case GDK_GRAB_ALREADY_GRABBED:
      return "The resource is actively grabbed by another client.";
    case GDK_GRAB_INVALID_TIME:
      return "The resource was grabbed more recently than the specified time.";
    case GDK_GRAB_NOT_VIEWABLE:
      return "The grab window or the confine_to window are not viewable.";
    case GDK_GRAB_FROZEN:
      return "The resource is frozen by an active grab of another client.";
    case GDK_GRAB_FAILED:
      return "The grab failed for some other reason.";
    default:
      return "The grab status is unknown.";
  }
}

static GdkGrabStatus keyboard_ungrab(MyApplication* self) {
  g_return_val_if_fail(MY_IS_APPLICATION(self), GDK_GRAB_FAILED);
  g_return_val_if_fail(self->grab_pointer == nullptr, GDK_GRAB_FAILED);

  GtkWidget* widget = gtk_widget_get_toplevel(GTK_WIDGET(self->view));
  GdkWindow* window = gtk_widget_get_window(widget);
  GdkDisplay* display = gdk_window_get_display(window);
  GdkSeat* seat = gdk_display_get_default_seat(display);

  GdkGrabStatus status = gdk_seat_grab(
      seat, window, GDK_SEAT_CAPABILITY_KEYBOARD, false /* owner_events */,
      nullptr /* cursor */, nullptr /* event */, nullptr /*prepare_func */,
      nullptr /* prepare_func_data */);

  self->grab_pointer = gdk_seat_get_keyboard(seat);
  if (!self->grab_pointer) {
    self->grab_pointer = gdk_seat_get_pointer(seat);
  }

  return status;
}

static bool keyboard_grab(MyApplication* self) {
  g_return_val_if_fail(MY_IS_APPLICATION(self), false);
  g_return_val_if_fail(self->grab_pointer != nullptr, false);

  gdk_seat_ungrab(gdk_device_get_seat(self->grab_pointer));
  self->grab_pointer = nullptr;
  return true;
}

static void keyboard_method_call_cb(FlMethodChannel* method_channel,
                                    FlMethodCall* method_call,
                                    gpointer user_data) {
  MyApplication* self = MY_APPLICATION(user_data);

  g_autoptr(FlMethodResponse) response = nullptr;
  const gchar* method_name = fl_method_call_get_name(method_call);
  if (strcmp(method_name, "grabKeyboard") == 0) {
    GdkGrabStatus status = keyboard_ungrab(self);
    if (status == GDK_GRAB_SUCCESS) {
      response = FL_METHOD_RESPONSE(
          fl_method_success_response_new(fl_value_new_bool(true)));
    } else {
      response = FL_METHOD_RESPONSE(fl_method_error_response_new(
          gdk_grab_status_code(status), gdk_grab_status_message(status),
          nullptr));
    }
  } else if (strcmp(method_name, "ungrabKeyboard") == 0) {
    bool result = keyboard_grab(self);
    response = FL_METHOD_RESPONSE(
        fl_method_success_response_new(fl_value_new_bool(result)));
  } else {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }
  fl_method_call_respond(method_call, response, nullptr);
}

// Implements GApplication::activate.
static void my_application_activate(GApplication* application) {
  MyApplication* self = MY_APPLICATION(application);
  GtkWindow* window =
      GTK_WINDOW(gtk_application_window_new(GTK_APPLICATION(application)));

  // Use a header bar when running in GNOME as this is the common style used
  // by applications and is the setup most users will be using (e.g. Ubuntu
  // desktop).
  // If running on X and not using GNOME then just use a traditional title bar
  // in case the window manager does more exotic layout, e.g. tiling.
  // If running on Wayland assume the header bar will work (may need changing
  // if future cases occur).
  gboolean use_header_bar = TRUE;
#ifdef GDK_WINDOWING_X11
  GdkScreen* screen = gtk_window_get_screen(window);
  if (GDK_IS_X11_SCREEN(screen)) {
    const gchar* wm_name = gdk_x11_screen_get_window_manager_name(screen);
    if (g_strcmp0(wm_name, "GNOME Shell") != 0) {
      use_header_bar = FALSE;
    }
  }
#endif
  if (use_header_bar) {
    GtkHeaderBar* header_bar = GTK_HEADER_BAR(gtk_header_bar_new());
    gtk_widget_show(GTK_WIDGET(header_bar));
    gtk_header_bar_set_title(header_bar, "Ubuntu Settings");
    gtk_header_bar_set_show_close_button(header_bar, TRUE);
    gtk_window_set_titlebar(window, GTK_WIDGET(header_bar));
  } else {
    gtk_window_set_title(window, "settings");
  }

  GdkGeometry geometry;
  geometry.min_width = 600;
  geometry.min_height = 700;
  gtk_window_set_geometry_hints(window, nullptr, &geometry, GDK_HINT_MIN_SIZE);

  gtk_window_set_default_size(window, 850, 940);

  g_autoptr(FlDartProject) project = fl_dart_project_new();
  fl_dart_project_set_dart_entrypoint_arguments(project, self->dart_entrypoint_arguments);

  FlView* view = fl_view_new(project);
  gtk_widget_show(GTK_WIDGET(view));
  gtk_container_add(GTK_CONTAINER(window), GTK_WIDGET(view));

  fl_register_plugins(FL_PLUGIN_REGISTRY(view));

  self->view = view;
  FlEngine* engine = fl_view_get_engine(self->view);
  FlBinaryMessenger* messenger = fl_engine_get_binary_messenger(engine);
  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();

  g_autoptr(FlMethodChannel) keyboard_channel = fl_method_channel_new(
      messenger, "settings/keyboard", FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(
      keyboard_channel, keyboard_method_call_cb, self, nullptr);

  gtk_widget_show(GTK_WIDGET(window));
  gtk_widget_show(GTK_WIDGET(view));
  gtk_widget_grab_focus(GTK_WIDGET(view));
}

// Implements GApplication::local_command_line.
static gboolean my_application_local_command_line(GApplication* application, gchar*** arguments, int* exit_status) {
  MyApplication* self = MY_APPLICATION(application);
  // Strip out the first argument as it is the binary name.
  self->dart_entrypoint_arguments = g_strdupv(*arguments + 1);

  g_autoptr(GError) error = nullptr;
  if (!g_application_register(application, nullptr, &error)) {
     g_warning("Failed to register: %s", error->message);
     *exit_status = 1;
     return TRUE;
  }

  g_application_activate(application);
  *exit_status = 0;

  return TRUE;
}

// Implements GObject::dispose.
static void my_application_dispose(GObject* object) {
  MyApplication* self = MY_APPLICATION(object);
  g_clear_pointer(&self->dart_entrypoint_arguments, g_strfreev);
  G_OBJECT_CLASS(my_application_parent_class)->dispose(object);
}

static void my_application_class_init(MyApplicationClass* klass) {
  G_APPLICATION_CLASS(klass)->activate = my_application_activate;
  G_APPLICATION_CLASS(klass)->local_command_line = my_application_local_command_line;
  G_OBJECT_CLASS(klass)->dispose = my_application_dispose;
}

static void my_application_init(MyApplication* self) {}

MyApplication* my_application_new() {
  return MY_APPLICATION(g_object_new(my_application_get_type(),
                                     "application-id", APPLICATION_ID,
                                     "flags", G_APPLICATION_NON_UNIQUE,
                                     nullptr));
}
