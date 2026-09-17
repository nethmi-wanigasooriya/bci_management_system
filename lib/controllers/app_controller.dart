import 'package:flutter/material.dart';
import '../models/course.dart';
import '../models/employee.dart';
import '../models/student.dart';
import 'course_controller.dart';
import 'student_controller.dart';

class AppController extends ChangeNotifier {
  final StudentController _studentController = StudentController();
  final CourseController _courseController = CourseController();
  final List<Employee> _employees = [];

  // Getters
  List<Student> get students => _studentController.students;
  List<Course> get courses => _courseController.courses;
  List<Employee> get employees => List.unmodifiable(_employees);

  int get activeStudentCount => students.length;

  double get monthlyPayrollTotal =>
      _employees.fold(0.0, (sum, emp) => sum + emp.netSalary);

  // Delegate Actions to StudentController
  void addStudent(Student student) {
    _studentController.addStudent(student);
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
    _studentController.editStudent(id, name, email, program, intake, status);
    notifyListeners();
  }

  void deleteStudent(String id) {
    _studentController.deleteStudent(id);
    notifyListeners();
  }

  // Delegate Actions to CourseController
  void addCourse(String code, String title) {
    _courseController.addCourse(code, title);
    notifyListeners();
  }

  void editCourse(String id, String code, String title) {
    _courseController.editCourse(id, code, title);
    notifyListeners();
  }

  void deleteCourse(String id) {
    _courseController.deleteCourse(id);
    notifyListeners();
  }

  // Payroll / Employee Actions
  void addEmployee(Employee employee) {
    _employees.add(employee);
    notifyListeners();
  }

  void removeEmployee(String id) {
    _employees.removeWhere((emp) => emp.id == id);
    notifyListeners();
  }
}