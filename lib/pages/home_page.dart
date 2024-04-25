import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/config/theme/theme_provider.dart';
import 'package:myapp/database/habit_database.dart';
import 'package:myapp/models/habit.dart';
import 'package:myapp/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final textController = TextEditingController();
  
  void creatNewHabit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: 'Enter new habit',
            ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
              textController.clear();
            },
            child: const Text('Cancel'),
            ),
          MaterialButton(
            onPressed: () {
              String newHabitName = textController.text;

              context.read<HabitDatabase>().addHabit(newHabitName);
             
              Navigator.of(context).pop();

              textController.clear();
            },
            child: const Text('Add'),
            )
        ],
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton.extended(
      onPressed: creatNewHabit,
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      icon: const Icon(
        Icons.add,
        color: Colors.black,
        ),
      label: const Text(
        'Add',
        style: TextStyle(color: Colors.black,),
        ),
      )
    );
    
  }
}