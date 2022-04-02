import 'package:flutter/material.dart';
import 'package:flutter_gallery/models/gallery_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Gallery'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GalleryItem> _galleryItemsInState = [];

  @override
  void initState() {
    super.initState();

    getGalleryData().then((galleryItems) => setState(() {
          _galleryItemsInState = galleryItems;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: ListView.builder(
            itemCount: _galleryItemsInState.length,
            itemBuilder: (context, index) {
              return Card(
                  child: TextButton(
                onPressed: () {
                  String image = _galleryItemsInState[index].imageFull;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScreenPhoto(
                            fullPhoto: image,
                          )));
                },
                child: ListTile(
                  title: Text('${_galleryItemsInState[index].date}'),
                  leading: Image.network(
                      '${_galleryItemsInState[index].imageThumb}'),
                ),
              ));
            }));
  }
  // return Center(
  //   child: CircularProgressIndicator(),
}

class ScreenPhoto extends StatelessWidget {
  final String fullPhoto;
  ScreenPhoto({required this.fullPhoto});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Photo')),
      body: Center(
        child: Image.network(fullPhoto),
      ),
    );
  }
}
