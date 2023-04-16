import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:users_food_app/widgets/app_bar.dart';
import 'package:users_food_app/widgets/design/items_design.dart';

import '../models/items.dart';
import '../models/menus.dart';
import '../widgets/progress_bar.dart';
import '../widgets/text_widget_header.dart';

class ItemsScreen extends StatefulWidget {
  final Menus? model;
  const ItemsScreen({Key? key, this.model}) : super(key: key);

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(sellerUID: widget.model!.sellerUID),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(-2.0, 0.0),
            end: FractionalOffset(5.0, -1.0),
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFAC898),
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: TextWidgetHeader(
                title: widget.model!.menuTitle.toString().toUpperCase() +
                    "'s Menu Items",
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(color: Colors.white, thickness: 2),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(widget.model!.sellerUID)
                  .collection("menus")
                  .doc(widget.model!.menuID)
                  .collection("items")
                  .orderBy("publishedDate", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: circularProgress(),
                        ),
                      )
                    : SliverStaggeredGrid.countBuilder(
                        staggeredTileBuilder: (c) =>
                            const StaggeredTile.count(1, 1.5),
                        crossAxisCount: 2,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 0,
                        itemBuilder: (context, index) {
                          Items model = Items.fromJson(
                              snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ItemsDesignWidget(
                              model: model,
                            ),
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
