import 'package:admin_web_portal_seller_amazon_app/widgets/nav_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SellersPieChartScreen extends StatefulWidget {
  const SellersPieChartScreen({super.key});

  @override
  State<SellersPieChartScreen> createState() => _SellersPieChartScreenState();
}

class _SellersPieChartScreenState extends State<SellersPieChartScreen> {
  int totalNumberofVerifiedSellers = 0;
  int totalNumberofBlockedSellers = 0;

  getTotalNumberOfVerifiedSellers() async {
    FirebaseFirestore.instance
        .collection("sellers")
        .where("status", isEqualTo: "approved")
        .get()
        .then((allVerifiedSellers) {
      setState(() {
        totalNumberofVerifiedSellers = allVerifiedSellers.docs.length;
      });
    });
  }

  getTotalNumberOfBlockedSellers() async {
    FirebaseFirestore.instance
        .collection("sellers")
        .where("status", isEqualTo: "not approved")
        .get()
        .then((allBlockedSellers) {
      setState(() {
        totalNumberofBlockedSellers = allBlockedSellers.docs.length;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalNumberOfBlockedSellers();
    getTotalNumberOfVerifiedSellers();
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
          {'domain': 'Blocked Sellers', 'measure': totalNumberofBlockedSellers},
          {
            'domain': 'Verified Sellers',
            'measure': totalNumberofVerifiedSellers
          },
        ],
        fillColor: (pieData, index) {
          switch (pieData['domain']) {
            case 'Blocked Sellers':
              return Colors.pinkAccent;
            case 'Verified Sellers':
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
