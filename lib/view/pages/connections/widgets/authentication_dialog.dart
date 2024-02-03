import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/connections/data/authentication.dart';
import 'package:settings/view/pages/connections/models/access_point_model.dart';
import 'package:yaru_icons/yaru_icons.dart';

class AuthenticationDialog extends StatelessWidget {
  AuthenticationDialog({super.key});

  final canShowPassword = ValueNotifier(false);
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final accessPointSsid = context.read<AccessPointModel>().name;

    return AlertDialog(
      title: const _DialogRow(
        title: Icon(
          YaruIcons.network_wireless,
          size: 70,
        ),
        field: Text(
          'Authentication required by Wi-Fi network',
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DialogRow(
            field: Text(
              'Passwords or encryption keys are required to access the Wi-Fi network "$accessPointSsid"',
            ),
          ),
          const SizedBox(height: 16),
          _DialogRow(
            title: const Text('Wifi Security'),
            field: DropdownButton<String>(
              value: 'a',
              onChanged: (_) {},
              items: const [
                DropdownMenuItem(
                  value: 'a',
                  child: Text('Not Implemented yet'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _DialogRow(
            title: const Text('Password'),
            field: ValueListenableBuilder<bool>(
              valueListenable: canShowPassword,
              builder: (_, showPassword, ___) {
                return TextField(
                  controller: passwordController,
                  obscureText: !showPassword,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          _DialogRow(
            field: InkWell(
              onTap: () => canShowPassword.value = !canShowPassword.value,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: canShowPassword,
                      builder: (_, showPassword, __) {
                        return IgnorePointer(
                          child: Checkbox(
                            hoverColor: Colors.transparent,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: showPassword,
                            onChanged: (_) {},
                          ),
                        );
                      },
                    ),
                    const Text('Show Password'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(
            Authentication(
              password: passwordController.text,
              storePassword: StorePassword.allUsers,
              wifiSecurity: WifiSecurity.wpa2Personal,
            ),
          ),
          child: const Text('Connect'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

class _DialogRow extends StatelessWidget {
  const _DialogRow({
    this.title,
    required this.field,
  });
  final Widget? title;
  final Widget field;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DefaultTextStyle.merge(
          textAlign: TextAlign.center,
          child: Expanded(
            flex: 2,
            child: title ?? const SizedBox.shrink(),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(fit: FlexFit.loose, flex: 10, child: field),
      ],
    );
  }
}
