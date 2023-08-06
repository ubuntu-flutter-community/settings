# Settings App for the Ubuntu Desktop

The goal of this project is to build a feature complete settings app for the Ubuntu desktop (GNOME, gtk and gnome-shell) with the Flutter UI toolkit.

| Light | Dark
| - | - |
| ![](.github/images/light.png) | ![](.github/images/dark.png) |

Mentionable packages that we use and want to thank are:

- [gsettings.dart](https://github.com/canonical/gsettings.dart)
- [bluez.dart](https://github.com/canonical/bluez.dart)
- [nm.dart](https://github.com/canonical/nm.dart)
- [yaru.dart](https://github.com/ubuntu/yaru.dart)
- [yaru_icons.dart](https://github.com/ubuntu/yaru_icons.dart)
- [yaru_widgets.dart](https://github.com/ubuntu/yaru_widgets.dart)
- [dbus.dart](https://github.com/canonical/dbus.dart)
- [upower.dart](https://github.com/canonical/upower.dart)
- [udisks.dart](https://github.com/canonical/udisks.dart)
- [flex_color_picker](https://github.com/rydmike/flex_color_picker)


# Alpha Releases / Download

Currently the app is in a very raw alpha state and pages are still missing.
However if you want you can download, extract and then run alpha releases [from the releases page](https://github.com/Feichtmeier/settings/releases).

# Building

The following steps are needed to run the app from the source code.

## Install Flutter

```bash
sudo apt -y install git curl cmake meson make clang libgtk-3-dev pkg-config && mkdir -p ~/development && cd ~/development && git clone https://github.com/flutter/flutter.git -b stable && echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.bashrc && source ~/.bashrc
```

# TODO

- [X] use real yaru icons - thanks to @Jupi007
- [X] responsive layout
- [X] [MVVM software pattern](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) - thanks to @jpnurmi
- [X] search
- [X] WIFI page - WIP
- [ ] Ethernet page
- [ ] Cellular Network page
- [X] Bluetooth page - WIP
- [X] Wallpaper page
- [X] Appearance page
- [X] Multi-Tasking page
- [X] Notifications page
- [ ] Search page
- [X] Apps page (forward to snap-store)
- [X] Privacy/Security page - WIP
- [ ] Online Accounts page
- [ ] Sound page - WIP    
- [X] Power page
- [X] Displays page - WIP
- [X] Mouse and touchpad page
- [X] Keyboard shortcuts page - WIP
- [ ] Printers page - WIP
- [X] Removable Media page    
- [ ] Color page
- [X] Region and language page
- [X] Accessability page
- [ ] Users page
- [ ] Preferred apps page
- [X] Date and time page
- [ ] Wacom page
- [X] Info page

## Contributing

This project really needs help to finish the last pages and also in the future when the GNOME desktop changes. Any help is welcome!


However for new contributors please follow those rules:

- do not over complicate things
- stick to the service, viewmodel, view approach
- as long as we stick to the provider package try to avoid context.watch as much as possible and always prefer context.select
- as long as we stick to the provider package try to avoid provider calls as much as possible and prefer to forward callbacks and values where you can
- do not split files with [the part keyword](https://dart.dev/guides/libraries/create-packages#organizing-a-package)
- do not shadow function definitions with [typedef](https://dart.dev/language/typedefs)
- use absolute imports
