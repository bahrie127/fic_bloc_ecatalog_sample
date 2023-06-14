import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecatalog/presentation/camera_page.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController? titleController;
  TextEditingController? priceController;
  TextEditingController? descriptionController;

  XFile? picture;

  void takePicture(XFile file) {
    picture = file;
    setState(() {});
  }

  @override
  void initState() {
    titleController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  Future<void> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (photo != null) {
      picture = photo;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            picture != null
                ? SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.file(File(picture!.path)))
                : Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(border: Border.all()),
                  ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await availableCameras().then((value) => Navigator.push(
                              context, MaterialPageRoute(builder: (_) {
                            return CameraPage(
                              takePicture: takePicture,
                              cameras: value,
                            );
                          })));
                    },
                    child: const Text('Camera')),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  child: const Text(
                    "Galery",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Submit'))
          ],
        ),
      ),
    );
  }
}
