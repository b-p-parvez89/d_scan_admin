import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('bannar').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Container(
            height: 150,
            width: size.width,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(15)),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 180,
            width: size.width,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(15)),
            child: Text("Loading...."),
          );
        }

        List<String> imageUrls = snapshot.data!.docs
            .map((DocumentSnapshot document) => document['image'] as String)
            .toList();

        return CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 16 / 7,
            enlargeCenterPage: true,
          ),
          items: imageUrls.map((url) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(url), fit: BoxFit.fill),
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
