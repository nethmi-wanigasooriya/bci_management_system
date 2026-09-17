import '../models/course.dart';

class CourseService {
  final List<Course> _courses = [];

  List<Course> get courses => List.unmodifiable(_courses);

  void addCourse(String code, String title) {
    final newCourse = Course(
      id: DateTime.now().toString(),
      code: code,
      title: title,
    );
    _courses.add(newCourse);
  }

  void editCourse(String id, String code, String title) {
    final index = _courses.indexWhere((c) => c.id == id);
    if (index != -1) {
      _courses[index] = Course(id: id, code: code, title: title);
    }
  }

  void deleteCourse(String id) {
    _courses.removeWhere((c) => c.id == id);
  }
}