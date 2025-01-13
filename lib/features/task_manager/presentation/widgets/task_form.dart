import 'package:flutter/material.dart';

class TaskForm extends StatefulWidget {
  final String? initialTitle;
  final String? initialDescription;
  final DateTime? initialDueDate;
  final List<String> categories;
  final String? initialCategory;
  final void Function(
          String title, String description, DateTime dueDate, String category)
      onSubmit;

  const TaskForm({
    super.key,
    this.initialTitle,
    this.initialDescription,
    this.initialDueDate,
    required this.categories,
    this.initialCategory,
    required this.onSubmit,
  });

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late DateTime _dueDate;
  late String _category;

  @override
  void initState() {
    super.initState();
    _title = widget.initialTitle ?? '';
    _description = widget.initialDescription ?? '';
    _dueDate = widget.initialDueDate ?? DateTime.now();
    _category = widget.initialCategory ?? widget.categories.first;
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();
      widget.onSubmit(_title, _description, _dueDate, _category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: _title,
            decoration: const InputDecoration(labelText: "Title"),
            validator: (value) =>
                value?.isEmpty == true ? "Title is required." : null,
            onSaved: (value) => _title = value ?? '',
          ),
          TextFormField(
            initialValue: _description,
            decoration: const InputDecoration(labelText: "Description"),
            maxLines: 2,
            onSaved: (value) => _description = value ?? '',
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _category,
            items: widget.categories
                .map((category) => DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => _category = value);
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text("Save Task"),
          ),
        ],
      ),
    );
  }
}
