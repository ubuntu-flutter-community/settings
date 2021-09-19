import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:linux_system_info/linux_system_info.dart';
import 'package:udisks/udisks.dart';

import 'hostname_service.dart';

class InfoModel extends ChangeNotifier {
  InfoModel([
    HostnameService? hostnameService,
    UDisksClient? uDisksClient,
    List<Cpu>? cpus,
    SystemInfo? systemInfo,
    MemInfo? memInfo,
    GnomeInfo? gnomeInfo
  ]) :
    _hostnameService = hostnameService ?? HostnameService(),
    _uDisksClient = uDisksClient ?? UDisksClient(),
    _cpus = cpus ?? CpuInfo.getProcessors(),
    _systemInfo = systemInfo ?? SystemInfo(),
    _memInfo = memInfo ?? MemInfo(),
    _gnomeInfo = gnomeInfo ?? GnomeInfo();

  final HostnameService _hostnameService;
  final UDisksClient _uDisksClient;
  final List<Cpu> _cpus;
  final SystemInfo _systemInfo;
  final MemInfo _memInfo;
  final GnomeInfo _gnomeInfo;

  String _gpuName = '';
  int? _diskCapacity;

  Future<void> init() async {
    await _hostnameService.init();

    await GpuInfo.load().then((gpus) {
      _gpuName = gpus.first.model;
    });

    await _uDisksClient.connect().then((value) {
      _diskCapacity = _uDisksClient.drives.fold<int>(0, (sum, drive) => sum + drive.size);
    });

    notifyListeners();
  }

  String get hostname => _hostnameService.hostname;
  String get staticHostname => _hostnameService.staticHostname;

  void setHostname(String hostname) {
    _hostnameService.setHostname(hostname).then((_) => notifyListeners());
  }

  String get osName => _systemInfo.os_name;
  String get osVersion => _systemInfo.os_version;
  String get osType => sizeOf<IntPtr>() == 8 ? '64' : '32';

  String get processorName => _cpus[0].model_name;
  String get processorCount => (_cpus.length + 1).toString();
  String get memory => _memInfo.mem_total_gb.toString();
  String get graphics => _gpuName;
  int? get diskCapacity => _diskCapacity;

  String get gnomeVersion => _gnomeInfo.version;
  String get windowServer => Platform.environment['XDG_SESSION_TYPE'] ?? '';

  @override
  void dispose() {
    _hostnameService.dispose();
    _uDisksClient.close();
    super.dispose();
  }
}
