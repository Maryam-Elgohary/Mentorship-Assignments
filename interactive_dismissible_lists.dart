import 'package:flutter/material.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const TaskManager(),
    );
  }
}

class Task {
  String title;
  bool isDone;
  Task(this.title, {this.isDone = false});
}

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  List<Task> tasks = [
    Task("Complete Flutter assignment"),
    Task("Review Clean Architecture", isDone: true),
    Task("Practice widget catalog"),
  ];

  Task? _recentlyDeleted;
  int? _recentlyDeletedIndex;

  void _reorderTasks(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final task = tasks.removeAt(oldIndex);
      tasks.insert(newIndex, task);
    });
  }

  Future<void> _confirmDelete(
      BuildContext context, Task task, int index) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: Text("Delete '${task.title}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      _deleteTask(task, index);
    }
  }

  void _deleteTask(Task task, int index) {
    setState(() {
      _recentlyDeleted = task;
      _recentlyDeletedIndex = index;
      tasks.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("'${task.title}' deleted"),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: () {
            setState(() {
              if (_recentlyDeleted != null && _recentlyDeletedIndex != null) {
                tasks.insert(_recentlyDeletedIndex!, _recentlyDeleted!);
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Manager"),
        centerTitle: true,
      ),
      body: ReorderableListView.builder(
        itemCount: tasks.length,
        onReorder: _reorderTasks,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        buildDefaultDragHandles: false,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Dismissible(
            key: ValueKey(task.title),
            direction: DismissDirection.endToStart,
            confirmDismiss: (_) async {
              await _confirmDelete(context, task, index);
              return false;
            },
            background: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: Card(
              key: ValueKey("card_${task.title}"),
              margin: const EdgeInsets.symmetric(vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: ReorderableDragStartListener(
                  index: index,
                  child: const Icon(Icons.drag_handle),
                ),
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: task.isDone ? Colors.grey : Colors.black,
                  ),
                ),
                trailing: Checkbox(
                  value: task.isDone,
                  onChanged: (val) {
                    setState(() {
                      task.isDone = val ?? false;
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
