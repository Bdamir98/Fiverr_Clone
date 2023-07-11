// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../utils.dart/Global_variables.dart';
// //import 'package:instagram_clone_flutter/providers/user_provider.dart';
// //import 'package:instagram_clone_flutter/utils/global_variable.dart';
// //import 'package:provider/provider.dart';

// class ResponsiveLayout extends StatefulWidget {
//   final Widget mobileScreenLayout;
//   final Widget webScreenLayout;
//   const ResponsiveLayout({
//     Key? key,
//     required this.mobileScreenLayout,
//     required this.webScreenLayout,
//   }) : super(key: key);

//   @override
//   State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
// }

// class _ResponsiveLayoutState extends State<ResponsiveLayout> {
//   @override
//   void initState() {
//     super.initState();
//     addData();
//   }

//   addData() async {
//     UserProvider _userProvider =
//         Provider.of<UserProvider>(context, listen: false);
//     await _userProvider.refreshUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       if (constraints.maxWidth > webScreenSize) {
//         // 600 can be changed to 900 if you want to display tablet screen with mobile screen layout
//         return widget.webScreenLayout;
//       }
//       return widget.mobileScreenLayout;
//     });
//   }
// }

//--------------------------
//convert at 02:44 to stateful widget
class ResponsiveLayout extends StatefulWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  //add at 02:44
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        return widget.webScreenLayout;
      }
      return widget.mobileScreenLayout;

      // 600 can be changed to 900 if you want to display tablet screen with mobile screen layout
    });
  }
}
