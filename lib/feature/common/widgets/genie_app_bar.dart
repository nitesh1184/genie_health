import 'package:flutter/material.dart';

class GenieAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const GenieAppBar({
    super.key,
    required this.username,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.blue[700],
      title: Row(
        children: [
          const SizedBox(width: 8),
          Text("Welcome ", style: TextStyle(color: Colors.white, fontSize: 18)),
          Text(
            username,
            style: TextStyle(color: Colors.orangeAccent, fontSize: 18),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: InkWell(
            onTap: () {
              scaffoldKey.currentState?.openEndDrawer();
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
              child: Icon(Icons.person, color: Colors.blue[700]),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
