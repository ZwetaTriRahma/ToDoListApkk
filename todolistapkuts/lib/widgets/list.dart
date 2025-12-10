import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Pastikan path ini sesuai foldermu
import 'package:to_do_list/providers/task.dart';
import 'package:to_do_list/widgets/list_item.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskList = Provider.of<TaskProvider>(context).itemsList;

    return taskList.isNotEmpty
        ? ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return ListItem(taskList[index]); // tidak perlu casting
            },
          )
        : LayoutBuilder(
            builder: (ctx, constraints) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: constraints.maxHeight * 0.5,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'No tasks added yet...',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              );
            },
          );
  }
}
