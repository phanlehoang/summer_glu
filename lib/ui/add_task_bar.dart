import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glucose_control/controllers/task_controller.dart';
import 'package:glucose_control/ui/theme.dart';
import 'package:glucose_control/ui/widgets/button.dart';
import 'package:glucose_control/ui/widgets/input_field.dart';
import 'package:intl/intl.dart';

import '../models/Task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime1 = '12hAM';
  final String _endTime2 = '18hPM';
  final String _endTime3 = '22hPM';
  String _startime1 = '6hAM';
  final String _startTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString();
  final String _endTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ["none", "dasily", "Weekly", "Monthly"];
  int _selectedColor = 0;
  final String _startime2 = '12hAM';
  final String _startime3 = '18hAM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: headingStyle,
              ),
              MyInputField(
                title: 'Title',
                hint: "Enter your title",
                controller: _titleController,
              ),
              MyInputField(
                title: 'Note',
                hint: "Enter your note",
                controller: _noteController,
              ),
              MyInputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    print('Hi There');
                    _getDataFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: MyInputField(
                    title: "Start Date",
                    hint: _startime1,
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(isStartTime: true);
                      },
                      icon: const Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  )),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: MyInputField(
                    title: "End Date",
                    hint: _endTime1,
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(isStartTime: false);
                      },
                      icon: const Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ))
                ],
              ),
              MyInputField(
                title: 'Remind',
                hint: '$_selectedRemind minutes early',
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              MyInputField(
                title: 'Repeat',
                hint: _selectedRepeat,
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  items:
                      repeatList.map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(
                        value!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Color',
                        style: titleStyle,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Wrap(
                        children: List<Widget>.generate(3, (int index) {
                          return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedColor = index;
                                  print('$index');
                                });
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor: index == 0
                                        ? primaryClr
                                        : index == 1
                                            ? pinkClr
                                            : yellowClr,
                                    child: _selectedColor == index
                                        ? const Icon(
                                            Icons.done,
                                            color: Colors.white,
                                            size: 16,
                                          )
                                        : Container(),
                                  )));
                        }),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  MyButton(label: 'Create Task', onTap: () => _validateDate())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDB();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Requireed", "All fields are required",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon: const Icon(
            Icons.warning,
            color: Colors.red,
          ));
    }
  }

  _addTaskToDB() async {
    int value = await _taskController.addTask(
        task: Task(
            note: _noteController.text,
            title: _titleController.text,
            date: DateFormat.yMd().format(_selectedDate),
            startTime: _startTime,
            endTime: _endTime,
            remind: _selectedRemind,
            repeat: _selectedRepeat,
            color: _selectedColor,
            isCompleted: 0));
    print("My id is" "$value");
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: const [
        CircleAvatar(backgroundImage: AssetImage('assets/images/profile.jpg')),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  _getDataFromUser() async {
    DateTime? _pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2200));
    if (_pickDate != null) {
      setState(() {
        _selectedDate = _pickDate;
        print(_selectedDate);
      });
    } else {
      print('null value');
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print('Time canceld');
    } else if (isStartTime == true) {
      setState(() {
        _startime1 = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime1 = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(':')[0]),
            minute: int.parse(_startTime.split(':')[1].split(" ")[0])));
  }
}
