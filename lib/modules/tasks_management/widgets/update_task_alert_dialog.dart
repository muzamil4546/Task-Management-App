import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_management_app/utils/colors.dart';
import 'package:intl/intl.dart';

class UpdateTaskAlertDialog extends StatefulWidget {
  final String taskTitle, taskDesc, taskDate, taskStatus, taskId;
  final double screenHeight;
  final double screenWidth;
  const UpdateTaskAlertDialog({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.taskTitle,
    required this.taskDesc,
    required this.taskStatus,
    required this.taskDate,
    required this.taskId,
  });

  @override
  State<UpdateTaskAlertDialog> createState() => _UpdateTaskAlertDialogState();
}

class _UpdateTaskAlertDialogState extends State<UpdateTaskAlertDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  String selectedStatus = 'Pending';
  List<String> statusOptions = [
    'Pending',
    'In Progress',
    'Completed',
    'On Hold'
  ];

  @override
  void initState() {
    super.initState();
    titleController.text = widget.taskTitle;
    descriptionController.text = widget.taskDesc;
    dateController.text = widget.taskDate;
    selectedStatus = widget.taskStatus;
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
  }

  void updateStatus(String newValue) {
    setState(() {
      selectedStatus = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorUtils = ColorUtils();
    return AlertDialog(
      scrollable: true,
      title: Text(
        'Update Task',
        style: TextStyle(
            color: colorUtils.darkBlueColor, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: widget.screenHeight * .45,
        width: widget.screenWidth,
        child: Form(
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(width: 1.5, color: Colors.grey.shade500),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.5, color: colorUtils.buttonBorderColor),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 18),
                    icon: Icon(
                      CupertinoIcons.square_list,
                      color: colorUtils.buttonBorderColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: descriptionController,
                maxLines: 2,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Description',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(width: 1.5, color: Colors.grey.shade500),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.5, color: colorUtils.buttonBorderColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 18,
                  ),
                  icon: Icon(
                    CupertinoIcons.bubble_left_bubble_right,
                    color: colorUtils.buttonBorderColor,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: dateController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  hintText: 'Click to add date',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(width: 1.5, color: Colors.grey.shade500),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.5, color: colorUtils.buttonBorderColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 18,
                  ),
                  icon: Icon(
                    CupertinoIcons.calendar,
                    color: colorUtils.buttonBorderColor,
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2024),
                  );
                  if (pickedDate != null) {
                    print(pickedDate);
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                    print(formattedDate);
                    setState(() {
                      dateController.text = formattedDate;
                    });
                  } else {
                    print('Date is not selected');
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                onChanged: (newValue) {
                  updateStatus(newValue!);
                },
                items:
                    statusOptions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                }).toList(),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(width: 1.5, color: Colors.grey.shade500),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.5, color: colorUtils.buttonBorderColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  icon: Icon(
                    CupertinoIcons.check_mark_circled,
                    color: colorUtils.buttonBorderColor,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              colorUtils.orangeColor)),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        final taskTitle = titleController.text;
                        final taskDesc = descriptionController.text;
                        final taskDate = dateController.text;
                        final taskStatus = selectedStatus;
                        updateTask(taskTitle, taskDesc, taskDate, taskStatus);
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              colorUtils.darkBlueColor)),
                      child: const Text('Update Task'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future updateTask(
    String taskTitle,
    String taskDesc,
    String taskDate,
    String taskStatus,
  ) async {
    var collection = FirebaseFirestore.instance.collection('tasks');
    collection.doc(widget.taskId).update({
      'taskTitle': taskTitle,
      'taskDesc': taskDesc,
      'taskDate': taskDate,
      'taskStatus': taskStatus,
    }).then((_) => Fluttertoast.showToast(
          msg: 'Task updated successfully',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0,
        ).catchError((error) => Fluttertoast.showToast(
              msg: "Failed: $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 14.0,
            )));
  }
}
