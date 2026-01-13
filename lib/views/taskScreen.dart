import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revision/Constants/appTextStyles.dart';
import 'package:revision/Constants/colors.dart';
import 'package:revision/Provider/profileProvider.dart';
import 'package:revision/ReusableWidgets/bottomscroller.dart';
import 'package:revision/apiFetchDisplay/displayScreen.dart';
import 'package:revision/modals/profileModal.dart';
import 'package:revision/modals/taskModal.dart';
import 'package:revision/streamcountdown.dart';

class Taskscreen extends StatefulWidget {
  // final ProfileModal profile;

  const Taskscreen({
    super.key,
    //  required this.profile
  });

  @override
  State<Taskscreen> createState() => _TaskscreenState();
}

class _TaskscreenState extends State<Taskscreen> {
  late ProfileModal
  userprofile; //yeta 1 ta variable declare garerw init ma bolayo ke widget.profil.name garerw bolaunu parena
  List<TaskModal> tasks = [];

  @override
  void initState() {
    super.initState();
    // userprofile = widget.profile;
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Task App", style: AppTextStyles.headline1),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 217, 132, 84),
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // width: MediaQuery.of(context).size.width-20,
              width: MediaQuery.sizeOf(context).width - 20,
              padding: EdgeInsets.all(16), // Inner padding
              margin: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ), // Outer spacing
              decoration: BoxDecoration(
                color: AppColors.primary, // Card background
                borderRadius: BorderRadius.circular(12), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3), // Shadow color
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name: ${profile.name}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text("Age: ${profile.age}"),
                      SizedBox(height: 5),
                      Text("Address: ${profile.address}"),
                      SizedBox(height: 5),
                      if (profile.phoneNo != null)
                        Text("Phone No: ${profile.phoneNo}"),
                    ],
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CountDown()),
                );
              },
              child: Text("Show Products"),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDisplayScreen(),
                  ),
                );
              },
              child: Text("Show Products"),
            ),

            Center(child: Text("Task Area", style: AppTextStyles.headline2)),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: tasks.length,
                itemBuilder: (Context, index) {
                  final task = tasks[index];
                  return Card(
                    color: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 2,
                    child: ListTile(
                      key: ValueKey(task),
                      leading: Icon(Icons.task),
                      title: Text(task.taskName),
                      subtitle: Text(task.taskDescrption),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              final result = await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return AddOrUpdateScrollerState(
                                    task: tasks[index],
                                    index: index,
                                  );
                                },
                              );

                              if (result is Map<String, dynamic>) {
                                int updatedIndex = result["index"];
                                TaskModal updatedTaskModal = result["task"];
                                setState(() {
                                  tasks[updatedIndex] = updatedTaskModal;
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Try to add Task Again"),
                                  ),
                                );
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                tasks.removeAt(index);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Task deleted")),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return AddOrUpdateScrollerState(task: null, index: null);
            },
          );

          if (result != null) {
            if (result is TaskModal) {
              setState(() {
                tasks.add(result);
              });
            }
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Task added successfully!")));
          }
        },
      ),
    );
  }
}
