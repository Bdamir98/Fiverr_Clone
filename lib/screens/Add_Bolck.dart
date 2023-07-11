// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Add_Block_DetailsScreen.dart';

class PostBlock extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>>? data;
  final String collectionId;

  const PostBlock({super.key, required this.data, required this.collectionId});

  @override
  State<PostBlock> createState() => _PostBlockState();
}

class _PostBlockState extends State<PostBlock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150.0,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBlockDetailsScreen(
                    collectionId: widget.collectionId,
                    data: widget.data,
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                    height: 136.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[200],
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 10,
                              color: Colors.black12)
                        ])),
                Positioned(
                  top: 20.0,
                  left: 0.0,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      widget.data!['profImage'].toString(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 20.0,
                  child: SizedBox(
                    height: 140.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // color: Colors.blue,
                          height: 70,
                          width: 270,
                          padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                          child: Text(widget.data!['data1'],
                              style: TextStyle(
                                  fontSize: 17, color: Colors.black87)),
                        ),
                        Container(
                          height: 55,
                          width: 180,
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(5, 5, 15, 5),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Center(
                              child: Text(
                                '########...',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
