import 'package:flutter/material.dart';

import '../models/sellers.dart';

class InfoDesignWidget extends StatefulWidget {
  Sellers? model;
  BuildContext? context;

  InfoDesignWidget({this.context, this.model});

  @override
  _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
}

class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: SizedBox(
          height: 280,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(
                widget.model!.sellerAvatarUrl!,
                height: 210,
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
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              )
            ],
          ),
        ),
      ),
    );
  }
}
