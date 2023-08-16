import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_management_app/utils/colors.dart';

class DeleteTaskDialog extends StatefulWidget {
  final String taskTitle;
  final String taskId;
  const DeleteTaskDialog(
      {super.key, required this.taskId, required this.taskTitle});

  @override
  State<DeleteTaskDialog> createState() => _DeleteTaskDialogState();
}

class _DeleteTaskDialogState extends State<DeleteTaskDialog> {
  @override
  Widget build(BuildContext context) {
    final colorUtils = ColorUtils();
    return AlertDialog(
      scrollable: true,
      title: Text(
        'Delete Task',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: colorUtils.darkBlueColor),
      ),
      content: SizedBox(
        child: Form(
            child: Column(
          children: [
            const Text(
              ' Are you sure you want to delete this task',
              style: TextStyle(fontSize: 14, color: CupertinoColors.black),
            ),
            const SizedBox(height: 18),
            Text(
              widget.taskTitle.toString(),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        )),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            child: const Text('Cancel')),
        ElevatedButton(
            onPressed: () {
              _deleteTask();
              Navigator.of(context, rootNavigator: true).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete')),
      ],
    );
  }

  Future _deleteTask() async {
    var collection = FirebaseFirestore.instance.collection('tasks');
    collection
        .doc(widget.taskId)
        .delete()
        .then(
          (_) => Fluttertoast.showToast(
              msg: 'Task Deleted Successfully',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 14.0),
        )
        .catchError(
          (error) => Fluttertoast.showToast(
              msg: "Failed: $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 14.0),
        );
  }
}
