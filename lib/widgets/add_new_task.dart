import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/task.dart';

class AddNewTask extends StatefulWidget {
  final String? id;
  final bool isEditMode;

  const AddNewTask({
    Key? key,
    this.id,
    required this.isEditMode,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddNewTaskState createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  late Task task;
  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;
  String? _inputDescription;

  final _formKey = GlobalKey<FormState>();

  void _pickUserDueDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _pickUserDueTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Jika user memilih waktu tapi tidak memilih hari
      if (_selectedDate == null && _selectedTime != null) {
        _selectedDate = DateTime.now();
      }

      final provider = Provider.of<TaskProvider>(context, listen: false);

      if (!widget.isEditMode) {
        provider.createNewTask(
          Task(
            id: DateTime.now().toString(),
            description: _inputDescription!,
            dueDate: _selectedDate,
            dueTime: _selectedTime,
          ),
        );
      } else {
        provider.editTask(
          Task(
            id: task.id,
            description: _inputDescription!,
            dueDate: _selectedDate,
            dueTime: _selectedTime,
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

      _selectedDate = task.dueDate;
      _selectedTime = task.dueTime;
      _inputDescription = task.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Title', style: textTheme.titleMedium),
              TextFormField(
                initialValue: _inputDescription,
                decoration: const InputDecoration(
                  hintText: 'Describe your task',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  _inputDescription = value;
                },
              ),
              const SizedBox(height: 20),

              // DATE ------------------------------------
              Text('Due date', style: textTheme.titleMedium),
              TextFormField(
                onTap: _pickUserDueDate,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: _selectedDate == null
                      ? 'Pick a due date'
                      : DateFormat.yMMMd().format(_selectedDate!),
                ),
              ),
              const SizedBox(height: 20),

              // TIME ------------------------------------
              Text('Due time', style: textTheme.titleMedium),
              TextFormField(
                onTap: _pickUserDueTime,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: _selectedTime == null
                      ? 'Pick a due time'
                      : _selectedTime!.format(context),
                ),
              ),

              const SizedBox(height: 20),

              // BUTTON -----------------------------------
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: _validateForm,
                  child: Text(
                    widget.isEditMode ? 'EDIT TASK' : 'ADD TASK',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontFamily: 'Lato',
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
