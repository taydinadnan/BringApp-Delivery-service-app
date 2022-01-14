import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sellers_food_app/models/items.dart';
import 'package:sellers_food_app/upload_screens/items_upload_screen.dart';
import 'package:sellers_food_app/widgets/items_design.dart';
import 'package:sellers_food_app/widgets/my_drawer.dart';
import 'package:sellers_food_app/widgets/text_widget_header.dart';

import '../global/global.dart';
import '../models/menus.dart';
import '../widgets/progress_bar.dart';

class ItemsScreen extends StatefulWidget {
  final Menus? model;
  ItemsScreen({this.model});

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(3.0, -1.0),
              colors: [
                Color(0xFF004B8D),
                Color(0xFFffffff),
              ],
            ),
          ),
        ),
        title: Text(
          sharedPreferences!.getString("name")!,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontFamily: "Lobster",
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => ItemsUploadScreen(model: widget.model),
                ),
              );
            },
            icon: const Icon(
              Icons.library_add,
              color: Colors.orange,
            ),
          )
        ],
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextWidgetHeader(
                title: "My " + widget.model!.menuTitle.toString() + "'s Items"),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(sharedPreferences!.getString("uid"))
                .collection("menus")
                .doc(widget.model!.menuID)
                .collection("items")
                //ordering menus and items by publishing date (descending)
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
                      crossAxisCount: 1,
                      staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        Items model = Items.fromJson(snapshot.data!.docs[index]
                            .data()! as Map<String, dynamic>);
                        return ItemsDesign(
                          model: model,
                          context: context,
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
