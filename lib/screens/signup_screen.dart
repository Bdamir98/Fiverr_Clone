// // ignore_for_file: deprecated_member_use, sort_child_properties_last, prefer_final_fields, library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors

// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../resources/auth_methods.dart';
// import '../responsive/Responsive_Layou_Screent.dart';
// import '../responsive/Web_Screen_Layout.dart';
// import '../responsive/mobile_screen_layout.dart';
// import '../utils.dart/colors.dart';
// import '../utils.dart/utils.dart';
// import 'login_screen.dart';

// //تم الانشاء 56

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({Key? key}) : super(key: key);

//   @override
//   _SignupScreenState createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _bioController = TextEditingController();
//   bool _isLoading = false; //add at 01:50 loding when signup
//   Uint8List? _image;

//   @override
//   void dispose() {
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _usernameController.dispose();
//   }

//   // void signUpUser() async {
//   //   // set loading to true
//   //   setState(() {
//   //     _isLoading = true;
//   //   });

//   // signup user using our authmethodds
//   //add at 01:47
//   void signUpUser() async {
//     setState(() {
//       _isLoading = true;
//     });
//     ; //add at 01:50 loding when signup
//     String res = await AuthMethods().signUpUser(
//         email: _emailController.text,
//         password: _passwordController.text,
//         username: _usernameController.text,
//         bio: _bioController.text,
//         file: _image!);
//     setState(() {
//       _isLoading = false;
//     }); //add at 01:50 loding when signup

//     if (res != "success") {
//       showSnackBar(res, context); // add at 01:48
//       // navigate to the home screen
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => const ResponsiveLayout(
//             mobileScreenLayout: MobileScreenLayout(),
//             webScreenLayout: WebScreenLayout(),
//           ),
//         ),
//       );
//     } else {
//       // show the error
//     }
//   }
// //---------------------------------------------
// //تم الاستدعاء 01:26
// //------------------------------

//   selectImage() async {
//     Uint8List im = await pickImage(ImageSource.camera);
//     // set state because we need to display the image we selected on the circle avatar
//     setState(() {
//       _image = im;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         // resizeToAvoidBottomInset: false,
//         body: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 32),
//             width: double.infinity,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 //logo icon---------------------------------------------------------------------
//                 // SvgPicture.asset(
//                 //   'assets/ic_instagram.svg',
//                 //   color: primaryColor,
//                 //   height: 64,
//                 // ),
//                 const SizedBox(
//                   height: 60,
//                 ),
//                 //add profile image ------------------------------------------------------------
//                 Stack(
//                   children: [
//                     _image != null
//                         ? CircleAvatar(
//                             radius: 64,
//                             backgroundImage: MemoryImage(_image!),
//                             backgroundColor: Colors.white,
//                           )
//                         : const CircleAvatar(
//                             radius: 64,
//                             backgroundImage: NetworkImage(
//                                 'https://i.stack.imgur.com/l60Hf.png'),
//                             backgroundColor: Colors.white,
//                           ),
//                     //add image icon----------------------------------------------------------------
//                     Positioned(
//                       bottom: -10,
//                       left: 90,
//                       child: IconButton(
//                         onPressed: selectImage,
//                         icon: const Icon(Icons.add_a_photo),
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(bottom: 20),
//                   child: Text(
//                     'لنقم بإنشاء حساب لك...',
//                     style: TextStyle(fontSize: 22),
//                   ),
//                 ),
//                 //username data-----------------------------------------------------------------
//                 Container(
//                     margin: EdgeInsets.only(bottom: 15),
//                     padding: EdgeInsets.symmetric(horizontal: 4),
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                             width: 1, color: const Color.fromARGB(95, 0, 0, 0)),
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(20)),
//                     width: 366,
//                     child: TextField(
//                         onChanged: (value) {
//                           _emailController.text = value;
//                         },
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'أسم المستخدم :',
//                           hintStyle:
//                               TextStyle(fontSize: 18, color: Colors.black54),
//                           prefixIcon:
//                               Icon(Icons.person, color: Colors.grey[600]),
//                         ))),
//                 //email data--------------------------------------------------------------------

