import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/model/task.model.dart';
import 'package:flutter_note/providers/user.provider.dart';
import 'package:flutter_note/screen/add-task.screen.dart';
import 'package:flutter_note/screen/profile.screen.dart';
import 'package:flutter_note/service/api.dart';
import 'package:flutter_note/widget/loading-indicator.widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List ${AppUser().user!.displayName!}'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () async {
              // signOut(context);
              await AppUser.instance.signOut();
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Task>>(
          stream: getTaskListStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Task> taskList = snapshot.data!;
              // taskList.sort((a,b)=>a.title.compareTo(b.title));
              return ListView(
                children: List.generate(
                  taskList.length,
                      (i) {
                    return TaskContainer(
                      task: taskList[i],
                      index: i,
                    );
                  },
                ),
              );
            } else
              return Container();
          }),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'delete',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Are you sure you want to delete all task?'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _bulkDelete(context);
                              },
                              child: Text('yes'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('No'),
                              style:
                              ElevatedButton.styleFrom(primary: Colors.red),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            },
            child: Icon(Icons.delete),
          ),
          SizedBox(width: 5),
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTaskScreen(),
                  ));
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                onTap: () {},
                title: Text('Profile'),
                leading: Icon(Icons.person),
              ),
              ListTile(
                onTap: () {},
                title: Text('Log Out'),
                leading: Icon(Icons.power_settings_new),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskContainer extends StatefulWidget {
  final Task task;
  final int index;

  TaskContainer({required this.task, required this.index});

  @override
  _TaskContainerState createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  bool editMode = false;

  late FormGroup form;

  @override
  void initState() {
    super.initState();
    form = FormGroup({
      'title': FormControl(value: widget.task.title),
      'description': FormControl(value: widget.task.description),
    });
  }

  Widget build(BuildContext context) {
    if (editMode)
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onLongPress: () {
            editMode = false;
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              color: widget.task.completed
                  ? Colors.green.shade50
                  : Colors.grey.shade200,
              border: Border.all(color: Colors.grey.shade300),
            ),
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: ReactiveForm(
              formGroup: form,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ReactiveTextField(
                          formControlName: 'title',
                          decoration: InputDecoration(
                            labelText: 'Title',
                          ),
                        ),
                        ReactiveTextField(
                          formControlName: 'description',
                          decoration: InputDecoration(
                            labelText: 'Description',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () async {
                            try {
                              LoadingIndicator.showLoadingDialog(context);
                              Task task = widget.task;
                              task.title = form.control('title').value;
                              task.description =
                                  form.control('description').value;

                              final result = await updateTask(task);
                              if (result) {
                                Navigator.pop(context);
                                editMode = false;
                                setState(() {});
                              } else
                                throw 'Unable to update task task';
                            } catch (e) {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(e.toString()),
                                  );
                                },
                              );
                            }
                          },
                          icon: Icon(
                            Icons.check,
                            color: Colors.green,
                          )),
                      IconButton(
                          onPressed: () {
                            editMode = false;
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.red,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    else
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            widget.task.completed = !widget.task.completed;
            updateTask(widget.task);
          },
          onLongPress: () {
            editMode = true;
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              color: widget.task.completed
                  ? Colors.green.shade50
                  : Colors.orange.shade200,
              border: Border.all(color: Colors.grey.shade300),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            decoration: !widget.task.completed
                                ? null
                                : TextDecoration.lineThrough),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.task.description,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.task.author,
                        style: TextStyle(fontSize: 20),
                      ),
                      widget.task.dueDate != null
                          ? Text(
                        widget.task.dueDateInString,
                        style: TextStyle(fontSize: 20),
                      )
                          : Container()
                    ],
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      print(widget.task.id);
                      if (widget.task.id != null)
                        await deleteTask(widget.task.id!);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

_bulkDelete(BuildContext context) async {
  {
    try {
      LoadingIndicator.showLoadingDialog(context);
      final result = await bulkDeleteTask();
      if (result) {
        Navigator.pop(context);
        Navigator.pop(context);
      } else
        throw 'Unable to update task task';
    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.toString()),
          );
        },
      );
    }
  }
}