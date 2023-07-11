
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chat_screen.dart';

class MessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Messages',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder(
        stream: firestore.collection('Chats').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final chatDocs = snapshot.data!.docs;

            if (chatDocs.isNotEmpty) {
              return ListView.builder(
                itemCount: chatDocs.length,
                itemBuilder: (context, index) {
                  final chatDoc = chatDocs[index];
                  final collectionId =
                      chatDoc['receiver'] == currentUserUid
                          ? chatDoc['sender']
                          : chatDoc['receiver'];
                  final post_id = chatDoc['post_id'];
                  final chatData = chatDoc.data() as Map<String, dynamic>; 


                  final formattedTime = DateFormat('hh:mm a').format(
                      (chatData['last_message_time'] as Timestamp).toDate());

                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(chatData['profile_image']),
                      ),
                      title: Text(
                        chatData['user_name'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            chatData['last_message'],
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(formattedTime),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              collectionId: collectionId,
                              post_id: post_id,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  'No conversations found',
                  style: TextStyle(
                    color: Colors.indigo.shade400,
                    fontSize: 20,
                  ),
                ),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.indigo,
              ),
            );
          }
        },
      ),
    );
  }
}
