import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstScreenController extends GetxController {
  late TextEditingController nameTextController;
  late TextEditingController palindromeTextController;

  @override
  void onInit() {
    nameTextController = TextEditingController();
    palindromeTextController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    debugPrint('FirstScreenController onClose called');
    nameTextController.dispose();
    palindromeTextController.dispose();
    super.onClose();
  }

  bool isPalindrome(String text) {
    String cleanText = text.replaceAll(' ', '').toLowerCase();

    String reversedText = cleanText.split('').reversed.join('');

    return cleanText == reversedText;
  }

  void showPalindromeDialog(bool isPalindromeResult, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Palindrome Check'),
          content: Text(
            isPalindromeResult ? 'isPalindrome' : 'not palindrome',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
