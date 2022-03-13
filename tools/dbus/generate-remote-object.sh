dart pub global activate dbus

rm -rf ../../lib/generated/dbus/
mkdir ../../lib/generated/dbus/
dart-dbus generate-remote-object interfaces/org.gnome.Mutter.DisplayConfig.xml -o ../../lib/generated/dbus/display-config-remote-object.dart