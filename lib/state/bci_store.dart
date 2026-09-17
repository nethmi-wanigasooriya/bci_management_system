import 'package:flutter/foundation.dart';

import '../models/employee.dart';
import '../models/student.dart';
import '../models/course.dart';

class BciStore extends ChangeNotifier {
  // Existing Sample Students
  final List<Student> _students = <Student>[
    const Student(
      id: 'BCI-2026-001',
      name: 'Ayesha Perera',
      email: 'ayesha@students.bci.lk',
      program: 'BSc Software Engineering',
      intake: 'February 2026',
      status: 'Active',
    ),
    const Student(
      id: 'BCI-2026-002',
      name: 'Nimal Fernando',
      email: 'nimal@students.bci.lk',
      program: 'BSc Information Technology',
      intake: 'February 2026',
      status: 'Active',
    ),
    const Student(
      id: 'BCI-2025-118',
      name: 'Tharushi Silva',
      email: 'tharushi@students.bci.lk',
      program: 'BSc Computer Science',
      intake: 'September 2025',
      status: 'Active',
    ),
  ];

  // Existing Sample Employees
  final List<Employee> _employees = <Employee>[
    const Employee(
      id: 'EMP-001',
      name: 'Dr. Amal Jayasinghe',
      department: 'School of Computing',
      designation: 'Senior Lecturer',
      basicSalary: 185000,
      allowances: 35000,
      overtime: 12000,
      deductions: 8500,
      tax: 17500,
    ),
    const Employee(
      id: 'EMP-002',
      name: 'Rashmi Perera',
      department: 'Finance',
      designation: 'Finance Officer',
      basicSalary: 125000,
      allowances: 22000,
      overtime: 6500,
      deductions: 5000,
      tax: 9500,
    ),
    const Employee(
      id: 'EMP-003',
      name: 'Kamal Fernando',
      department: 'Administration',
      designation: 'Management Assistant',
      basicSalary: 95000,
      allowances: 18000,
      overtime: 8000,
      deductions: 3500,
      tax: 4200,
    ),
  ];

  // Sample Courses List
  final List<Course> _courses = <Course>[
    Course(id: 'C001', code: 'SE101', title: 'Software Engineering Fundamentals'),
    Course(id: 'C002', code: 'DB201', title: 'Database Management Systems'),
    Course(id: 'C003', code: 'MAD301', title: 'Mobile Application Development'),
  ];

  // Getters
  List<Student> get students => List<Student>.unmodifiable(_students);
  List<Employee> get employees => List<Employee>.unmodifiable(_employees);
  List<Course> get courses => List<Course>.unmodifiable(_courses);

  int get activeStudentCount =>
      _students.where((Student student) => student.status == 'Active').length;

  double get monthlyPayrollTotal => _employees.fold<double>(
        0,
        (double sum, Employee employee) => sum + employee.netSalary,
      );

  // ================= STUDENT CRUD =================

  void addStudent(Student student) {
    _students.add(student);
    notifyListeners();
  }

  void editStudent(String id, String name, String email, String program, String intake, String status) {
    final index = _students.indexWhere((s) => s.id == id);
    if (index != -1) {
      _students[index] = _students[index].copyWith(
        name: name,
        email: email,
        program: program,
        intake: intake,
        status: status,
      );
      notifyListeners();
    }
  }

  void removeStudent(String studentId) {
    _students.removeWhere((Student student) => student.id == studentId);
    notifyListeners();
  }

  // ================= COURSE CRUD =================

  void addCourse(String code, String title) {
    final newCourse = Course(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      code: code,
      title: title,
    );
    _courses.add(newCourse);
    notifyListeners();
  }

  void editCourse(String id, String newCode, String newTitle) {
    final index = _courses.indexWhere((c) => c.id == id);
    if (index != -1) {
      _courses[index] = _courses[index].copyWith(code: newCode, title: newTitle);
      notifyListeners();
    }
  }

  void deleteCourse(String id) {
    _courses.removeWhere((c) => c.id == id);
    for (var student in _students) {
      student.enrolledCourseIds.remove(id);
    }
    notifyListeners();
  }

  // ================= ENROLLMENT LOGIC =================

  void toggleEnrollment(String studentId, String courseId) {
    final student = _students.firstWhere((s) => s.id == studentId);
    if (student.enrolledCourseIds.contains(courseId)) {
      student.enrolledCourseIds.remove(courseId);
    } else {
      student.enrolledCourseIds.add(courseId);
    }
    notifyListeners();
  }

  List<Course> getCoursesForStudent(Student student) {
    return _courses.where((c) => student.enrolledCourseIds.contains(c.id)).toList();
  }

  // ================= EMPLOYEE ACTIONS =================

  void addEmployee(Employee employee) {
    _employees.add(employee);
    notifyListeners();
  }

  void removeEmployee(String employeeId) {
    _employees.removeWhere((Employee employee) => employee.id == employeeId);
    notifyListeners();
  }
}