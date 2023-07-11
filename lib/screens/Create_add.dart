// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_Methods.dart';
import '../utils.dart/utils.dart';

class CreatAdd extends StatefulWidget {
  const CreatAdd({Key? key}) : super(key: key);

  @override
  _CreatAddState createState() => _CreatAddState();
}

class _CreatAddState extends State<CreatAdd> {
  Uint8List? _file; /////------------------??????????/
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _data1Controller = TextEditingController();
  final TextEditingController _data2Controller = TextEditingController();
  final TextEditingController _data3Controller = TextEditingController();
  final TextEditingController _data4Controller = TextEditingController();
  final TextEditingController _data5Controller = TextEditingController();

  List<Uint8List> uploadedImageList = [];

  _selectImage(BuildContext parentContext) async {
    if (uploadedImageList.length >= 5) {
      showSnackBar('Maximum limit rich', context);
      return;
    }
    await showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  uploadedImageList.add(await pickImage(
                    ImageSource.camera,
                  ));

                  setState(() {});
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();

                  // uploadedImageList.add(await pickImage(
                  //   ImageSource.gallery,
                  // ));
                  uploadedImageList =
                      await pickMultipleImage(ImageSource.gallery);

                  setState(() {});
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  String title1 = 'Post title';
  String title2 = 'Post title';
  String title3 = 'Post title';
  String title4 = 'Post title';
  String title5 = 'Post title';

  var a1;
  var a2;
  var a3;
  var a4;
  var a5;

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        _data1Controller.text,
        _data2Controller.text,
        _data3Controller.text,
        _data4Controller.text,
        _data5Controller.text,
        uploadedImageList,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar('Posted!', context);
        clearImage();
      } else {
        showSnackBar(res, context);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(e.toString(), context);
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _data1Controller.dispose();
    _data2Controller.dispose();
    _data3Controller.dispose();
    _data4Controller.dispose();
    _data5Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final UserProvider userProvider = Provider.of<UserProvider>(context);
    final user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        leadingWidth: 35,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.only(right: 20),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // centerTitle: false,
        // leadingWidth: 35,
        // actions: [
        //   // IconButton(
        //   //   //----------------------------------------------------
        //   //   icon: Icon(Icons.send),
        //   //   onPressed: () => postImage(user.uid, user.username, user.photoUrl),
        //   // ),
        // ],
        title: Text(
          'back',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: uploadedImageList.length,
                  itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                      width: 340,
                      height: 180,
                      color: Colors.blue,
                      child: Image.memory(
                        uploadedImageList[index],
                        fit: BoxFit.cover,
                        // width: 340,
                        // height: 180,
                      )
                      //Image.memory(_file!),
                      ),
                ),
              ),
              InkWell(
                onTap: () => _selectImage(context),
                child: Container(
                  margin: EdgeInsets.only(bottom: 5),
                  width: 100,
                  height: 30,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Add imagese',
                      //'إضافة صورة',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),
              //title1-------------------------------------------------------------
              ExpansionTile(
                collapsedBackgroundColor: Colors.white,
                backgroundColor: Colors.white,
                title: Text(title1),
                children: [
                  ListTile(
                      title: Text('Selection1'),
                      onTap: () {
                        setState(() {
                          title1 = 'Selection1';
                          a1 = title1;
                          _data1Controller.text = a1;
                        });
                      }),
                  ListTile(
                      title: Text('Selection2'),
                      onTap: () {
                        setState(() {
                          title1 = 'Selection2';
                          a1 = title1;
                          _data1Controller.text = a1;
                        });
                      }),
                  ListTile(
                      title: Text('Selection3'),
                      onTap: () {
                        setState(() {
                          title1 = 'Selection3';
                          a1 = title1;
                          _data1Controller.text = a1;
                        });
                      })
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 60, top: 10),
                    child: SizedBox(
                      child: Text(
                        'Description:',
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    //width: double.infinity,
                    //height: 120,

                    //margin: EdgeInsets.all(5),
                    color: Colors.cyan[50],
                    child: TextField(
                      onChanged: (value) {
                        _descriptionController.text = value;
                      },
                      //textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        //border: InputBorder.none,
                      ),
                      maxLines: 3, // number of text line
                      // maxLength: 2,
                    ),
                  ),
                  ExpansionTile(
                    collapsedBackgroundColor: Colors.white,
                    backgroundColor: Colors.white,
                    title: Text(title2),
                    children: [
                      ListTile(
                          title: Text('Selection1'),
                          onTap: () {
                            setState(() {
                              title2 = 'Selection1';
                              a2 = title2;
                              _data2Controller.text = a2;
                            });
                          }),
                      ListTile(
                          title: Text('Selection2'),
                          onTap: () {
                            setState(() {
                              title2 = 'Selection2';
                              a2 = title2;
                              _data2Controller.text = a2;
                            });
                          }),
                      ListTile(
                          title: Text('Selection3'),
                          onTap: () {
                            setState(() {
                              title2 = 'Selection3';
                              a2 = title2;
                              _data2Controller.text = a2;
                            });
                          })
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        postImage(user.uid, user.username, user.photoUrl),
                    // if ((messageText1 == null) && (messageText2 == null)) {
                    //   print('empty text');
                    // } else {
                    //   //Navigator.pop(context);
                    // }

                    child: Text('post'),
                  ),
                ],
              ),
              // width: 370,
              // height: 50,
              // margin: EdgeInsets.all(5),
              // color: Colors.green,
              // child: Center(
              //   child: Text('data'),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
