import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commitee/user.dart';
import 'package:flutter/material.dart';

import 'commiteemember.dart';

class AdminDashboardScreen extends StatelessWidget {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference committeesCollection =
      FirebaseFirestore.instance.collection('committees');

  AdminDashboardScreen({super.key});

  void viewUsers() {
    usersCollection.get().then((querySnapshot) {
      // ignore: unused_local_variable
      for (var doc in querySnapshot.docs) {}
    });
  }

  void viewCommitteeMembers(String committeeId) {
    committeesCollection.doc(committeeId).get().then((doc) {
      if (doc.exists) {
        // print(doc.data()['members']);
      } else {}
    });
  }

  void acceptUserRequest(String userId) {
    usersCollection.doc(userId).update({
      'requestStatus': 'accepted',
    });
  }

  void rejectUserRequest(String userId) {
    usersCollection.doc(userId).update({
      'requestStatus': 'rejected',
    });
  }

  void sendNotificationToAll(String notification) {
    committeesCollection.get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        committeesCollection.doc(doc.id).update({
          'notification': notification,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Admin Dashboard'),
            ElevatedButton(
              onPressed: () {
                viewUsers();
              },
              child: const Text('View Users'),
            ),
            ElevatedButton(
              onPressed: () {
                viewCommitteeMembers('committeeId');
              },
              child: const Text('View Committee Members'),
            ),
            ElevatedButton(
              onPressed: () {
                acceptUserRequest('userId');
              },
              child: const Text('Accept User Request'),
            ),
            ElevatedButton(
              onPressed: () {
                rejectUserRequest('userId');
              },
              child: const Text('Reject User Request'),
            ),
            ElevatedButton(
              onPressed: () {
                sendNotificationToAll('Notification Message');
              },
              child: const Text('Send Notification to All'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Committee Management App',
    initialRoute: '/',
    routes: {
      '/': (context) => UserDashboardScreen(),
      '/member': (context) => MemberDashboardScreen(),
      '/admin': (context) => AdminDashboardScreen(),
    },
  ));
}
