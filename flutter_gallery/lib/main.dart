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
  late Future<GalleryList> galleryList;

  @override
  void initState() {
    super.initState();
    galleryList = getGalleryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: FutureBuilder<GalleryList>(
            future: galleryList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.gallery_items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                              '${snapshot.data!.gallery_items[index].data}'),
                          leading: Image.network(
                              '${snapshot.data!.gallery_items[index].image}'),
                          isThreeLine: true,
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('error');
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
