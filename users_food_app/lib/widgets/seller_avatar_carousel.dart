import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:users_food_app/widgets/progress_bar.dart';

class SellerCarouselWidget extends StatefulWidget {
  const SellerCarouselWidget({Key? key}) : super(key: key);

  @override
  State<SellerCarouselWidget> createState() => _SellerCarouselWidgetState();
}

class _SellerCarouselWidgetState extends State<SellerCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 200,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("sellers").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: circularProgress(),
            );
          }
          return CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * .1,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 400),
              autoPlayCurve: Curves.easeInCirc,
              enlargeCenterPage: true,
              scrollDirection: Axis.vertical,
            ),
            items: snapshot.data!.docs.map((document) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1,
                      offset: Offset(1, 3),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      document['sellerAvatarUrl'],
                      fit: BoxFit.fill,
                      height: 190,
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
