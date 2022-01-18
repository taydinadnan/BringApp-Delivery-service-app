import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:users_food_app/widgets/my_drawer.dart';
import 'package:users_food_app/widgets/progress_bar.dart';
import 'package:users_food_app/widgets/text_widget_header.dart';

import '../models/sellers.dart';
import '../widgets/sellers_design.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final items = [
    "slider/0.jpg",
    "slider/1.jpg",
    "slider/2.jpg",
    "slider/3.jpg",
    "slider/4.jpg",
    "slider/5.jpg",
    "slider/6.jpg",
    "slider/7.jpg",
    "slider/8.jpg",
    "slider/9.jpg",
    "slider/10.jpg",
    "slider/11.jpg",
    "slider/12.jpg",
    "slider/13.jpg",
    "slider/14.jpg",
    "slider/15.jpg",
    "slider/16.jpg",
    "slider/17.jpg",
    "slider/18.jpg",
    "slider/19.jpg",
    "slider/20.jpg",
    "slider/21.jpg",
    "slider/22.jpg",
    "slider/23.jpg",
    "slider/24.jpg",
    "slider/25.jpg",
    "slider/26.jpg",
    "slider/27.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(3.0, -1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
              colors: [
                Color(0xFF004B8D),
                Color(0xFFffffff),
              ],
            ),
          ),
        ),
        title: const Text(
          "Restourants",
          style: TextStyle(
            fontSize: 45,
            fontFamily: "Signatra",
            letterSpacing: 3,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                //taking %20 height for the device
                height: MediaQuery.of(context).size.height * .3,
                //taking max width for the device
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * .2,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.9,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 500),
                    autoPlayCurve: Curves.decelerate,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.vertical,
                  ),
                  // displayin items
                  items: items.map(
                    (index) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(3.0, -1.0),
                                colors: [
                                  Color(0xFF004B8D),
                                  Color(0xFFffffff),
                                ],
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3,
                                  offset: Offset(2, 2),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Image.asset(
                                index,
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("sellers").snapshots(),
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
                        Sellers smodel = Sellers.fromJson(
                            snapshot.data!.docs[index].data()!
                                as Map<String, dynamic>);
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SellersDesignWidget(
                            model: smodel,
                            context: context,
                          ),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
            },
          )
        ],
      ),
    );
  }
}
