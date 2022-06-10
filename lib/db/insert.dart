import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RealtimeDatabaseInsert extends StatefulWidget {
  const RealtimeDatabaseInsert({Key? key}) : super(key: key);

  @override
  State<RealtimeDatabaseInsert> createState() => _RealtimeDatabaseInsertState();
}

class _RealtimeDatabaseInsertState extends State<RealtimeDatabaseInsert> {
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              'Insert Data',
              style: TextStyle(fontSize: 28),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                  labelText: 'Họ tên', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: genderController,
              decoration: const InputDecoration(
                  labelText: 'Giới tính', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: ageController,
              decoration: const InputDecoration(
                  labelText: 'Năm sinh', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: heightController,
              decoration: const InputDecoration(
                  labelText: 'Chiều cao', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: weightController,
              decoration: const InputDecoration(
                  labelText: 'Cân nặng', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 50,
            ),
            OutlinedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    genderController.text.isNotEmpty &&
                    ageController.text.isNotEmpty &&
                    heightController.text.isNotEmpty &&
                    weightController.text.isNotEmpty) {}
              },
              child: const Text(
                'Add',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void insertData(
      String name, String gender, String age, String height, String weight) {
    databaseRef.child("User").child("ListRegister").push().set({
      'Họ tên': name,
      'Giới tính': gender,
      'Năm sinh': age,
      'Chiều cao': height,
      'Cân nặng': weight
    });
    nameController.clear();
    genderController.clear();
    ageController.clear();
    heightController.clear();
    weightController.clear();
  }
}
