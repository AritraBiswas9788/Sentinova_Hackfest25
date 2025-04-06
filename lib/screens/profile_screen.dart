import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sentinova/helper/constant.dart';
import 'package:sentinova/helper/data.dart';
import 'package:sentinova/helper/init_user.dart';
import 'package:sentinova/screens/sign_in.dart';

import '../widgets/loading_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isFetched = false;


  void getData() async {
    await InitUser.initialize();
    setState(() {
      isFetched = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(FirebaseAuth.instance.currentUser == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SignIn()),
      );
    }
    getData();
  }

  @override
  Widget build(BuildContext context) {
    String? s = FirebaseAuth.instance.currentUser?.email.toString();
    // s= s?.substring(0,s.indexOf('@'));
    // return Scaffold(
    //   body: Center(
    //     child: ElevatedButton.icon(onPressed: (){
    //       logout();
    //
    //     },
    //       icon: Icon(Icons.logout),
    //       label: Text('Logout'),
    //     ),
    //   ),
    // );
    return !isFetched
        ? LoadingWidget()
        : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Center(
          child: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              // fontSize: 30,
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey, Colors.grey.shade700],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.5, 0.9],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // CircleAvatar(
                    //   backgroundColor: Colors.red.shade300,
                    //   minRadius: 35.0,
                    //   child: Icon(
                    //     Icons.call,
                    //     size: 30.0,
                    //   ),
                    // ),
                    CircleAvatar(
                      backgroundColor: Colors.white70,
                      minRadius: 60.0,
                      child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                          NetworkImage(currUser?.image ?? DEFAULT_IMG)
                        // NetworkImage('https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
                      ),
                    ),
                    //     CircleAvatar(
                    //       backgroundColor: Colors.red.shade300,
                    //       minRadius: 35.0,
                    //       child: Icon(
                    //         Icons.message,
                    //         size: 30.0,
                    //       ),
                    //     ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  // 'Bablu Gannu',
                  currUser!.name.toString(),
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.amberAccent,
                  ),
                ),
                Text(
                  '${s}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amberAccent,
                  ),
                ),
                Text(
                  'Ondc Merchant',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),

          Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Email ID',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    currUser!.email.toString(),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(
                  indent: 15,
                  endIndent: 15,
                ),
                ListTile(
                  title: Text(
                    'Posts',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    currUser!.posts.toString(),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(
                  indent: 15,
                  endIndent: 15,
                ),
                ListTile(
                  title: Text(
                    'Reward points',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    calculatePoints(currUser!.posts ?? 0),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 60.0, 0, 30),
                    child: TextButton.icon(
                      onPressed: () {
                        // logout();

                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              color: Colors.black87,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                                      child: Text('Are you sure want to Logout....',
                                        style: TextStyle(
                                          //      height: 30,
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            fixedSize: MaterialStatePropertyAll(Size.infinite)
                                        ),
                                        child:
                                        const Text('LOGOUT'),
                                        onPressed: () =>
                                            logout(), //Navigator.pop(context),
                                      ),
                                    ),
                                    TextButton(
                                      child:
                                      const Text('Cancel',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () =>
                                          Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        // },
                        //getData();
                      },
                      icon: Icon(Icons.logout),
                      label: Text('Logout',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void displaySnackBar(String s) {
    var snackdemo = SnackBar(
      content: Text(s),
      backgroundColor: Colors.green,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    displaySnackBar('Logged out!');
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/sign_in');
  }

  String calculatePoints(int i) {
    return "${100*i}";
  }
}
