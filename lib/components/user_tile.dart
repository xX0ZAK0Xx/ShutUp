import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  UserTile({super.key, required this.text, this.onTap});
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 12, left: 12, right: 12),
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            //----- icon -----
            SizedBox(width: 20,),
            Icon(Icons.person),
            SizedBox(width: 20,),

            //----- user name -----
            Text(text)
          ],
        ),
      ),
    );
  }
}
