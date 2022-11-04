import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

import '../widgets/nav_appbar.dart';

class UsersPieChartScreen extends StatefulWidget {
  const UsersPieChartScreen({super.key});

  @override
  State<UsersPieChartScreen> createState() => _SellersPieChartScreenState();
}

class _SellersPieChartScreenState extends State<UsersPieChartScreen> {
  int totalNumberofVerifiedUsers = 0;
  int totalNumberofBlockedUsers = 0;

  getTotalNumberOfVerifiedUsers() async {
    FirebaseFirestore.instance
        .collection("users")
        .where("status", isEqualTo: "approved")
        .get()
        .then((allVerifiedUsers) {
      setState(() {
        totalNumberofVerifiedUsers = allVerifiedUsers.docs.length;
      });
    });
  }

  getTotalNumberOfBlockedUsers() async {
    FirebaseFirestore.instance
        .collection("users")
        .where("status", isEqualTo: "not approved")
        .get()
        .then((allBlockedUsers) {
      setState(() {
        totalNumberofBlockedUsers = allBlockedUsers.docs.length;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalNumberOfBlockedUsers();
    getTotalNumberOfVerifiedUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: NavAppBar(
        title: "iShop",
      ),
      body: DChartPie(
        data: [
          {
            'domain': 'Blocked Users',
            'measure': totalNumberofBlockedUsers,
          },
          {
            'domain': 'Verified Users',
            'measure': totalNumberofVerifiedUsers,
          },
        ],
        fillColor: (pieData, index) {
          switch (pieData['domain']) {
            case 'Blocked Users':
              return Colors.pinkAccent;
            case 'Verified Users':
              return Colors.deepPurpleAccent;
            default:
              return Colors.grey;
          }
        },
        labelFontSize: 20,
        animate: false,
        pieLabel: (pieData, index) {
          return "${pieData['domain']}";
        },
        labelColor: Colors.white,
        strokeWidth: 6,
      ),
    );
  }
}
