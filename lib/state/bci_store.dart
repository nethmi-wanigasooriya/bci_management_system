import 'package:flutter/material.dart';
import '../models/course.dart';
import '../models/employee.dart';
import '../models/student.dart';
import '../services/course_service.dart';
import '../services/student_service.dart';

class BciStore extends ChangeNotifier {
  final StudentService _studentService = StudentService();
  final CourseService _courseService = CourseService();

  final List<Employee> _employees = [];

  // Getters
  List<Student> get students => _studentService.students;
  List<Course> get courses => _courseService.courses;
  List<Employee> get employees => List.unmodifiable(_employees);

  int get activeStudentCount => students.length;

  
     double get monthlyPayrollTotal =>
    _employees.fold(0.0, (sum, emp) => sum + emp.netSalary);
  // Student Operations
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

  void removeStudent(String id) => deleteStudent(id);

  void toggleEnrollment(String studentId, String courseId) {
    notifyListeners();
  }

  List<Course> getCoursesForStudent(Student student) {
    return courses;
  }

  // Course Operations
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

  // Employee / Payroll Operations
  void addEmployee(Employee employee) {
    _employees.add(employee);
    notifyListeners();
  }

  void removeEmployee(String id) {
    _employees.removeWhere((emp) => emp.id == id);
    notifyListeners();
  }
}