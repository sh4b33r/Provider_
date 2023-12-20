import 'package:hive_flutter/hive_flutter.dart';
  part 'model.g.dart';

@HiveType(typeId: 0)
class StudentModel {

  @HiveField(0)
  int? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String age;
  
  @HiveField(3)
  String photo;

  @HiveField(4)
  String std;

  
  @HiveField(5)
  String place;


  StudentModel(
      { this.id,
        required this.name,
      required this.age,
      required this.photo,
      required this.std,
      required this.place
      
      });
}

