import '../models/student.dart';

class StudentService {
  final List<Student> _students = [];

  List<Student> get students => List.unmodifiable(_students);

  void addStudent(Student student) {
    _students.add(student);
  }

  void editStudent(
    String id,
    String name,
    String email,
    String program,
    String intake,
    String status,
  ) {
    final index = _students.indexWhere((s) => s.id == id);
    if (index != -1) {
      _students[index] = Student(
        id: id,
        name: name,
        email: email,
        program: program,
        intake: intake,
        status: status,
      );
    }
  }

  void deleteStudent(String id) {
    _students.removeWhere((s) => s.id == id);
  }
}