import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revision/Constants/colors.dart';
import 'package:revision/Provider/todoProvider.dart';
import 'package:revision/modals/taskModal.dart';

class AddOrUpdateScrollerState extends StatefulWidget {
  final TaskModal? task;
  final int? index;
  // final Function(String name, String desc, int? index) onSubmit;
  const AddOrUpdateScrollerState({
    super.key,
    this.task,
    this.index,

    // required this.onSubmit,
  });

  @override
  State<AddOrUpdateScrollerState> createState() =>
      _AddOrUpdateScrollerStateState();
}

class _AddOrUpdateScrollerStateState extends State<AddOrUpdateScrollerState> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    taskNameController.text = widget.task?.taskName ?? '';
    taskDescriptionController.text = widget.task?.taskDescrption ?? '';
  }

  void submitTask(BuildContext scaffoldContext) async {
    String taskname = taskNameController.text.trim();
    String taskDescription = taskDescriptionController.text.trim();
    bool iscompleted = false;

    if (taskname.isEmpty || taskDescription.isEmpty) {
      ScaffoldMessenger.of(
        scaffoldContext,
      ).showSnackBar(SnackBar(content: Text("Fill all fields.")));
      return;
    }

    TaskModal newTask = TaskModal(
      taskName: taskname,
      taskDescrption: taskDescription,
      isCompleted: iscompleted,
    );
    // Use provider
    final taskProvider = context.read<TaskProvider>();
    await taskProvider.addTask(newTask);

    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Task successfully added.")));
      Navigator.pop(context);
    }

    taskNameController.clear();
    taskDescriptionController.clear();
  }

  void updateTask(int index, BuildContext scaffoldContext) async {
    String taskname = taskNameController.text.trim();
    String taskDescription = taskDescriptionController.text.trim();

    if (taskname.isEmpty || taskDescription.isEmpty) {
      ScaffoldMessenger.of(
        scaffoldContext,
      ).showSnackBar(SnackBar(content: Text("Fill all fields.")));
      return;
    }

    TaskModal updatedTask = TaskModal(
      taskName: taskNameController.text.trim(),
      taskDescrption: taskDescriptionController.text.trim(),
    );

    // Use provider
    final taskProvider = context.read<TaskProvider>();
    await taskProvider.updateTask(index, updatedTask);

    Navigator.pop(context, {"index": index, "task": updatedTask});
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Task updated")));

    taskNameController.clear();
    taskDescriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final parentContext = context;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Task name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 8),

                  TextFormField(
                    controller: taskNameController,
                    decoration: InputDecoration(
                      labelText: "Enter Task name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter task name";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 15),

                  Text(
                    "Task Description",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 8),

                  TextFormField(
                    controller: taskDescriptionController,
                    decoration: InputDecoration(
                      labelText: "Enter Task description",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter task name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (widget.task == null || widget.index == null) {
                            submitTask(parentContext);
                          } else {
                            updateTask(widget.index!, parentContext);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("fill all fields")),
                          );
                        }
                      },
                      child: Text("Submit"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
