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
  ItemsScreen({this.model});

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(sellerUID: widget.model!.sellerUID),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextWidgetHeader(
              title: "Items of " + widget.model!.menuTitle.toString(),
            ),
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
                      staggeredTileBuilder: (c) => const StaggeredTile.fit(2),
                      crossAxisCount: 4,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 4,
                      itemBuilder: (context, index) {
                        Items model = Items.fromJson(snapshot.data!.docs[index]
                            .data()! as Map<String, dynamic>);
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
    );
  }
}
