import 'package:flutter_easyloading/flutter_easyloading.dart';

class MetaProgressHUD {
  /// dismiss hud
  static void dismiss() {
    EasyLoading.dismiss();
  }

  /// show hud with type and text
  static void showProgress(String text) {
    EasyLoading.showProgress(0, status: text);
  }

  /// show loading with text
  static void showLoading({required String text}) {
    EasyLoading.show(status: text, maskType: EasyLoadingMaskType.clear);
  }

  /// show success icon with text and dismiss automatic
  static void showSuccessAndDismiss({required String text}) async {
    EasyLoading.showSuccess(text,);
  }

  /// show error icon with text and dismiss automatic
  static void showErrorAndDismiss({required String text}) async {
    EasyLoading.showError(text);
  }

  /// update progress value and text when ProgressHudType = progress
  ///
  /// should call `show(ProgressHudType.progress, "Loading")` before use
  static void updateProgress(double progress, String text) {
    EasyLoading.showProgress(progress,
        status: text, maskType: EasyLoadingMaskType.clear);
  }

  /// show hud and dismiss automatically
  static Future showAndDismiss(String text) async {
    EasyLoading.showToast(text,toastPosition: EasyLoadingToastPosition.bottom);
  }
}