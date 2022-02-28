import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sellers_food_app/global/global.dart';
import 'package:sellers_food_app/widgets/my_drawer.dart';

import '../upload_screens/menus_upload_screen.dart';

class CustomAppBar extends StatelessWidget {
  final IconData? leftIcon;
  final IconData? rightIcon;
  final Function? leftCallBack;

  CustomAppBar({
    this.leftIcon,
    this.rightIcon,
    this.leftCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(-1.0, 0.0),
          end: FractionalOffset(5.0, -1.0),
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFFAC898),
          ],
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 25,
        right: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: _buildIcon(leftIcon!),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => MyDrawer())));
            },
          ),
          GestureDetector(
            child: _buildIcon(
              rightIcon!,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => MenusUploadScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.amber,
      ),
      child: Icon(icon),
    );
  }
}
