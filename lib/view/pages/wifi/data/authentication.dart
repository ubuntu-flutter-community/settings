enum StorePassword { thisUser, allUsers, askAlways }
enum WifiSecurity { wpa2Personal, wpa3Personal }

class Authentication {
  const Authentication({
    required this.password,
    required this.storePassword,
    required this.wifiSecurity,
  });

  final String password;
  final StorePassword storePassword;
  final WifiSecurity? wifiSecurity;
}
