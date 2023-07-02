import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class UserDashboardScreen extends StatelessWidget {
  final CollectionReference committeesCollection =
      FirebaseFirestore.instance.collection('committees');

  UserDashboardScreen({super.key});

  void createCommittee(Committee committee) {
    committeesCollection.add(committee.toMap());
  }

  void addMember(String committeeId, User member) {
    committeesCollection.doc(committeeId).update({
      'members': FieldValue.arrayUnion([member.toMap()])
    });
  }

  void updateMember(String committeeId, String memberId, User updatedMember) {
    committeesCollection.doc(committeeId).update({
      'members': FieldValue.arrayRemove([
        {'id': memberId}
      ])
    });
    committeesCollection.doc(committeeId).update({
      'members': FieldValue.arrayUnion([updatedMember.toMap()])
    });
  }

  void deleteMember(String committeeId, String memberId) {
    committeesCollection.doc(committeeId).update({
      'members': FieldValue.arrayRemove([
        {'id': memberId}
      ])
    });
  }

  void shareCredentials(User member, String password) {
    // Code to share login credentials with the member
  }

  void sendNotification(String committeeId, String notification) {
    committeesCollection.doc(committeeId).update({
      'notification': notification,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('User Dashboard'),
            ElevatedButton(
              onPressed: () {
                createCommittee(Committee(
                  amount: 100.0,
                  duration: 30,
                  members: [],
                ));
              },
              child: const Text('Create Committee'),
            ),
            ElevatedButton(
              onPressed: () {
                addMember(
                    'committeeId',
                    User(
                      name: 'John Doe',
                      phone: '1234567890',
                      number: '123',
                      email: 'john.doe@example.com',
                    ));
              },
              child: const Text('Add Member'),
            ),
            ElevatedButton(
              onPressed: () {
                updateMember(
                    'committeeId',
                    'memberId',
                    User(
                      name: 'Updated Member',
                      phone: '9876543210',
                      number: '321',
                      email: 'updated.member@example.com',
                    ));
              },
              child: const Text('Update Member'),
            ),
            ElevatedButton(
              onPressed: () {
                deleteMember('committeeId', 'memberId');
              },
              child: const Text('Delete Member'),
            ),
            ElevatedButton(
              onPressed: () {
                shareCredentials(
                    User(
                      name: 'John Doe',
                      phone: '1234567890',
                      number: '123',
                      email: 'john.doe@example.com',
                    ),
                    'password');
              },
              child: const Text('Share Credentials'),
            ),
            ElevatedButton(
              onPressed: () {
                sendNotification('committeeId', 'Notification Message');
              },
              child: const Text('Send Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
