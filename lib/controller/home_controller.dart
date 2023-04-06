import 'package:get/get.dart';
import '../pages/overview_page.dart';
import '../services/login_service.dart';


class HomeController extends GetxController {
  static HomeController get to => Get.find<HomeController>();

  var szInputUserName = ''.obs;

  @override
  void onReady() {
    _getStoredUser();
    super.onReady();
  }

  void saveUserLocal() {
    if (szInputUserName.isNotEmpty) {
      if (LoginService().saveLoginLocal(szInputUserName.value)) {
        //go to Habit Page
        Get.offAllNamed(OverviewPage.namedRoute);
      }
    }
    update();
  }
  
  void _getStoredUser() {
    var user  = LoginService().loadUserName();
    if(user != ''){
      Get.offAllNamed(OverviewPage.namedRoute);
    }
  }
}
