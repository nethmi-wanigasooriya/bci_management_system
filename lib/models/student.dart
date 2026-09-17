class Student {
  final String id;
  final String name;
  final String email;
  final String program;
  final String intake;
  final String status;
  final List<String> enrolledCourseIds;

  const Student({
    required this.id,
    required this.name,
    required this.email,
    required this.program,
    required this.intake,
    required this.status,
    List<String>? enrolledCourseIds,
  }) : enrolledCourseIds = enrolledCourseIds ?? const [];

  Student copyWith({
    String? id,
    String? name,
    String? email,
    String? program,
    String? intake,
    String? status,
    List<String>? enrolledCourseIds,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      program: program ?? this.program,
      intake: intake ?? this.intake,
      status: status ?? this.status,
      enrolledCourseIds: enrolledCourseIds ?? List.from(this.enrolledCourseIds),
    );
  }
}