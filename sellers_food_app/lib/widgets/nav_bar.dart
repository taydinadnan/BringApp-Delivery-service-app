import 'package:flutter/material.dart';
import 'package:sellers_food_app/screens/history_screen.dart';
import 'package:sellers_food_app/screens/home_screen.dart';
import 'package:sellers_food_app/screens/new_orders_screen.dart';

import '../authentication/auth_screen.dart';
import '../global/global.dart';
import '../upload_screens/menus_upload_screen.dart';

class BottomNavBarFb5 extends StatelessWidget {
  final int selectedIndex;
  final TextEditingController _controller = TextEditingController();

  BottomNavBarFb5({
    required this.selectedIndex,
  });

  final primaryColor = Color(0xFFffbf00);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: primaryColor,
      child: SizedBox(
        height: 56,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconBottomBar(
                text: "Home",
                icon: Icons.home,
                selected: selectedIndex == 0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => HomeScreen()),
                    ),
                  );
                },
              ),
              IconBottomBar(
                  text: "New Orders",
                  icon: Icons.local_grocery_store_outlined,
                  selected: selectedIndex == 1,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => NewOrdersScreen()),
                      ),
                    );
                  }),
              IconBottomBar(
                  text: "Add",
                  icon: Icons.add,
                  selected: selectedIndex == 2,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => MenusUploadScreen()),
                      ),
                    );
                  }),
              IconBottomBar(
                  text: "History",
                  icon: Icons.history,
                  selected: selectedIndex == 3,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => HistoryScreen()),
                      ),
                    );
                  }),
              IconBottomBar(
                  text: "Logout",
                  icon: Icons.exit_to_app,
                  selected: selectedIndex == 4,
                  onPressed: () {
                    firebaseAuth.signOut().then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => AuthScreen(),
                        ),
                      );
                      _controller.clear();
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  final accentColor = const Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon,
              size: 25,
              color: selected ? accentColor : Colors.black.withOpacity(0.7)),
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 12,
              height: .1,
              color: selected ? accentColor : Colors.black.withOpacity(0.7)),
        )
      ],
    );
  }
}
