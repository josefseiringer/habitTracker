import 'package:get/get.dart';
import '../controller/overview_controller.dart';
import '../controller/home_controller.dart';

class SampleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<OverviewController>(() => OverviewController());
  }
  
}