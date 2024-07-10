import 'package:get/get.dart';
import 'package:smart_attend/app/data/network/models/response/user_model.dart';
import 'package:smart_attend/app/modules/base_get_x_controller.dart';
import 'package:smart_attend/app/routes/app_pages.dart';
import 'package:smart_attend/app/routes/route_manager.dart';
import 'package:smart_attend/app/utils/extensions/data_type_extension.dart';
import 'package:smart_attend/app/utils/extensions/storage_extension.dart';
import 'package:smart_attend/app/utils/utils.dart';

class RegistrationController extends BaseGetXController {
  final String tag = "RegistrationController";

  final errorMap = <String, String>{}.obs;
  var user = User().obs;

  @override
  void onInit() {
    super.onInit();
    listenEvents();
  }

  void listenEvents() {
    socket.setCallBack(tag, (data) async {
      if (data.eventName.equalsIgnoreCase("user_inserted") == true) {
        if (data.eventError.sIsNullOrEmpty == true) {
          var user = User.fromJson(data.eventData);
          storage.setUserData(user);
          offAllNamed(Routes.HOME);
        } else {
          showSnackBar(message: data.eventError?.toString() ?? "Something went wrong");
        }
      }
    });
  }

  bool isValidFields() {
    showLoading();
    errorMap.clear();

    if (user.value.name.sIsNullOrEmpty) {
      errorMap["name"] = "Please Enter Your Name";
    } else if (user.value.userId.sIsNullOrEmpty) {
      errorMap["userId"] = "Please Enter Your Id";
    } else if (user.value.password.sIsNullOrEmpty) {
      errorMap["password"] = "Please Enter Your Password";
    }

    if (errorMap.isEmpty) {
      registrationUser(user.value);
    } else {
      hideLoading();
    }
    return errorMap.isEmpty;
  }

  void registrationUser(User user) {
    user.professorCode = DateTime.now().millisecondsSinceEpoch.toString();
    socket.emmitEvent('insert_user', user.toJson().removeNull());
  }

  @override
  void onClose() {
    socket.removeCallBack(tag);
    super.onClose();
  }
}
