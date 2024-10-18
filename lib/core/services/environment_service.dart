import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum EnvironmentType { dev, staging, prod }

extension EnvironmentTypeExtension on EnvironmentType {
  String get env {
    if (this == EnvironmentType.prod) {
      return 'prod';
    }
    if (this == EnvironmentType.staging) {
      return 'staging';
    }
    return 'dev';
  }
}

abstract class EnvironmentService {
  Future<void> loadEnvConfig();
  String apiDomain();
  EnvironmentType get env;
  Future<PackageInfo> getPackageInfo();
}

class EnvironmentServiceImpl implements EnvironmentService {
  final Logger _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  late EnvironmentType current = EnvironmentType.dev;

  @override
  String apiDomain() {
    if (current == EnvironmentType.prod) {
      return '';
    } else if (current == EnvironmentType.staging) {
      return '';
    }
    return '';
  }

  @override
  EnvironmentType get env => current;

  @override
  Future<PackageInfo> getPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }

  @override
  Future<void> loadEnvConfig() async {
    await _loadEnvironment();
    _logger.d('Environment: ${current.env} - APP_URL: ${apiDomain()}');
  }

  /// Here is how to know the current environment of the app
  /// by checking the package name
  Future<void> _loadEnvironment() async {
    final packageInfo = await getPackageInfo();
    if (packageInfo.packageName.contains('com.habitgarden.ihun.habitGarden')) {
      current = EnvironmentType.prod;
    } else if (packageInfo.packageName.contains('.staging')) {
      current = EnvironmentType.staging;
    } else {
      current = EnvironmentType.dev;
    }
  }
}
