import 'package:api_integration/Manager/dialog_manager.dart';

import '../services/app_exceptions.dart';

class BaseController {
  // handle error
  void handelError(error) {
    hideLoading();
    if (error is BadRequestException) {
      var message = error.message;
      DialogManager().showErrorDialog(
        title: 'Bad Request',
        description: message,
      );
    } else if (error is FetchDataException) {
      var message = error.message;
      DialogManager().showErrorDialog(
        title: 'Unable to process',
        description: message,
      );
    } else if (error is ApiNotRespondingException) {
      var message = 'Oops! It took longer to respond.';
      DialogManager().showErrorDialog(
        title: 'Api not responding',
        description: message,
      );
    } else if (error is UnauthorisedException) {
      var message = error.message;
      DialogManager().showErrorDialog(
        title: 'Unauthorised',
        description: message,
      );
    } else if (error is InvalidInputException) {
      var message = error.message;
      DialogManager().showErrorDialog(
        title: 'Invalid Input',
        description: message,
      );
    } else if (error is Exception) {
      var message = error.toString();
      DialogManager().showErrorDialog(
        title: 'Error',
        description: message,
      );
    } else if (error is Error) {
      var message = error.toString();
      DialogManager().showErrorDialog(
        title: 'Error',
        description: message,
      );
    } else {
      DialogManager().showErrorDialog(
        title: 'Error',
        description: 'Something went wrong',
      );
    }
  }

  // show loading
  showLoading([String? message]) {
    DialogManager.showLoading(message);
  }

  // hide loading
  hideLoading() {
    DialogManager.hideLoading();
  }
}
