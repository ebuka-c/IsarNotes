import 'package:flutter/material.dart';

import '../pages/settingsPage.dart';
import 'drawerTile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          //header
          const DrawerHeader(child: Icon(Icons.edit)),
          Drawertile(
              leading: Icons.home,
              title: 'Notes',
              onTap: () {
                Navigator.pop(context);
              }),
          Drawertile(
              leading: Icons.settings,
              title: 'Settings',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Settingspage()));
              }),
        ],
      ),
    );
  }
}
