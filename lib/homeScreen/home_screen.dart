import 'dart:async';

import 'package:admin_web_portal_seller_amazon_app/widgets/nav_appbar.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String liveTime = '';
  String liveDate = '';
  //time
  String formatCurrentLiveTime(DateTime time) {
    return DateFormat("    hh:mm:ss a").format(time);
  }

  //date
  String formatCurrentLiveDate(DateTime date) {
    return DateFormat("dd MMMM, yyyy").format(date);
  }

  getCurrentLiveTimeDate() {
    liveTime = formatCurrentLiveTime(DateTime.now());
    liveDate = formatCurrentLiveDate(DateTime.now());

    setState(() {
      liveTime;
      liveDate;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      getCurrentLiveTimeDate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: NavAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                liveTime + "\n" + liveDate,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //user active and block account button ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //active users
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    "images/verified_users.png",
                    width: 200,
                  ),
                ),
                const SizedBox(
                  width: 200,
                ),
                //blocked users
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    "images/blocked_users.png",
                    width: 200,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 30,
            ),
            //sellers activate and block account ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    "images/verified_seller.png",
                    width: 200,
                  ),
                ),
                const SizedBox(
                  width: 200,
                ),
                //block seller........
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    "images/blocked_seller.png",
                    width: 200,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
