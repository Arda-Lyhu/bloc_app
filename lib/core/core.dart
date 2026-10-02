/// Master barrel export for all shared components, utilities, and network modules.
///
/// Simply `import 'package:app_scale/core/core.dart';` to access:
/// - Reusable Widgets (`AppButton`, `AppTextField`, `AppLoader`, `AppErrorWidget`, etc.)
/// - Utilities (`AppLogger`, `AppHaptics`, `AppAlerts`, `AppValidators`)
/// - Networking (`ApiClient`, `ApiEndpoints`, `BaseRemoteDataSource`, `TokenStore`)
/// - Layout Tokens (`AppSpacing`)
/// - Errors & Exceptions (`ServerException`, `NetworkException`, etc.)
library;

export 'config/app_config.dart';
export 'constants/constants.dart';
export 'errors/exceptions.dart';
export 'localization/localization.dart';
export 'network/network.dart';
export 'responsive/responsive.dart';
export 'utils/utils.dart';
export 'widgets/widgets.dart';
