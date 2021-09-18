import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:linux_system_info/linux_system_info.dart';

import 'hostname_service.dart';

class InfoModel extends ChangeNotifier {
  InfoModel([HostnameService? hostnameService])
  : _hostnameService = hostnameService ?? HostnameService();

  final HostnameService _hostnameService;

  String _gpuName = '';

  void init() {
    _hostnameService.init().then((_) => notifyListeners());
    
    GpuInfo.load().then((gpus) {
      notifyListeners();
      _gpuName = gpus.first.model;
    });
  }

  String get hostname => _hostnameService.hostname;
  String get staticHostname => _hostnameService.staticHostname;

  void setHostname(String hostname) {
    _hostnameService.setHostname(hostname).then((_) => notifyListeners());
  }

  String get osName => SystemInfo().os_name + ' ' + SystemInfo().os_version;
  String get osType => sizeOf<IntPtr>() == 8 ? '64 bits' : '32 bits';

  String get processor => CpuInfo.getProcessors()[0].model_name + ' x ' + (CpuInfo.getProcessors().length + 1).toString();
  String get memory => MemInfo().mem_total_gb.toString() + ' Gb';
  String get graphics => _gpuName;
  String get diskCapacity => '';

  String get gnomeVersion => GnomeInfo().version;
  String get windowServer => Platform.environment['XDG_SESSION_TYPE'] ?? '';

  @override
  void dispose() {
    _hostnameService.dispose();
    super.dispose();
  }
}
