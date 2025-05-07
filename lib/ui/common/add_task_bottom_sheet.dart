import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_flutter/ui/common/add_task_form_field.dart';
import 'package:todo_flutter/ui/common/app_utils.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 18),
          Text(
            "Add New Task",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          SizedBox(height: 24),
          AddTaskFormField(hint: "enter your task"),
          SizedBox(height: 24),
          AddTaskFormField(hint: "enter your discretion"),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Task Date",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 22),
                    InkWell(
                      onTap: () {
                        showDatePickerDialog();
                      },
                      child: Text(
                        "Select Date",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Task Time",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 22),
                    InkWell(
                      onTap: () {
                        showTimePickerDialog();
                      },
                      child: Text(
                        "Select Time",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          ElevatedButton(onPressed: () {}, child: Text("Add Task")),
        ],
      ),
    );
  }

  DateTime? selectedDate;

  void showDatePickerDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return DatePickerDialog(
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
        );
      },
    );
  }

  TimeOfDay? selectedTime;

  void showTimePickerDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return TimePickerDialog(initialTime: selectedTime ?? TimeOfDay.now());
      },
    );
  }
}
