
import 'package:star_home/values/dimens.dart';
import "package:flutter/material.dart";
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlockCard extends StatelessWidget {


  // final EventModal event;
  // const AccessoryCard({Key? key, required this.event}) : super(key: key);
  final String text1;
  const BlockCard({Key? key, text, required this.text1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: 200,
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Stack(alignment: Alignment.bottomLeft, children: [
          Hero(
              tag: "tag",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(AppDimens.eventCardRadius),
                  image: DecorationImage(
                    image: (CachedNetworkImageProvider("Image")),
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.eventCardRadius),
                color: Colors.white,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(.8),
                    ],
                    stops: const [
                      0.5,
                      1.0
                    ])),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            child: SizedBox(
              width: 250.w,
              child: Text(
                "Table Lamp",
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 20,
            child: Text(
              "Status : On!",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ),
          const Positioned(
            bottom: 15,
            right: 20,
            child: Text(
              "Type : light",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          )
        ]),
      ),
    );
  }
}
