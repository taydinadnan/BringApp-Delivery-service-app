import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:users_food_app/widgets/items_design.dart';

import '../models/items.dart';
import '../models/menus.dart';
import '../widgets/my_drawer.dart';
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
      drawer: MyDrawer(),
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
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (c) => MenusUploadScreen(),
                  //   ),
                  // );
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.orange,
                ),
              ),
              Positioned(
                child: Stack(
                  children: const [
                    Icon(
                      Icons.brightness_1,
                      size: 20,
                      color: Colors.green,
                    ),
                    Positioned(
                      top: 3,
                      right: 4,
                      child: Center(
                        child: Text(
                          "0",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
        title: const Text(
          "iFood",
          style: TextStyle(
            fontSize: 50,
            color: Colors.white,
            fontFamily: "Signatra",
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
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
