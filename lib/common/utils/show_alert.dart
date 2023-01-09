import 'package:travelgrid/common/constants/string_constants.dart';
import 'package:travelgrid/common/utils/loader_hud.dart';

class MetaAlert{

  static void showErrorAlert({
    String title = "",
    required String message,
    int duration = 2,
  }) {
    MetaProgressHUD.showAndDismiss(message);
    // Get.snackbar(
    //   title,
    //   message,
    //   backgroundColor: Colors.black,
    //   colorText: Colors.white,
    //   duration: Duration(seconds: duration),
    // );
  }


  static void showSuccessAlert({
    String title = "",
    required String message,
    int duration = 2,
  }) {
    MetaProgressHUD.showAndDismiss(message);
    // Get.snackbar(
    //   title,
    //   message,
    //   backgroundColor: Colors.black,
    //   colorText: Colors.white,
    //   duration: Duration(seconds: duration),
    // );
  }
}