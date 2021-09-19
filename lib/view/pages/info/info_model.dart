import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:linux_system_info/linux_system_info.dart';
import 'package:udisks/udisks.dart';

import 'hostname_service.dart';

class InfoModel extends ChangeNotifier {
  InfoModel([
    HostnameService? hostnameService,
    UDisksClient? uDisksClient
  ]) :
    _hostnameService = hostnameService ?? HostnameService(),
    _uDisksClient = uDisksClient ?? UDisksClient()
  ;

  final HostnameService _hostnameService;
  final UDisksClient _uDisksClient;

  String _gpuName = '';
  int? _diskCapacity;

  void init() {
    _hostnameService.init().then((_) => notifyListeners());

    GpuInfo.load().then((gpus) {
      notifyListeners();
      _gpuName = gpus.first.model;
    });

    _uDisksClient.connect().then((value) {
      _diskCapacity = _uDisksClient.drives.fold<int>(0, (sum, drive) => sum + drive.size);
    });
  }

  String get hostname => _hostnameService.hostname;
  String get staticHostname => _hostnameService.staticHostname;

  void setHostname(String hostname) {
    _hostnameService.setHostname(hostname).then((_) => notifyListeners());
  }

  String get osName => SystemInfo().os_name;
  String get osVersion => SystemInfo().os_version;
  String get osType => sizeOf<IntPtr>() == 8 ? '64' : '32';

  String get processorName => CpuInfo.getProcessors()[0].model_name;
  String get processorCount => (CpuInfo.getProcessors().length + 1).toString();
  String get memory => MemInfo().mem_total_gb.toString();
  String get graphics => _gpuName;
  int? get diskCapacity => _diskCapacity;

  String get gnomeVersion => GnomeInfo().version;
  String get windowServer => Platform.environment['XDG_SESSION_TYPE'] ?? '';

  @override
  void dispose() {
    _hostnameService.dispose();
    _uDisksClient.close();
    super.dispose();
  }
}
