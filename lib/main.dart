import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:test_unsplash/model.dart';
import 'package:test_unsplash/image_page.dart';

void main() {
  runApp(
    MaterialApp(
      home: App(),
    ),
  );
}

class App extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<App> {
  Future<List<Model>> imgdata() async {
    const url =
        'https://api.unsplash.com/photos/?client_id=ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final modelJson = json.decode(response.body);
      return List<Model>.from(
        modelJson.map(
          (item) => Model.fromJson(item),
        ),
      );
    } else {
      return throw Exception('eeeee');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 131, 131, 131),
        title: const Center(child: Text('Image')),
      ),
      body: FutureBuilder<List<Model>>(
        future: imgdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return Center(
              child: Text('ERROR ${snapshot.error}'),
            );
          } else {
            return ImageSlider(imageDataList: snapshot.data!);
          }
        },
      ),
    );
  }
}

class ImageSlider extends StatelessWidget {
  final List<Model> imageDataList;
  const ImageSlider({super.key, required this.imageDataList});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: imageDataList.length,
      itemBuilder: (context, index) {
        final image = imageDataList[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                color: Color.fromARGB(255, 131, 131, 131),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          'asset/avatar_image.svg',
                        ),
                      ),
                    ),
                    Text(
                      image.user,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 251, 255, 0),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _openImage(context, image);
                  },
                  child: Image.network(image.photo),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

_openImage(BuildContext context, Model image) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ImageOpenPage(image: image),
    ),
  );
}
