import 'package:studiffy/core/base/base_prefernces.dart';
import 'package:studiffy/core/constant/constant.dart';

class PaymentPreference extends BasePreference<bool> {
  // SINGLETON ----------------------------------------------------------------

  static final PaymentPreference _instance = PaymentPreference._();

  static PaymentPreference get shared => _instance;

  PaymentPreference._();

  // END SINGLETON ------------------------------------------------------------

  @override
  String get key => paymentPrefrerenceKey;
}
