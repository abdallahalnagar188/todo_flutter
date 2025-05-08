import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/AppDateUtils.dart';
import 'package:todo_flutter/db/collections/tasks_collection.dart';
import 'package:todo_flutter/db/models/task.dart';
import 'package:todo_flutter/providers/auth_provider.dart';
import 'package:todo_flutter/ui/common/add_task_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_flutter/ui/common/dialog_utils.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var title = TextEditingController();
  var description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Container(
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
              Center(
                child: Text(
                  AppLocalizations.of(context)!.addNewTask,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),

              SizedBox(height: 24),
              AddTaskFormField(
                hint: AppLocalizations.of(context)!.enterYourTaskTitle,
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return AppLocalizations.of(context)!.enterYourTaskTitle;
                  }
                  return null;
                },
                controler: title,
              ),
              SizedBox(height: 24),
              AddTaskFormField(
                hint: AppLocalizations.of(context)!.enterYourTaskDiscretion,
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return AppLocalizations.of(
                      context,
                    )!.enterYourTaskDiscretion;
                  }
                  return null;
                },
                controler: description,
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.taskDate,
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
                            selectedDate == null
                                ? AppLocalizations.of(context)!.selectDate
                                : "${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}",
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
                          AppLocalizations.of(context)!.taskTime,
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
                            selectedTime == null
                                ? AppLocalizations.of(context)!.selectTime
                                : "${selectedTime?.hour}:${selectedTime?.minute}",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: Colors.blue.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    addTask();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.addTask,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime? selectedDate;

  void showDatePickerDialog() async {
    var date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: selectedDate ?? DateTime.now(),
    );
    if (date == null) return;
    setState(() {
      selectedDate = date;
    });
  }

  TimeOfDay? selectedTime;

  void showTimePickerDialog() async {
    var time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (time == null) {
      return;
    } else {
      setState(() {
        selectedTime = time;
      });
    }
  }

  bool isValidateTask() {
    bool isValid = true;
    if (formKey.currentState?.validate() == false) {
      isValid = false;
    }
    if (selectedDate == null) {
      showMessage(
        context,
        content: "please enter valid date",
        posButtonTitle: "ok",
      );
      isValid = false;
    }
    if (selectedTime == null) {
      showMessage(
        context,
        content: "please enter valid time",
        posButtonTitle: "ok",
      );
      isValid = false;
    }
    return isValid;
  }

  void addTask() async {
    var task = Task(
      title: title.text,
      description: description.text,
      date: selectedDate!.dateOnly(),
      time: selectedTime!.timeOnly(),
    );
    if (isValidateTask() == false) return;
    var authProvider = Provider.of<AppAuthProvider>(context,listen: false);
    var userId = authProvider.appUser!.authId ?? "";
    TasksCollection tasksCollection = TasksCollection();
    try {
      showLoading(context);
      var result = tasksCollection.createTask(userId, task);
      hideLoading(context);
      showMessage(
        context,
        content: "Task Added Successful",
        posButtonTitle: "ok",
        posButtonClick: () {
          Navigator.pop(context);
        },
      );
    } catch (e) {
      hideLoading(context);
      showMessage(context, content: e.toString(), posButtonTitle: "ok");
    }
  }
}
