import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../state/bci_store.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key, this.store});

  final BciStore? store;

  void _showCourseDialog(BuildContext context, BciStore activeStore, {Course? course}) {
    final codeCtrl = TextEditingController(text: course?.code ?? '');
    final titleCtrl = TextEditingController(text: course?.title ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(course == null ? 'Add Course' : 'Edit Course'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: codeCtrl,
              decoration: const InputDecoration(labelText: 'Course Code'),
            ),
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'Course Title'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (course == null) {
                activeStore.addCourse(codeCtrl.text, titleCtrl.text);
              } else {
                activeStore.editCourse(course.id, codeCtrl.text, titleCtrl.text);
              }
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check if store is passed via constructor; if not, fallback to Provider
    final activeStore = store ?? context.watch<BciStore>();

    return Scaffold(
      appBar: AppBar(title: const Text('Course Management')),
      body: activeStore.courses.isEmpty
          ? const Center(child: Text('No courses found.'))
          : ListView.builder(
              itemCount: activeStore.courses.length,
              itemBuilder: (ctx, i) {
                final course = activeStore.courses[i];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      course.code.length > 3
                          ? course.code.substring(0, 3)
                          : course.code,
                    ),
                  ),
                  title: Text(course.title),
                  subtitle: Text('Code: ${course.code}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.grey),
                        onPressed: () =>
                            _showCourseDialog(context, activeStore, course: course),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => activeStore.deleteCourse(course.id),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCourseDialog(context, activeStore),
        child: const Icon(Icons.add),
      ),
    );
  }
}