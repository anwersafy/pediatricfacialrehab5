import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pediatricfacialrehab/widgets/component.dart';


import 'helper/assets_helper.dart';
import 'helper/colors.dart';


class Gallary extends StatefulWidget {


  @override
  State<Gallary> createState() => _GallaryState();
}

class _GallaryState extends State<Gallary> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        CLevelMain,
        'Gallary',
        context
      ),
      body: FutureBuilder(
        future: getImages(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return
              Text("Error appeared ${snapshot.error}");
          }

          if (snapshot.hasData) {
            if (snapshot.data == null) return const Text("Nothing to show");

            return snapshot.data!.length>0?
              GridView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => Card(
                child: Image.file(
                  File(snapshot.data![index],)
                )
              ), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            ):Center(child: Text('No Images Found'),);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),

    );
  }


  getImages() async {
    var box = await Hive.openBox('screenShotBox');
    List<dynamic>? pathImages = box.get('images');

    return pathImages;
  }


}