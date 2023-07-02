import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MemberDashboardScreen extends StatelessWidget {
  final CollectionReference committeesCollection =
      FirebaseFirestore.instance.collection('committees');

  MemberDashboardScreen({super.key});

  void changePassword(
      String memberId, String currentPassword, String newPassword) {
    // Code to change password for the member
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Member Dashboard'),
            ElevatedButton(
              onPressed: () {
                changePassword('memberId', 'currentPassword', 'newPassword');
              },
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
