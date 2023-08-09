import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Message{
  static void errororwarning(String taskname, String taskerrororwarning)
  {
    Get.snackbar(
      taskname,taskerrororwarning,
      backgroundColor: Colors.orangeAccent,
      titleText: Text(
          taskname,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
      ),
      messageText: Text(
        taskerrororwarning,
      style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white54
      ),
    )
    );
  }
}