//                 Container(
//                     margin: EdgeInsets.only(bottom: 15),
//                     padding: EdgeInsets.symmetric(horizontal: 4),
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                             width: 1, color: const Color.fromARGB(95, 0, 0, 0)),
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(20)),
//                     width: 366,
//                     child: TextField(
//                         onChanged: (value) {
//                           _emailController.text = value;
//                         },
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'البريد الالكتروني :',
//                           hintStyle:
//                               TextStyle(fontSize: 18, color: Colors.black54),
//                           prefixIcon:
//                               Icon(Icons.email, color: Colors.grey[600]),
//                         ))),

//                 //password data-----------------------------------------------------------------

//                 Container(
//                     margin: EdgeInsets.only(bottom: 15),
//                     padding: EdgeInsets.symmetric(horizontal: 4),
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                             width: 1, color: const Color.fromARGB(95, 0, 0, 0)),
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(20)),
//                     width: 366,
//                     child: TextField(
//                         onChanged: (value) {
//                           _passwordController.text = value;
//                         },
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'كلمة المرور :',
//                           hintStyle:
//                               TextStyle(fontSize: 18, color: Colors.black54),
//                           prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
//                         ))),
//                 // //about me data-----------------------------------------------------------------
//                 Container(
//                     margin: EdgeInsets.only(bottom: 15),
//                     padding: EdgeInsets.symmetric(horizontal: 4),
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                             width: 1, color: const Color.fromARGB(95, 0, 0, 0)),
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(20)),
//                     width: 366,
//                     child: TextField(
//                         onChanged: (value) {
//                           _bioController.text = value;
//                         },
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'وصف عنك :',
//                           hintStyle:
//                               TextStyle(fontSize: 18, color: Colors.black54),
//                           prefixIcon:
//                               Icon(Icons.text_snippet, color: Colors.grey[600]),
//                         ))),
//                 //signup button -----------------------------------------------------------------
//                 InkWell(
//                   onTap: signUpUser, //added at 01:46
//                   // () async {
//                   //   String res = await AuthMethods().signUpUser(
//                   //     email: _emailController.text,
//                   //     password: _passwordController.text,
//                   //     username: _usernameController.text,
//                   //     file: _image!,
//                   //     bio: _bioController.text,
//                   //   );
//                   //   print(res);
//                   // },
//                   child: Container(
//                     child: _isLoading ////add at 01:50 loding when signup
//                         //check if loading or not
//                         ? Center(
//                             child: CircularProgressIndicator(
//                             color: primaryColor,
//                           ))
//                         : const Text('تسجيل الحساب',
//                             style: TextStyle(
//                                 color: textColor1,
//                                 fontSize:
//                                     18)), //add at 01:50 loding when signup

//                     width: double.infinity,
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     decoration: const ShapeDecoration(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(4)),
//                       ),
//                       color: Colors.blueGrey,
//                     ),
//                   ),
//                   // onTap: signUpUser,
//                 ),
//                 // const SizedBox(
//                 //   height: 12,
//                 // ),
//                 // Flexible(
//                 //   child: Container(),
//                 //   flex: 2,
//                 // ),
//                 //back to login screen --------- already have account-----------------------------------------------------------------
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 80, top: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         child: Text(
//                           ' هل لديك حساب ؟',
//                           style: TextStyle(color: Colors.black87, fontSize: 17),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 8),
//                       ),
//                       GestureDetector(
//                         onTap: () => Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => const LoginScreen(),
//                           ),
//                         ),
//                         child: Text(
//                           ' تسجيل الدخول الآن',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blue,
//                               fontSize: 17),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: deprecated_member_use, sort_child_properties_last, prefer_final_fields, library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../resources/auth_methods.dart';
import '../responsive/Responsive_Layou_Screent.dart';
import '../responsive/Web_Screen_Layout.dart';
import '../responsive/mobile_screen_layout.dart';
import '../utils.dart/colors.dart';
import '../utils.dart/utils.dart';
import 'login_screen.dart';

//تم الانشاء 56

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  String? selectedData;
  List<String> dropdownItems = ['data1', 'data2', 'data3', 'data4'];

  bool _isLoading = false; //add at 01:50 loding when signup
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  // void signUpUser() async {
  //   // set loading to true
  //   setState(() {
  //     _isLoading = true;
  //   });

  // signup user using our authmethodds
  //add at 01:47
  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    ; //add at 01:50 loding when signup
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
      category: selectedData ?? '',
    );
    setState(() {
      _isLoading = false;
    }); //add at 01:50 loding when signup

    if (res != "success") {
      showSnackBar(res, context); // add at 01:48
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      // show the error
    }
  }
