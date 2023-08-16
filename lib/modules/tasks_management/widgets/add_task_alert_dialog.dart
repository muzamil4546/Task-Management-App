import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management_app/utils/colors.dart';
import 'package:intl/intl.dart';

class AddTaskAlertDialog extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  const AddTaskAlertDialog(
      {super.key, required this.screenHeight, required this.screenWidth});

  @override
  State<AddTaskAlertDialog> createState() => _AddTaskAlertDialogState();
}

class _AddTaskAlertDialogState extends State<AddTaskAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  List<String> statusOptions = [
    'Pending',
    'In Progress',
    'Completed',
    'On Hold'
  ];
  String selectedStatus = 'Pending';

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void initState() {
    dateController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorUtils = ColorUtils();
    return AlertDialog(
      scrollable: true,
      title: Text(
        'Add New Task',
        style: TextStyle(
            color: colorUtils.darkBlueColor, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
      content: Container(
        height: widget.screenHeight * .55,
        width: widget.screenWidth,
        child: Form(
          autovalidateMode: AutovalidateMode.disabled,
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      width: 1.5,
                      color: Colors.red,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color: colorUtils.buttonBorderColor,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
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
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  icon: Icon(
                    CupertinoIcons.square_list,
                    color: colorUtils.buttonBorderColor,
                  ),
                ),
                validator: (taskTitle) {
                  if (taskTitle == null || taskTitle.isEmpty) {
                    return 'Title required';
                  }
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: descriptionController,
                maxLines: 2,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Description',
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1.5,
                        color: Colors.red,
                      )),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color: colorUtils.buttonBorderColor,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
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
                validator: (desc) {
                  if (desc == null || desc.isEmpty) {
                    return 'Description required';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: dateController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  hintText: 'Click to add date',
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        width: 1.5,
                        color: Colors.red,
                      )),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color: colorUtils.buttonBorderColor,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
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
                validator: (date) {
                  if (date == null || date.isEmpty) {
                    return 'Date required';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: selectedStatus,
                onChanged: (newValue) {
                  setState(() {
                    selectedStatus = newValue!;
                  });
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
                        if (_formKey.currentState!.validate()) {
                          final taskTitle = titleController.text;
                          final taskDesc = descriptionController.text;
                          final taskDate = dateController.text;
                          final taskStatus = selectedStatus;
                          _addTask(
                            taskTitle: taskTitle,
                            taskDesc: taskDesc,
                            taskDate: taskDate,
                            taskStatus: taskStatus,
                          );
                          Navigator.of(context, rootNavigator: true).pop();
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              colorUtils.darkBlueColor)),
                      child: const Text('Add Task'),
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

  void _addTask({
    required String taskTitle,
    required String taskDesc,
    required String taskDate,
    required String taskStatus,
  }) async {
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('tasks').add({
      'taskTitle': taskTitle,
      'taskDesc': taskDesc,
      'taskDate': taskDate,
      'taskStatus': taskStatus,
    });
    String taskId = docRef.id;
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskId)
        .update({'taskId': taskId});
    _clearAll();
  }

  void _clearAll() {
    titleController.text = '';
    descriptionController.text = '';
    descriptionController.text = '';
    dateController.text = '';
  }
}
