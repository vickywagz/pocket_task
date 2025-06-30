import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_task/models/task_model.dart';
import 'package:pocket_task/providers/task_provider.dart';

class EditTaskSheet extends ConsumerStatefulWidget {
  final Task task;

  const EditTaskSheet({super.key, required this.task});

  @override
  ConsumerState<EditTaskSheet> createState() => _EditTaskSheetState();
}

class _EditTaskSheetState extends ConsumerState<EditTaskSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;

  DateTime? _dueDate;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descController = TextEditingController(
      text: widget.task.description ?? '',
    );
    _dueDate = widget.task.dueDate;
    _selectedCategory = widget.task.category;
  }

  void _updateTask() {
    if (_formKey.currentState!.validate()) {
      widget.task.title = _titleController.text.trim();
      widget.task.description =
          _descController.text.trim().isEmpty
              ? null
              : _descController.text.trim();
      widget.task.dueDate = _dueDate;
      widget.task.category = _selectedCategory;

      ref
          .read(taskListProvider.notifier)
          .updateTask(widget.task); // ✅ notify state change
      Navigator.of(context).pop(); // ✅ close modal
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Edit Task",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator:
                    (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Required'
                            : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _dueDate == null
                          ? "No due date"
                          : "${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year}",
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _dueDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) setState(() => _dueDate = picked);
                    },
                    child: const Text("Pick Date"),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Category'),
                value: _selectedCategory,
                items: const [
                  DropdownMenuItem(value: 'Work', child: Text('Work')),
                  DropdownMenuItem(value: 'Personal', child: Text('Personal')),
                  DropdownMenuItem(value: 'Home', child: Text('Home')),
                  DropdownMenuItem(
                    value: 'Education',
                    child: Text('Education'),
                  ),
                ],
                onChanged: (value) => setState(() => _selectedCategory = value),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  minimumSize: const Size.fromHeight(40),
                ),
                child: const Text("Update Task"),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
