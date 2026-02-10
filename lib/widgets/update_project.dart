import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_hub_design/models/project.dart';
import 'package:project_hub_design/viewmodels/project_view_model.dart';
import 'package:provider/provider.dart';

class UpdateProject extends StatefulWidget {
  final Project project;

  const UpdateProject({
    super.key,
    required this.project,
  });

  @override
  State<UpdateProject> createState() => _UpdateProjectState();
}

class _UpdateProjectState extends State<UpdateProject> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;

  DateTime? _selectedDate;
  double _progress = 0; // 0-100

  @override
  void initState() {
    super.initState();

    //  prefill values
    _titleCtrl = TextEditingController(text: widget.project.title);
    _selectedDate = widget.project.dateTime;

    // project.progress is 0..1 in your model → convert to 0..100 for slider
    _progress = (widget.project.progress * 100).clamp(0.0, 100.0);
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _submit() {
    final projectVm = context.read<ProjectViewModel>();

    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date')),
      );
      return;
    }

    final title = _titleCtrl.text.trim();
    final date = _selectedDate!;
    final progressPercent = _progress.roundToDouble(); // 0-100
    final String formatDate = DateFormat('yyyy-MM-dd').format(date);

    final StatusProject status;
    if (progressPercent == 0) {
      status = StatusProject.pending;
    } else if (progressPercent == 100) {
      status = StatusProject.completed;
    } else {
      status = StatusProject.active;
    }

    projectVm.updateProjectById(
      widget.project.id,     // ID is required
      title,
      formatDate,
      progressPercent,
      status,
    );

    if(!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Center(
              child: Text('Project updated!')
          )
      ),
    );

    Navigator.pop(context); // close update form
  }

  @override
  Widget build(BuildContext context) {
    final dateText = _selectedDate == null
        ? 'Select date'
        : DateFormat('yyyy-MM-dd').format(_selectedDate!);

    return Scaffold(
      appBar: AppBar(title: const Text('Update Project')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Title is required';
                  if (v.trim().length < 3) return 'Title must be at least 3 chars';
                  return null;
                },
              ),

              const SizedBox(height: 14),

              InkWell(
                onTap: _pickDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: Text(dateText)),
                      const Icon(Icons.calendar_month),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Text(
                'Progress: ${_progress.round()}%',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Slider(
                value: _progress,
                min: 0,
                max: 100,
                divisions: 100,
                label: '${_progress.round()}%',
                onChanged: (v) => setState(() => _progress = v),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _submit,
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
