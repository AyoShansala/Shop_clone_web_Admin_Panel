import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../functions/functions.dart';
import '../homeScreen/home_screen.dart';
import '../widgets/nav_appbar.dart';

class BlockedSellersScreen extends StatefulWidget {
  const BlockedSellersScreen({super.key});

  @override
  State<BlockedSellersScreen> createState() => _VerifiedUsersScreenState();
}

class _VerifiedUsersScreenState extends State<BlockedSellersScreen> {
  QuerySnapshot? allBlockedSellers;
  showDialogBox(sellerDocumentId) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Activate Account",
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Do you want to Activate this account ?",
            style: TextStyle(fontSize: 16, letterSpacing: 2),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> sellerDataMap = {
                  "status": "approved",
                };
                FirebaseFirestore.instance
                    .collection("sellers")
                    .doc(sellerDocumentId)
                    .update(sellerDataMap)
                    .whenComplete(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => HomeScreen()),
                  );
                  showReusableSnackBar(
                    context,
                    "Activated Successfully",
                  );
                });
              },
              child: const Text("Yes"),
            )
          ],
        );
      },
    );
  }

  getAllBlockedSellers() async {
    FirebaseFirestore.instance
        .collection("sellers")
        .where("status", isEqualTo: "not approved")
        .get()
        .then((getAllBlockedSellers) {
      setState(() {
        allBlockedSellers = getAllBlockedSellers;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllBlockedSellers();
  }

  @override
  Widget build(BuildContext context) {
    Widget blockedSellersDesign() {
      if (allBlockedSellers == null) {
        return const Center(
          child: Text(
            "No Record found",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        );
      } else {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: allBlockedSellers!.docs.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 180,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            allBlockedSellers!.docs[index].get("photoUrl"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    allBlockedSellers!.docs[index].get("name"),
                  ),
                  Text(
                    allBlockedSellers!.docs[index].get("email"),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //block now button
                      GestureDetector(
                        onTap: () {
                          showDialogBox(allBlockedSellers!.docs[index].id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 18.0,
                            bottom: 8.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/activate.png",
                                width: 56,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Activate Now",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      //earnings button
                      GestureDetector(
                        onTap: () {
                          showReusableSnackBar(
                            context,
                            "Total Earings = ".toUpperCase() +
                                "Rs " +
                                allBlockedSellers!.docs[index]
                                    .get("earnings")
                                    .toString(),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 18.0,
                            bottom: 8.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/earnings.png",
                                width: 56,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Rs " +
                                    allBlockedSellers!.docs[index]
                                        .get("earnings")
                                        .toString(),
                                style: const TextStyle(
                                  color: Colors.green,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: NavAppBar(
        title: "Blocked Sellers Accounts",
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          child: blockedSellersDesign(),
        ),
      ),
    );
  }
}
