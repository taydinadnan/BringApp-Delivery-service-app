import 'package:flutter/material.dart';
import 'package:users_food_app/screens/menus_screen.dart';

import '../../models/sellers.dart';

class SellersDesignWidget extends StatefulWidget {
  Sellers? model;
  BuildContext? context;

  SellersDesignWidget({this.context, this.model});

  @override
  _SellersDesignWidgetState createState() => _SellersDesignWidgetState();
}

class _SellersDesignWidgetState extends State<SellersDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: InkWell(
        splashColor: Colors.orange,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3,
                offset: Offset(2, 2),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Image.network(
                    widget.model!.sellerAvatarUrl!,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 1),
                  Text(
                    widget.model!.sellerName!,
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      fontFamily: "Acme",
                    ),
                  ),
                  Text(
                    widget.model!.sellerEmail!,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: "Acme",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => MenusScreen(model: widget.model),
            ),
          );
        },
      ),
    );
  }
}
