// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// import '../../providers/chat_screen_expanded_details.dart';
// import '../ratings/accept_show_alert.dart';
// import '../ratings/decline_show_alert_dialogue.dart';
// import 'components/style.dart';
// import 'components/widget.dart';

// class ChatPage extends StatefulWidget {
//   final String collectionId;
//   final String post_id;

//   const ChatPage({Key? key, required this.collectionId, required this.post_id})
//       : super(key: key);

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   String? postData1;
//   String? postDescription;
//   String? username;
//   String? postId;
//   String? profImage;
//   String? status;
//   bool isExpanded = false;
//   bool isContainerVisible = true;
//   bool isTextFieldEnabled = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       final firestore = FirebaseFirestore.instance;
//       final postSnapshot =
//           await firestore.collection('posts').doc(widget.post_id).get();
//       final postData = postSnapshot.data() as Map<String, dynamic>?;

//       setState(() {
//         postData1 = postData?['data1'];
//         postDescription = postData?['description'];
//         postId = postData?['postId'];
//         profImage = postData?['profImage'];
//         username = postData?['username'];
//         status = postData?['status'];
//       });
//     } catch (error) {
//       print('Error fetching post data: $error');
//     }
//   }

//   var roomId;
//   @override
//   Widget build(BuildContext context) {
//     final firestore = FirebaseFirestore.instance;
//     return ChangeNotifierProvider(
//       create: (_) => ChatScreenProvider(),
//       child: Consumer<ChatScreenProvider>(
//         builder: (context, chatScreenProvider, _) {
//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: Color(0xff258C60),
//               title: Text(
//                 username ?? 'No Data',
//               ),
//               elevation: 0,
//               leading: IconButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   icon: const Icon(Icons.chevron_left)),
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Row(
//                     children: [
//                       IconButton(
//                           onPressed: () {}, icon: const Icon(Icons.phone)),
//                       IconButton(
//                           onPressed: () {}, icon: const Icon(Icons.search)),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             body: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ExpandList(context),
//                 Expanded(
//                   child: Container(
//                     decoration: Styles.friendsBox(),
//                     child: StreamBuilder(
//                         stream: firestore.collection('Chats').snapshots(),
//                         builder:
//                             (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                           if (snapshot.hasData) {
//                             if (snapshot.data!.docs.isNotEmpty) {
//                               List<QueryDocumentSnapshot?> allData = snapshot
//                                   .data!.docs
//                                   .where((element) =>
//                                       element['receiver']
//                                               .contains(widget.collectionId) &&
//                                           element['sender'].contains(
//                                               FirebaseAuth
//                                                   .instance.currentUser!.uid) ||
//                                       element['receiver'].contains(FirebaseAuth
//                                               .instance.currentUser!.uid) &&
//                                           element['sender']
//                                               .contains(widget.collectionId))
//                                   .toList();
//                               QueryDocumentSnapshot? data =
//                                   allData.isNotEmpty ? allData.first : null;
//                               if (data != null) {
//                                 roomId = data.id;
//                               }
//                               return data == null
//                                   ? Container()
//                                   : StreamBuilder(
//                                       stream: data.reference
//                                           .collection('messages')
//                                           .orderBy('datetime', descending: true)
//                                           .snapshots(),
//                                       builder: (context,
//                                           AsyncSnapshot<QuerySnapshot> snap) {
//                                         return !snap.hasData
//                                             ? Container()
//                                             : ListView.builder(
//                                                 itemCount:
//                                                     snap.data!.docs.length,
//                                                 reverse: true,
//                                                 itemBuilder: (context, i) {
//                                                   return ChatWidgets
//                                                       .messagesCard(
//                                                           snap.data!.docs[i]
//                                                                   ['sent_by'] ==
//                                                               FirebaseAuth
//                                                                   .instance
//                                                                   .currentUser!
//                                                                   .uid,
//                                                           snap.data!.docs[i]
//                                                               ['message'],
//                                                           DateFormat('hh:mm a')
//                                                               .format(snap
//                                                                   .data!
//                                                                   .docs[i][
//                                                                       'datetime']
//                                                                   .toDate()));
//                                                 },
//                                               );
//                                       });
//                             } else {
//                               return Center(
//                                 child: Text(
//                                   'No conversion found',
//                                   style: Styles.h1()
//                                       .copyWith(color: Colors.indigo.shade400),
//                                 ),
//                               );
//                             }
//                           } else {
//                             return const Center(
//                               child: CircularProgressIndicator(
//                                 color: Colors.indigo,
//                               ),
//                             );
//                           }
//                         }),
//                   ),
//                 ),
//                 Container(
//                   color: Colors.white,
//                   child: ChatWidgets.messageField(onSubmit: (controller) {
//                     if (controller.text.toString() != '') {
//                       if (status != 'progress') {
//                         if (roomId != null) {
//                           Map<String, dynamic> data = {
//                             'message': controller.text.trim(),
//                             'sent_by': FirebaseAuth.instance.currentUser!.uid,
//                             'datetime': DateTime.now(),
//                           };
//                           firestore.collection('Chats').doc(roomId).update({
//                             'last_message_time': DateTime.now(),
//                             'last_message': controller.text,
//                           });
//                           firestore
//                               .collection('Chats')
//                               .doc(roomId)
//                               .collection('messages')
//                               .add(data);
//                         } else {
//                           Map<String, dynamic> data = {
//                             'message': controller.text.trim(),
//                             'sent_by': FirebaseAuth.instance.currentUser!.uid,
//                             'datetime': DateTime.now(),
//                           };
//                           firestore.collection('Chats').add({
//                             'receiver': widget.collectionId,
//                             'status': '',
//                             'sender': FirebaseAuth.instance.currentUser!.uid,
//                             'user_name': username,
//                             'post_id': postId,
//                             'profile_image': profImage,
//                             'last_message': controller.text,
//                             'last_message_time': DateTime.now(),
//                           }).then((value) async {
//                             value.collection('messages').add(data);
//                           });
//                         }
//                       }
//                     }
//                     controller.clear();
//                   }),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Container ExpandList(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           // StreamBuilder(
//           //   stream: firestore
//           //       .collection('Chats')
//           //       .where('receiver', isEqualTo: widget.collectionId)
//           //       .snapshots(),
//           //   builder:
//           //       (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           //     if (snapshot.hasData) {
//           //       if (snapshot.data!.docs.isNotEmpty) {
//           //         //insert the expension list
//           //       } else {
//           //         return Center(
//           //           child: Text(
//           //             'No conversation found',
//           //             style: Styles.h1()
//           //                 .copyWith(color: Colors.indigo.shade400),
//           //           ),
//           //         );
//           //       }
//           //     } else {
//           //       return const Center(
//           //         child: CircularProgressIndicator(
//           //           color: Colors.indigo,
//           //         ),
//           //       );
//           //     }
//           //     return Container();
//           //   },
//           // )
//           Container(
//             color: Color.fromARGB(255, 247, 247, 247),
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Row(
//                 children: [
//                   InkWell(
//                     onTap: () async {
//                       acceptShowAlertDialog(context, postId!);
//                     },
//                     child: Container(
//                       width: 90,
//                       height: 40,
//                       color: Colors.green,
//                       child: Center(
//                         child: Text(
//                           'Accept',
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       // Update the status field of the Chats collection to "progress"
//                       FirebaseFirestore.instance
//                           .collection('Chats')
//                           .doc(roomId)
//                           .update({
//                         'status': 'progress',
//                       }).catchError((error) {
//                         print('Error updating status: $error');
//                       });
//                     },
//                     child: Container(
//                       width: 90,
//                       height: 40,
//                       color: Colors.blueAccent,
//                       child: Center(
//                         child: Text(
//                           'Continue',
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       declineShowAlertDialog(context, postId!);
//                     },
//                     child: Container(
//                       width: 90,
//                       height: 40,
//                       color: Colors.grey,
//                       child: Center(
//                         child: Text(
//                           'Decline',
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 30),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         isExpanded = !isExpanded;
//                       });
//                     },
//                     child: Icon(
//                       isExpanded
//                           ? Icons.keyboard_arrow_up
//                           : Icons.keyboard_arrow_down,
//                       size: 40,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (isExpanded)
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 247, 246, 246),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Matched',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     postData1 ?? 'No Data',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   Divider(),
//                   Text(
//                     'Description',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     postDescription ?? 'No Description',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   Divider(),
//                   Text(
//                     'Your Offer Includes',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.timer,
//                         color: Colors.green,
//                       ),
//                       Text(
//                         '2 Days Delivery',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/chat_screen_expanded_details.dart';
import '../ratings/accept_show_alert.dart';
import '../ratings/decline_show_alert_dialogue.dart';
import 'components/style.dart';
import 'components/widget.dart';

