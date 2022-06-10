import 'package:get/get.dart';
import 'package:glucose_control/db/db_helper.dart';
import 'package:glucose_control/models/Task.dart';
class TaskController extends GetxController{
  var taskList=<Task>[].obs;
  Future<int> addTask({Task?task})async{
    return await DBHelper.insert(task);
  }
  void getTasks() async{
    List<Map<String,dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data)=>Task.fromJson(data)).toList());
  }
}