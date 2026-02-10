import 'package:flutter/material.dart';
import 'package:project_hub_design/models/project.dart';
import 'package:intl/intl.dart';
import 'package:project_hub_design/viewmodels/project_view_model.dart';
import 'package:project_hub_design/widgets/update_project.dart';
import 'package:provider/provider.dart';

class CardDetailScreens extends StatelessWidget {
  final Project project;
  final VoidCallback? onDelete;

  const CardDetailScreens({
    super.key,
    required this.project,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final projectVm = context.watch<ProjectViewModel>();

    final liveProject = projectVm.project.firstWhere(
          (p) => p.id == project.id,
      orElse: () => project, // fallback
    );

    final date = DateFormat('yyyy-MMM-dd').format(liveProject.dateTime);
    final percent = (liveProject.progress * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Project Detail',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
            )
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'edit') {
                await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => UpdateProject(
                      project: liveProject,
                    ))
                );
              } else if (value == 'delete') {
                final confirm = await showConfirmDeleteDialog(context);
                if (confirm == true) {
                  onDelete?.call();
                  Navigator.pop(context); // go back after delete
                }
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'edit', child: Text('Edit')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(liveProject.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(
              'Date: $date',
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey[600]
                )
            ),
            const SizedBox(height: 8),
            Text(
                'Progress: $percent%',
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey[600]
                )
            ),
            const SizedBox(height: 8),
            Text(
                'Status: ${statusToText(liveProject.status)}',
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey[600]
                )
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool?> showConfirmDeleteDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete Project'),
        content: const Text('Are you sure you want to delete this project?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}