class ChatPage extends StatefulWidget {
  final String collectionId;
  final String post_id;

  const ChatPage({Key? key, required this.collectionId, required this.post_id})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String? postData1;
  String? postDescription;
  String? username;
  String? postId;
  String? profImage;
  String? status;
  bool isExpanded = false;
  bool isContainerVisible = true;
  bool isTextFieldEnabled = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final postSnapshot =
          await firestore.collection('posts').doc(widget.post_id).get();
      final postData = postSnapshot.data() as Map<String, dynamic>?;

      setState(() {
        postData1 = postData?['data1'];
        postDescription = postData?['description'];
        postId = postData?['postId'];
        profImage = postData?['profImage'];
        username = postData?['username'];
        status = postData?['status'];
      });

      print('status: $status');
    } catch (error) {
      print('Error fetching post data: $error');
    }
  }

  var roomId;

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    return ChangeNotifierProvider(
      create: (_) => ChatScreenProvider(),
      child: Consumer<ChatScreenProvider>(
        builder: (context, chatScreenProvider, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff258C60),
              title: Text(
                username ?? 'No Data',
              ),
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.chevron_left)),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.phone)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.search)),
                    ],
                  ),
                )
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpandList(context),
                Expanded(
                  child: Container(
                    decoration: Styles.friendsBox(),
                    child: StreamBuilder(
                        stream: firestore.collection('Chats').snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.docs.isNotEmpty) {
                              List<QueryDocumentSnapshot?> allData = snapshot
                                  .data!.docs
                                  .where((element) =>
                                      element['receiver']
                                              .contains(widget.collectionId) &&
                                          element['sender'].contains(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid) ||
                                      element['receiver'].contains(FirebaseAuth
                                              .instance.currentUser!.uid) &&
                                          element['sender']
                                              .contains(widget.collectionId))
                                  .toList();
                              QueryDocumentSnapshot? data =
                                  allData.isNotEmpty ? allData.first : null;
                              if (data != null) {
                                roomId = data.id;
                              }
                              return data == null
                                  ? Container()
                                  : StreamBuilder(
                                      stream: data.reference
                                          .collection('messages')
                                          .orderBy('datetime', descending: true)
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot> snap) {
                                        return !snap.hasData
                                            ? Container()
                                            : ListView.builder(
                                                itemCount:
                                                    snap.data!.docs.length,
                                                reverse: true,
                                                itemBuilder: (context, i) {
                                                  return ChatWidgets
                                                      .messagesCard(
                                                          snap.data!.docs[i]
                                                                  ['sent_by'] ==
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                          snap.data!.docs[i]
                                                              ['message'],
                                                          DateFormat('hh:mm a')
                                                              .format(snap
                                                                  .data!
                                                                  .docs[i][
                                                                      'datetime']
                                                                  .toDate()));
                                                },
                                              );
                                      });
                            } else {
                              return Center(
                                child: Text(
                                  'No conversion found',
                                  style: Styles.h1()
                                      .copyWith(color: Colors.indigo.shade400),
                                ),
                              );
                            }
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.indigo,
                              ),
                            );
                          }
                        }),
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Chats')
                      .doc(roomId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print('snapshot data ${snapshot.data?['status']}');
                      if (snapshot.data?['status'] == 'progress' ||
                          snapshot.data?['status'] == null) {
                        return Container(
                          color: Colors.white,
                          child:
                              ChatWidgets.messageField(onSubmit: (controller) {
                            if (controller.text.toString() != '') {
                              if (status != 'progress') {
                                if (roomId != null) {
                                  Map<String, dynamic> data = {
                                    'message': controller.text.trim(),
                                    'sent_by':
                                        FirebaseAuth.instance.currentUser!.uid,
                                    'datetime': DateTime.now(),
                                  };
                                  firestore
                                      .collection('Chats')
                                      .doc(roomId)
                                      .update({
                                    'last_message_time': DateTime.now(),
                                    'last_message': controller.text,
                                  });
                                  firestore
                                      .collection('Chats')
                                      .doc(roomId)
                                      .collection('messages')
                                      .add(data);
                                } else {
                                  Map<String, dynamic> data = {
                                    'message': controller.text.trim(),
                                    'sent_by':
                                        FirebaseAuth.instance.currentUser!.uid,
                                    'datetime': DateTime.now(),
                                  };
                                  firestore.collection('Chats').add({
                                    'receiver': widget.collectionId,
                                    'status': '',
                                    'sender':
                                        FirebaseAuth.instance.currentUser!.uid,
                                    'user_name': username,
                                    'post_id': postId,
                                    'profile_image': profImage,
                                    'last_message': controller.text,
                                    'last_message_time': DateTime.now(),
                                  }).then((value) async {
                                    value.collection('messages').add(data);
                                  });
                                }
                              }
                            }
                            controller.clear();
                          }),
                        );
                      } else {
                        return SizedBox();
                      }
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Container ExpandList(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // StreamBuilder(
          //   stream: firestore
          //       .collection('Chats')
          //       .where('receiver', isEqualTo: widget.collectionId)
          //       .snapshots(),
          //   builder:
          //       (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //     if (snapshot.hasData) {
          //       if (snapshot.data!.docs.isNotEmpty) {
          //         //insert the expension list
          //       } else {
          //         return Center(
          //           child: Text(
          //             'No conversation found',
          //             style: Styles.h1()
          //                 .copyWith(color: Colors.indigo.shade400),
          //           ),
          //         );
          //       }
          //     } else {
          //       return const Center(
          //         child: CircularProgressIndicator(
          //           color: Colors.indigo,
          //         ),
          //       );
          //     }
          //     return Container();
          //   },
          // )

          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Chats')
                .doc(roomId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('snapshot data ${snapshot.data?['status']}');
                if (snapshot.data?['status'] == 'progress' ||
                    snapshot.data?['status'] == null) {
                  return Container(
                    color: Color.fromARGB(255, 247, 247, 247),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              acceptShowAlertDialog(
                                context,
                                postId!,
                                roomId,
                                () {
                                  fetchData();
                                },
                              );
                            },
                            child: Container(
                              width: 90,
                              height: 40,
                              color: Colors.green,
                              child: Center(
                                child: Text(
                                  'Accept',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              // Update the status field of the Chats collection to "progress"
                              FirebaseFirestore.instance
                                  .collection('Chats')
                                  .doc(roomId)
                                  .update({
                                'status': 'progress',
                              }).catchError((error) {
                                print('Error updating status: $error');
                              });
                            },
                            child: Container(
                              width: 90,
                              height: 40,
                              color: Colors.blueAccent,
                              child: Center(
                                child: Text(
                                  'Continue',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () async {
                              declineShowAlertDialog(
                                context,
                                postId!,
                                roomId,
                                () {
                                  fetchData();
                                },
                              );
                            },
                            child: Container(
                              width: 90,
                              height: 40,
                              color: Colors.grey,
                              child: Center(
                                child: Text(
                                  'Decline',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 30),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              }
              return CircularProgressIndicator();
            },
          ),

          if (isExpanded)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 247, 246, 246),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Matched',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    postData1 ?? 'No Data',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Divider(),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    postDescription ?? 'No Description',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Divider(),
                  Text(
                    'Your Offer Includes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        color: Colors.green,
                      ),
                      Text(
                        '2 Days Delivery',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
