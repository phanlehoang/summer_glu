import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glucose_control/controllers/task_controller.dart';
import 'package:glucose_control/regimen/routetpn/multiple_checkbox_page.dart';
import 'package:glucose_control/service/theme_services.dart';
import 'package:glucose_control/ui/add_task_bar.dart';
import 'package:glucose_control/ui/theme.dart';
import 'package:glucose_control/ui/widgets/button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

DateTime _selectedDate = DateTime.now();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _showTasks(),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20),
            child: DatePicker(DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: primaryClr,
                selectedTextColor: Colors.white,
                dateTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                dayTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                monthTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ), onDateChange: (date) {
                  _selectedDate = date;
                }),
          ),
        ],
      ),
    );
  }
}

_addTaskBar() {
  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                'Today',
                style: headingStyle,
              )
            ],
          ),
        ),
        MyButton(
            label: '+ Nhiệm vụ',
            onTap: () async {
              await Get.to(() => const AddTaskPage());
              Get.put(TaskController()).getTasks();
            }),
        Flexible(
            child: Container(
                margin: EdgeInsets.only(left: 3),
                child: MyButton(
                    label: 'Kết quả theo dõi',
                    onTap: () async {
                      await Get.to(() => MultipleCheckBoxPage());
                    })))
      ],
    ),
  );
}

_appBar() {
  return AppBar(
    elevation: 0,
    leading: GestureDetector(
      onTap: () {
        ThemeService().switchTheme();
      },
      child: Icon(
        Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
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

_showTasks() {
  return Expanded(child: Obx(() {
    return ListView.builder(
        itemCount: Get.put(TaskController()).taskList.length + 7,
        itemBuilder: (_, index) {
          print(Get.put(TaskController()).taskList.length);
          return Container(
            width: 100,
            height: 50,
            color: Colors.green,
            margin: const EdgeInsets.only(bottom: 10),
          );
        });
  }));
}