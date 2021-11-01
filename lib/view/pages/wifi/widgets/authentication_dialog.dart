import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/authentication.dart';
import '../models/wifi_model.dart';

class AuthenticationDialog extends StatelessWidget {
  AuthenticationDialog({Key? key}) : super(key: key);

  final canShowPassword = ValueNotifier(false);
  final passwordContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final accessPointSsid = context.read<AccessPointModel>().ssid;

    return AlertDialog(
      title: _DialogRow(
        title: Icon(
          Icons.wifi,
          size: 70,
        ),
        field: Text(
          'Authenticatoin required by Wi-Fi network',
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _DialogRow(
            field: Text(
                'Passwords or encryption keys are required to access the Wi-Fi network "$accessPointSsid"'),
          ),
          SizedBox(height: 16),
          _DialogRow(
            title: Text('Wifi Security'),
            //TODO: add security options
            field: DropdownButton<String>(
              value: 'a',
              items: const [
                DropdownMenuItem(
                  child: Text('Not Implemnted yet'),
                  value: 'a',
                )
              ],
            ),
          ),
          SizedBox(height: 16),
          _DialogRow(
            title: Text('Passwrod'),
            field: ValueListenableBuilder<bool>(
                valueListenable: canShowPassword,
                builder: (_, showPassword, ___) {
                  return TextField(
                    controller: passwordContoller,
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  );
                }),
          ),
          SizedBox(height: 16),
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
                        }),
                    Text('Show Password'),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(
            Authentication(
              password: passwordContoller.text,
              storePassword: StorePassword.allUsers,
              wifiSecurity: WifiSecurity.wpa2Personal,
            ),
          ),
          child: Text('Connect'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        )
      ],
    );
  }
}

class _DialogRow extends StatelessWidget {
  final Widget? title;
  final Widget field;
  const _DialogRow({
    this.title,
    required this.field,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DefaultTextStyle.merge(
          textAlign: TextAlign.center,
          child: Expanded(
            flex: 2,
            child: title ?? SizedBox.shrink(),
          ),
        ),
        SizedBox(width: 10),
        Flexible(fit: FlexFit.loose, flex: 10, child: field)
      ],
    );
  }
}
