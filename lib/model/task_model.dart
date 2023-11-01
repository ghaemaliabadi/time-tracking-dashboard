import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class TaskModel {
  String title;
  int length;
  Jalali time;

  TaskModel({
    required this.title,
    required this.length,
    required this.time
  });
}