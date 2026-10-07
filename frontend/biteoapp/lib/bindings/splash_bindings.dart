import 'package:biteoapp/controllers/splash_controller.dart';
import 'package:get/get.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    print("SplashBindings dependencies called");
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
