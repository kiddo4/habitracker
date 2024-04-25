import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/config/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: CupertinoSwitch(
          value: Provider.of<ThemeProvider>(context).isDarkMode,
          onChanged: (value) => 
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme()
          ),
      );
  }
}