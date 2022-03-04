import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidgetHeader extends SliverPersistentHeaderDelegate {
  String? title;
  TextWidgetHeader({
    this.title,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return InkWell(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(-1.0, 0.0),
            end: FractionalOffset(4.0, -1.0),
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFAC898),
            ],
          ),
        ),
        height: 80,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title!,
            maxLines: 2,
            textAlign: TextAlign.justify,
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
