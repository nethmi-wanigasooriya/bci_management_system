import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/student_service.dart';

class StudentController extends ChangeNotifier {
  final StudentService _studentService = StudentService();

  List<Student> get students => _studentService.students;

  void addStudent(Student student) {
    _studentService.addStudent(student);
    notifyListeners();
  }

  void editStudent(
    String id,
    String name,
    String email,
    String program,
    String intake,
    String status,
  ) {
    _studentService.editStudent(id, name, email, program, intake, status);
    notifyListeners();
  }

  void deleteStudent(String id) {
    _studentService.deleteStudent(id);
    notifyListeners();
  }
}