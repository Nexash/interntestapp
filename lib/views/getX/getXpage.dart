import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revision/views/getX/getX.dart';

class CounterPage extends StatelessWidget {
  CounterPage({super.key});
  final CounterController controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> counter = ValueNotifier<int>(0);
    return Scaffold(
      appBar: AppBar(title: Text("counter with get x")),
      body: Column(
        children: [
          Obx(() {
            return Text("Reactive Count:${controller.reactiveCount.value}");
          }),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: controller.incrementReactive,
            child: Text("Increment Reactive(obx)"),
          ),
          SizedBox(height: 20),
          GetBuilder<CounterController>(
            builder: (controller) {
              return Text(
                "ManualCounrt:${controller.manualCount}",
                style: TextStyle(fontSize: 24),
              );
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: controller.incrementManual,
            child: Text("Increment Manual(GetBuilder)"),
          ),
          SizedBox(height: 20),
          ValueListenableBuilder(
            valueListenable: counter,
            builder: (BuildContext context, dynamic value, Widget? child) {
              return Text("valuelistener example: ${counter.value}");
            },
          ),

          FloatingActionButton(
            onPressed: () {
              counter.value++;
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
