

import 'package:app17000ft/base_client/app_exception.dart';
import 'package:app17000ft/helper/dialog_helper.dart';

mixin BaseController {
  void handleError(error) {
    hideLoading();
    if (error is AppException || error is NotFoundException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message);
    } else {
      DialogHelper.showErrorDialog(description: 'An error occurred.');
    }
  }

  void showLoading([String? message]) {
    DialogHelper.showLoading(message);
  }

  void hideLoading() {
    DialogHelper.hideLoading();
  }
}
