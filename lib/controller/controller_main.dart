import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../model/model.dart';
import '../view/home/homescreen.dart';

class MyScreenController extends ChangeNotifier {
  final String dBNAME = 'student_database';
  List<StudentModel> studentListNot = <StudentModel>[];

  navigation(BuildContext context) async {
    await context.read<MyScreenController>().studentsRefresh();
    Future.delayed(const Duration(seconds: 3), () async {
      await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const MyHomePage()));
    });
  }

  Future<void> addStudents(StudentModel value) async {
    final db = await Hive.openBox(dBNAME);
    value.id = await db.add(value);
    await db.put(value.id, value);
    studentsRefresh();
    notifyListeners();
  }

  Future<void> editStudents(StudentModel value) async {
    final db = await Hive.openBox(dBNAME);

    db.put(value.id, value);
    notifyListeners();
    studentsRefresh();
  }

  Future<List<dynamic>> getAllData() async {
    final db = await Hive.openBox(dBNAME);

    return db.values.toList();
  }

  Future<void> studentsRefresh() async {
    studentListNot.clear();
    final allStudents = await getAllData();
    for (var element in allStudents) {
      studentListNot.add(element);
    }
    notifyListeners();
  }

  Future<void> deleteData(int? id) async {
    final db = await Hive.openBox(dBNAME);
    await db.delete(id);
    notifyListeners();
    studentsRefresh();
  }

  Future<void> searchStudents(String value) async {
    final alldata = await getAllData();
    studentListNot.clear();
    for (var element in alldata) {
      if (element.name.toLowerCase().contains(value.toLowerCase())) {
        studentListNot.add(element);
      }
    }
    notifyListeners();
  }

  String image = '';

  Future<void> pickImage() async {
   
    final imgFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    image = imgFile!.path;
   
    notifyListeners();
  }

  void clearimage() {
    image = '';
    notifyListeners();
  }

 
}
