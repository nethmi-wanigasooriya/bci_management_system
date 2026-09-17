import 'package:flutter/material.dart';

import '../models/student.dart';
import '../state/bci_store.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key, required this.store});

  final BciStore store;

  void _showStudentDialog(BuildContext context, {Student? student}) {
    final nameCtrl = TextEditingController(text: student?.name ?? '');
    final emailCtrl = TextEditingController(text: student?.email ?? '');
    final programCtrl = TextEditingController(text: student?.program ?? '');
    final intakeCtrl = TextEditingController(text: student?.intake ?? 'February 2026');
    final statusCtrl = TextEditingController(text: student?.status ?? 'Active');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(student == null ? 'Add Student' : 'Edit Student'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
              TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
              TextField(controller: programCtrl, decoration: const InputDecoration(labelText: 'Program')),
              TextField(controller: intakeCtrl, decoration: const InputDecoration(labelText: 'Intake')),
              TextField(controller: statusCtrl, decoration: const InputDecoration(labelText: 'Status')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (student == null) {
                store.addStudent(Student(
                  id: 'BCI-2026-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                  name: nameCtrl.text,
                  email: emailCtrl.text,
                  program: programCtrl.text,
                  intake: intakeCtrl.text,
                  status: statusCtrl.text,
                ));
              } else {
                store.editStudent(
                  student.id,
                  nameCtrl.text,
                  emailCtrl.text,
                  programCtrl.text,
                  intakeCtrl.text,
                  statusCtrl.text,
                );
              }
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showEnrollmentDialog(BuildContext context, Student student) {
    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Enroll ${student.name}'),
              content: SizedBox(
                width: double.maxFinite,
                child: store.courses.isEmpty
                    ? const Text('No courses available. Please add courses first.')
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: store.courses.length,
                        itemBuilder: (context, i) {
                          final course = store.courses[i];
                          final isEnrolled = student.enrolledCourseIds.contains(course.id);
                          return CheckboxListTile(
                            title: Text(course.title),
                            subtitle: Text(course.code),
                            value: isEnrolled,
                            onChanged: (_) {
                              setState(() {
                                store.toggleEnrollment(student.id, course.id);
                              });
                            },
                          );
                        },
                      ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: store.students.isEmpty
          ? const Center(child: Text('No students found.'))
          : ListView.builder(
              itemCount: store.students.length,
              itemBuilder: (ctx, i) {
                final student = store.students[i];
                final assignedCourses = store.getCoursesForStudent(student);

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ExpansionTile(
                    title: Text(student.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${student.program} (${student.status})'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.school, color: Colors.blue),
                          onPressed: () => _showEnrollmentDialog(context, student),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.grey),
                          onPressed: () => _showStudentDialog(context, student: student),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => store.removeStudent(student.id),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email: ${student.email}'),
                            Text('Intake: ${student.intake}'),
                            const SizedBox(height: 8),
                            const Text('Assigned Courses:', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            if (assignedCourses.isEmpty)
                              const Text('No courses assigned yet.', style: TextStyle(color: Colors.grey))
                            else
                              Wrap(
                                spacing: 8.0,
                                children: assignedCourses
                                    .map((c) => Chip(label: Text('${c.code}: ${c.title}')))
                                    .toList(),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showStudentDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}