// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, deprecated_member_use, sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/signup_screen.dart';
import '../resources/auth_methods.dart';
import '../responsive/Responsive_Layou_Screent.dart';
import '../responsive/Web_Screen_Layout.dart';
import '../responsive/mobile_screen_layout.dart';
import '../utils.dart/colors.dart';
import '../utils.dart/utils.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => homeScreen()));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
          (route) => false);
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    }); //add 01:58
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            padding:
                // MediaQuery.of(context).size.width >
                //     ? EdgeInsets.symmetric(
                //         horizontal: MediaQuery.of(context).size.width / 3)
                const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Flexible(
                //   child: Container(),
                //   flex: 2,
                // ),
                // SvgPicture.asset(
                //   'assets/ic_instagram.svg',
                //   color: primaryColor,
                //   height: 64,
                // ),
                // const SizedBox(
                //   height: 64,
                // ),
                SizedBox(
                  height: 100,
                ),
                CircleAvatar(
                  radius: 130.0,
                  backgroundImage: AssetImage('images/11.jpg'),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15, top: 15),
                  child: Text(
                    'welcome',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
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
                // Password
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
                          prefixIcon:
                              Icon(Icons.person, color: Colors.grey[600]),
                        ))),

                InkWell(
                  onTap: loginUser, //add 01:58
                  //------------------------------------------------
                  child: Container(
                    child: _isLoading ////add at 01:50 loding when signup
                        //check if loading or not
                        ? Center(
                            child: CircularProgressIndicator(
                            color: primaryColor,
                          ))
                        : const Text('تسجيل دخول',
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
                  //------------------------------------------------------
                  // onTap: loginUser,
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 80, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(' ليس لديك حساب ؟',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 17)),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        ),
                        child: Text(
                          ' أفتح حساب الأن ',
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
