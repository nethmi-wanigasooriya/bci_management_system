import 'package:flutter/material.dart';
import '../models/course.dart';
import '../services/course_service.dart';

class CourseController extends ChangeNotifier {
  final CourseService _courseService = CourseService();

  List<Course> get courses => _courseService.courses;

  void addCourse(String code, String title) {
    _courseService.addCourse(code, title);
    notifyListeners();
  }

  void editCourse(String id, String code, String title) {
    _courseService.editCourse(id, code, title);
    notifyListeners();
  }

  void deleteCourse(String id) {
    _courseService.deleteCourse(id);
    notifyListeners();
  }
}