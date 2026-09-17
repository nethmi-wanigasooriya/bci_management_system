class Course {
  final String id;
  final String code;
  final String title;

  Course({
    required this.id,
    required this.code,
    required this.title,
  });

  Course copyWith({
    String? id,
    String? code,
    String? title,
  }) {
    return Course(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
    );
  }
}