import 'package:flutter/material.dart';
import '../state/bci_store.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.store});

  final BciStore store;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard Overview',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;
              return GridView.count(
                crossAxisCount: isWide ? 3 : 1,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isWide ? 1.5 : 2.5,
                children: [
                  _buildStatCard(
                    context,
                    title: 'Active Students',
                    value: store.activeStudentCount.toString(),
                    icon: Icons.school,
                    color: Colors.blue,
                  ),
                  _buildStatCard(
                    context,
                    title: 'Total Courses',
                    value: store.courses.length.toString(),
                    icon: Icons.book,
                    color: Colors.orange,
                  ),
                  _buildStatCard(
                    context,
                    title: 'Monthly Payroll',
                    value: 'Rs. ${store.monthlyPayrollTotal.toStringAsFixed(2)}',
                    icon: Icons.payments,
                    color: Colors.green,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 30),
          Text(
            'Quick Summary',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.people_outline, color: Colors.blue),
              title: const Text('Registered Employees'),
              trailing: Text(
                '${store.employees.length}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.class_outlined, color: Colors.orange),
              title: const Text('Available Programs/Courses'),
              trailing: Text(
                '${store.courses.length}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}