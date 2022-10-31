import 'package:admin_web_portal_seller_amazon_app/homeScreen/home_screen.dart';
import 'package:flutter/material.dart';

class NavAppBar extends StatefulWidget with PreferredSizeWidget {
  PreferredSizeWidget? preferredSizeWidget;

  NavAppBar({
    this.preferredSizeWidget,
  });

  @override
  State<NavAppBar> createState() => _AppBarWithCartBadgeState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => preferredSizeWidget == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
}

class _AppBarWithCartBadgeState extends State<NavAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.deepPurpleAccent,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
      ),
      title: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (c) => HomeScreen()),
          );
        },
        child: const Text(
          "iShop",
          style: TextStyle(
            fontSize: 24,
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      centerTitle: false,
      actions: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => HomeScreen()),
                  );
                },
                child: const Text(
                  "Home",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Text(
              "|",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Sellers PieChart",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Text(
              "|",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Users PieChart",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Text(
              "|",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
