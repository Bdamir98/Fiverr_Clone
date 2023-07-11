import 'package:flutter/material.dart';

class Styles {
  static TextStyle h1() {
    return const TextStyle(
        fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white);
  }

  static friendsBox() {
    return const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)));
  }

  static messagesCardStyle(check) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: check ? Color(0xff258C60): Colors.grey.shade300,
    );
  }

  static messageFieldCardStyle() {
    return BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.indigo),
        borderRadius: BorderRadius.circular(30));
  }

  static messageTextFieldStyle({required Function() onSubmit, bool isButtonEnabled = true}) {
  return InputDecoration(
    border: InputBorder.none,
    hintText: 'Type Your Message',
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    suffixIcon: IconButton(
      onPressed: isButtonEnabled ? onSubmit : null,
      icon: const Icon(Icons.send),
      color: isButtonEnabled ? null : Colors.grey, // Set the color of the disabled button
    ),
  );
}
  static searchTextFieldStyle() {
    return InputDecoration(
      border: InputBorder.none,
      hintText: 'Enter Name',
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.search_rounded)),
    );
  }
}