//---------------------------------------------
//تم الاستدعاء 01:26
//------------------------------

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.camera);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //logo icon---------------------------------------------------------------------
                // SvgPicture.asset(
                //   'assets/ic_instagram.svg',
                //   color: primaryColor,
                //   height: 64,
                // ),
                const SizedBox(
                  height: 60,
                ),
                //add profile image ------------------------------------------------------------
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                            backgroundColor: Colors.white,
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://i.stack.imgur.com/l60Hf.png'),
                            backgroundColor: Colors.white,
                          ),
                    //add image icon----------------------------------------------------------------
                    Positioned(
                      bottom: -10,
                      left: 90,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'لنقم بإنشاء حساب لك...',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                //username data-----------------------------------------------------------------
                Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: const Color.fromARGB(95, 0, 0, 0)),
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20)),
                    width: 366,
                    child: TextField(
                        onChanged: (value) {
                          _emailController.text = value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'أسم المستخدم :',
                          hintStyle:
                              TextStyle(fontSize: 18, color: Colors.black54),
                          prefixIcon:
                              Icon(Icons.person, color: Colors.grey[600]),
                        ))),
                //email data--------------------------------------------------------------------

                Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: const Color.fromARGB(95, 0, 0, 0)),
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20)),
                    width: 366,
                    child: TextField(
                        onChanged: (value) {
                          _emailController.text = value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'البريد الالكتروني :',
                          hintStyle:
                              TextStyle(fontSize: 18, color: Colors.black54),
                          prefixIcon:
                              Icon(Icons.email, color: Colors.grey[600]),
                        ))),

                //password data-----------------------------------------------------------------

                Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: const Color.fromARGB(95, 0, 0, 0)),
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20)),
                    width: 366,
                    child: TextField(
                        onChanged: (value) {
                          _passwordController.text = value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'كلمة المرور :',
                          hintStyle:
                              TextStyle(fontSize: 18, color: Colors.black54),
                          prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
                        ))),
                // //about me data-----------------------------------------------------------------
                Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: const Color.fromARGB(95, 0, 0, 0)),
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20)),
                    width: 366,
                    child: TextField(
                        onChanged: (value) {
                          _bioController.text = value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'وصف عنك :',
                          hintStyle:
                              TextStyle(fontSize: 18, color: Colors.black54),
                          prefixIcon:
                              Icon(Icons.text_snippet, color: Colors.grey[600]),
                        ))),
                // Dropdown button
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color.fromARGB(95, 0, 0, 0),
                    ),
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 366,
                  child: DropdownButtonFormField<String>(
                    value: selectedData,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedData = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Select The Category',
                      hintStyle: TextStyle(fontSize: 18, color: Colors.black54),
                      prefixIcon: Icon(Icons.category, color: Colors.grey[600]),
                    ),
                    items: dropdownItems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                //signup button -----------------------------------------------------------------
                InkWell(
                  onTap: signUpUser, //added at 01:46
                  // () async {
                  //   String res = await AuthMethods().signUpUser(
                  //     email: _emailController.text,
                  //     password: _passwordController.text,
                  //     username: _usernameController.text,
                  //     file: _image!,
                  //     bio: _bioController.text,
                  //   );
                  //   print(res);
                  // },
                  child: Container(
                    child: _isLoading ////add at 01:50 loding when signup
                        //check if loading or not
                        ? Center(
                            child: CircularProgressIndicator(
                            color: primaryColor,
                          ))
                        : const Text('تسجيل الحساب',
                            style: TextStyle(
                                color: textColor1,
                                fontSize:
                                    18)), //add at 01:50 loding when signup

                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      color: Colors.blueGrey,
                    ),
                  ),
                  // onTap: signUpUser,
                ),
                // const SizedBox(
                //   height: 12,
                // ),
                // Flexible(
                //   child: Container(),
                //   flex: 2,
                // ),
                //back to login screen --------- already have account-----------------------------------------------------------------
                Padding(
                  padding: const EdgeInsets.only(bottom: 80, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          ' هل لديك حساب ؟',
                          style: TextStyle(color: Colors.black87, fontSize: 17),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        ),
                        child: Text(
                          ' تسجيل الدخول الآن',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
