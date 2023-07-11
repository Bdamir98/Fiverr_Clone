// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_returning_null_for_void, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String title11 = 'Categories select';
  List<String> categories = ['data1', 'data2', 'data3', 'data4'];
  TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.getUser;

//Price Service Average
    List<dynamic> priceService = user.price_service;
    int price_length = priceService.length;
    double price_sum = 0;
    priceService.forEach((price) {
      price_sum += double.parse(price.toString());
    });
    double price_average = price_sum / price_length;

//Time_Delivery Average
    List<dynamic> timeDelivery = user.time_delivery;
    int time_length = timeDelivery.length;
    double time_sum = 0;
    timeDelivery.forEach((time) {
      time_sum += double.parse(time.toString());
    });
    double time_average = time_sum / time_length;
// Required_Details Average
    List<dynamic> requiredDetails = user.required_details;
    int requiredLength = requiredDetails.length;
    double requiredSum = 0;
    requiredDetails.forEach((required) {
      requiredSum += double.parse(required.toString());
    });
    double requiredAverage = requiredSum / requiredLength;

// User_Behavior Average
    List<dynamic> userBehavior = user.user_behavior;
    int behaviorLength = userBehavior.length;
    double behaviorSum = 0;
    userBehavior.forEach((behavior) {
      behaviorSum += double.parse(behavior.toString());
    });
    double behaviorAverage = behaviorSum / behaviorLength;

    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.username),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(user.photoUrl),
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 6, 32, 53),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          ExpansionTile(
            collapsedBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            title: Text('User rate'),
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('User behavior'),
                    Text('${behaviorAverage.toStringAsFixed(2)}/5'),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Price of service'),
                    Text('${price_average.toStringAsFixed(2)}/5'),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Adid to the requiredd detalis'),
                    Text('${requiredAverage.toStringAsFixed(2)}/5'),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Time delivery'),
                    Text('${time_average.toStringAsFixed(2)}/5'),
                  ],
                ),
              )
            ],
          ),
          ExpansionTile(
            collapsedBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            title: Text('Categories select'),
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(user.category),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Update Category'),
                            content: DropdownButtonFormField<String>(
                              value: user.category,
                              onChanged: (String? newValue) {
                                _categoryController.text = newValue ?? '';
                              },
                              items: categories.map((String category) {
                                return DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                            ),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: Text('Update'),
                                onPressed: () async {
                                  String newCategory = _categoryController.text;
                                  // Update the category for the current user
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(user.uid)
                                        .update({
                                      'category': newCategory,
                                    });
                                  } catch (error) {}

                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorites'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Friends'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Request'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Policies'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            title: Text('Log Out'),
            leading: Icon(Icons.exit_to_app),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
