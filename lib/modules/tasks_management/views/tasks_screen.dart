import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/modules/tasks_management/widgets/delete_task_dialog.dart';
import 'package:task_management_app/modules/tasks_management/widgets/update_task_alert_dialog.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool showMore = false;
  final fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(20),
      child: StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('No tasks available');
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                Color taskColor = Colors.green;
                var taskStatus = data['taskStatus'];
                if (taskStatus == 'Pending') {
                  taskColor = Colors.lightBlue;
                } else if (taskStatus == 'In Progress') {
                  taskColor = Colors.orange;
                } else if (taskStatus == 'Completed') {
                  taskColor = Colors.green;
                } else if (taskStatus == 'On Hold') {
                  taskColor = Colors.red;
                }

                return Container(
                    margin: const EdgeInsets.only(bottom: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white70,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 10),
                      child: Row(children: [
                        Container(
                          width: 50,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: taskColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Text(
                              data['taskStatus'],
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: screenWidth * .48,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['taskTitle'],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                height: 50,
                                child: SingleChildScrollView(
                                  child: Text(
                                    data['taskDesc'],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(data['taskDate'],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Align(
                          alignment: Alignment.topRight,
                          child: PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onTap: () {
                                    String taskId = (data['taskId']);
                                    String taskTitle = (data['taskTitle']);
                                    String taskDesc = (data['taskDesc']);
                                    String taskDate = (data['taskDate']);
                                    Future.delayed(
                                        const Duration(seconds: 0),
                                        () => showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  UpdateTaskAlertDialog(
                                                      screenHeight:
                                                          screenHeight,
                                                      screenWidth: screenWidth,
                                                      taskTitle: taskTitle,
                                                      taskDesc: taskDesc,
                                                      taskStatus: taskStatus,
                                                      taskDate: taskDate,
                                                      taskId: taskId),
                                            ));
                                  },
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onTap: () {
                                    String taskId = (data['taskId']);
                                    String taskTitle = (data['taskTitle']);
                                    String taskDesc = (data['taskDesc']);
                                    String taskDate = (data['taskDate']);
                                    Future.delayed(
                                        const Duration(seconds: 0),
                                        () => showDialog(
                                            context: context,
                                            builder: (context) =>
                                                DeleteTaskDialog(
                                                  taskId: taskId,
                                                  taskTitle: taskTitle,
                                                )));
                                  },
                                )
                              ];
                            },
                          ),
                        )
                      ]),
                    ));
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
