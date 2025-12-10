import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/task.dart';

class AddNewTask extends StatefulWidget {
  final String? id;
  final bool isEditMode;

  AddNewTask({
    this.id,
    required this.isEditMode,
  });

  @override
  _AddNewTaskState createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  Task? task;
  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;
  String? _inputDescription;

  final _formKey = GlobalKey<FormState>();

  void _pickUserDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _pickUserDueTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_selectedDate == null && _selectedTime != null) {
        _selectedDate = DateTime.now();
      }

      if (!widget.isEditMode) {
        Provider.of<TaskProvider>(context, listen: false).createNewTask(
          Task(
            id: DateTime.now().toString(),
            description: _inputDescription!,
            dueDate: _selectedDate,
            dueTime: _selectedTime,
          ),
        );
      } else {
        Provider.of<TaskProvider>(context, listen: false).editTask(
          Task(
            id: task!.id,
            description: _inputDescription!,
            dueDate: _selectedDate,
            dueTime: _selectedTime,
            isDone: task!.isDone,
          ),
        );
      }

      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.isEditMode) {
      task =
          Provider.of<TaskProvider>(context, listen: false).getById(widget.id!);

      _selectedDate = task!.dueDate;
      _selectedTime = task!.dueTime;
      _inputDescription = task!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Title", style: Theme.of(context).textTheme.titleMedium),
              TextFormField(
                initialValue: _inputDescription,
                decoration: InputDecoration(hintText: "Describe your task"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter some text";
                  }
                  return null;
                },
                onSaved: (value) => _inputDescription = value,
              ),
              SizedBox(height: 20),
              Text("Due date", style: Theme.of(context).textTheme.titleMedium),
              TextFormField(
                readOnly: true,
                onTap: _pickUserDueDate,
                decoration: InputDecoration(
                  hintText: _selectedDate == null
                      ? "Pick a date"
                      : DateFormat.yMMMd().format(_selectedDate!),
                ),
              ),
              SizedBox(height: 20),
              Text("Due time", style: Theme.of(context).textTheme.titleMedium),
              TextFormField(
                readOnly: true,
                onTap: _pickUserDueTime,
                decoration: InputDecoration(
                  hintText: _selectedTime == null
                      ? "Pick a time"
                      : _selectedTime!.format(context),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: _validateForm,
                  child: Text(
                    widget.isEditMode ? "EDIT TASK" : "ADD TASK",
                    style: TextStyle(
                      color: secondaryColor,
                      fontFamily: "Lato",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
