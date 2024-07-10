import 'package:get/get.dart';

import '../controllers/submit_professor_code_controller.dart';

class SubmitProfessorCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmitProfessorCodeController>(
      () => SubmitProfessorCodeController(),
    );
  }
}
