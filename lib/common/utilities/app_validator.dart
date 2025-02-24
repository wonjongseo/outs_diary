import 'package:get/get_utils/get_utils.dart';
import 'package:ours_log/common/utilities/app_snackbar.dart';
import 'package:ours_log/common/utilities/app_string.dart';

class AppValidator {
  static Duration defaultDuration = const Duration(milliseconds: 2000);
  static bool validateInputField(String label, String? value) {
    if (value == null || value!.isEmpty) {
      AppSnackbar.invaildTextFeildSnackBar(
        duration: defaultDuration,
        message: '$label${AppString.plzInput.tr}',
      );
      return false;
    }
    return true;
  }

  static bool validateStringTime(String time) {
    List<String> timeAndMinute = time.split(':');

    if (timeAndMinute.length != 2) {
      if (time.isEmpty) {
        AppSnackbar.invaildTextFeildSnackBar(
          duration: defaultDuration,
          message: AppString.plzInputCollectTime.tr,
        );
        return false;
      }
    }
    return true;
  }

  static bool validateSelectStringField(String label, String? value) {
    if (value == null || value.isEmpty) {
      AppSnackbar.invaildTextFeildSnackBar(
        duration: defaultDuration,
        message: '$label${AppString.plzSelect.tr}',
      );
      return false;
    }
    return true;
  }

  static bool validateSelectListField(String label, List? value) {
    if (value == null || value.isEmpty) {
      AppSnackbar.invaildTextFeildSnackBar(
        message: '$label을 하나 이상 선택해주세요',
        duration: defaultDuration,
      );
      return false;
    }
    return true;
  }
}
