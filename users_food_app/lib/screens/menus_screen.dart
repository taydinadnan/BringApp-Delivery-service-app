import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_food_app/assistantMethods/assistant_methods.dart';
import 'package:users_food_app/widgets/design/menus_design.dart';

import '../models/menus.dart';
import '../models/sellers.dart';
import '../splash_screen/splash_screen.dart';
import '../widgets/progress_bar.dart';

class MenusScreen extends StatefulWidget {
  final Sellers? model;
  const MenusScreen({Key? key, this.model}) : super(key: key);

  @override
  _MenusScreenState createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
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
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            clearCartNow(context);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => const SplashScreen(),
              ),
            );

            Fluttertoast.showToast(msg: "Cart has been cleared.");
          },
        ),
        title: Text(
          widget.model!.sellerName.toString() + " Menus",
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 0,
      ),
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
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(widget.model!.sellerUID)
                  .collection("menus")
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
                        staggeredTileBuilder: (c) =>
                            const StaggeredTile.count(1, 1.5),
                        crossAxisCount: 2,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 0,
                        itemBuilder: (context, index) {
                          Menus model = Menus.fromJson(
                              snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MenusDesignWidget(
                              model: model,
                              context: context,
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
