import 'package:get/get.dart';

class CounterController extends GetxController {
  var reactiveCount = 0.obs;

  int manualCount = 0;

  void incrementReactive() {
    reactiveCount.value++;
  }

  void incrementManual() {
    manualCount++;
    update();
  }
}
