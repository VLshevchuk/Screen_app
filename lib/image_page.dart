import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_unsplash/model.dart';

class ImageOpenPage extends StatelessWidget {
  final Model image;
  const ImageOpenPage({super.key, required this.image});
  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    double mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open the Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color.fromARGB(255, 131, 131, 131),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        width: mediaWidth * 0.3,
                        height: mediaHeight * 0.3,
                        'asset/avatar_image.svg',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    image.user,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Center(
              child: Image.network(
                image.photo,
              ),
            )
          ],
        ),
      ),
    );
  }
}
