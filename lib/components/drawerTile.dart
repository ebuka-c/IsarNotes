import 'package:flutter/material.dart';

class Drawertile extends StatelessWidget {
  const Drawertile({super.key, this.leading, required this.title, this.onTap});
  final IconData? leading;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: ListTile(leading: Icon(leading), title: Text(title), onTap: onTap),
    );
  }
}
