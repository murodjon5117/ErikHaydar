import 'package:erik_haydar/view/sceen/profile/widget/buttons.dart';

class PaymentModel {
  String name;
  PaymentType type;
  String icon;
  bool isSlected;
  PaymentModel(
      {required this.name,
      required this.type,
      required this.icon,
      required this.isSlected});
}
