import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sentinova/helper/data.dart';
import 'package:sentinova/screens/community_screen.dart';
import 'package:sentinova/screens/profile_screen.dart';


import '../components/cards_row.dart';
import '../components/corner_painter.dart';
import '../components/facebook_card.dart';
import '../components/glassmorphic_button.dart';
import '../components/instagram_card.dart';
import '../components/issue_button.dart';
import '../components/leave_feedback.dart';
import '../components/linkedin_card.dart';
import '../components/reddit_card.dart';
import '../components/share_row.dart';
import '../components/social_stream.dart';
import '../components/twitter_card.dart';

import '../models/event_model.dart';
import '../models/social_media_post.dart';
import '../widgets/side_bar.dart';

class Dashboard extends StatefulWidget {
  final Event event;

  const Dashboard({super.key, required this.event});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  late List<SocialMediaPost> eventPosts;
  late Map<String, int> platformPostCounts;

  @override
  void initState() {
    super.initState();
    eventID = widget.event.id!;
  //  blocks = generateBlockListFromEvent(widget.event);
    // Convert posts to SocialMediaPost
    eventPosts = widget.event.posts.map((post) {
      return SocialMediaPost(
        platform: post.platform ?? 'Unknown',
        postId: post.postId ?? '',
        username: post.username ?? 'Anonymous',
        text: post.text ?? '',
        timestamp: DateTime.tryParse(post.timestamp.toString()) ?? DateTime.now(),
        likes: post.likes?.toInt(),
        comments: post.comments,
        shares: post.shares,
        url: post.url?.toString(),
        sentiment: getSentimentLabel(post.sentiment),
      );
    }).toList();
    eventPosts.shuffle();

    // Count posts by platform
    platformPostCounts = countPostsByPlatform(widget.event.posts);

    // Debug print if needed
    print("Platform-wise post counts: $platformPostCounts");
  }
  List<Map<String, dynamic>> generateBlockListFromEvent(Event event) {
    return List.generate(event.blocks.length, (index) {
      final block = event.blocks[index];
      final name = 'Block ${String.fromCharCode(65 + index)}'; // A, B, C...

      return {
        'id': index + 1,
        'name': name,
        'x1': block.topLeft?.x ?? 0.0,
        'y1': block.topLeft?.y ?? 0.0,
        'x2': block.bottomRight?.x ?? 0.0,
        'y2': block.bottomRight?.y ?? 0.0,
      };
    });
  }


//  List<Map<String, dynamic>> blocks = [];
  List<Map<String, dynamic>> blocks = [
    {'id': 1, 'name': 'Tech Glitches', 'x1': 40.0, 'y1': 54.0, 'x2': 290.0, 'y2': 140.0},
    {'id': 2, 'name': 'Platinum Block', 'x1': 40.0, 'y1': 140.0, 'x2': 290.0, 'y2': 215.0},
    {'id': 3, 'name': 'Diamond Block', 'x1': 40.0, 'y1': 215.0, 'x2': 290.0, 'y2': 240.0},
    {'id': 4, 'name': 'OverCrowding', 'x1': 50.0, 'y1': 240.0, 'x2': 270.0, 'y2': 280.0},
  ];

  Map<String, dynamic>? selectedBlock;

  void _handleTap(TapUpDetails details) {
    final tapX = details.localPosition.dx;
    final tapY = details.localPosition.dy;

    for (var block in blocks) {
      if (tapX >= block['x1'] && tapX <= block['x2'] &&
          tapY >= block['y1'] && tapY <= block['y2']) {
        setState(() {
          selectedBlock = block;
        });
        return;
      }
    }
    setState(() {
      selectedBlock = null;
    });
  }

  String getSentimentLabel(Sentiment? sentiment) {
    if (sentiment == null) return 'neutral';

    final scores = {
      'positive': sentiment.veryPositive ?? 0,
      'positive': sentiment.positive ?? 0,
      'neutral': sentiment.neutral ?? 0,
      'negative': sentiment.negative ?? 0,
      'negative': sentiment.veryNegative ?? 0,
    };

    final sorted = scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sorted.first.key; // Returns the sentiment with the highest count
  }
  Map<String, int> countPostsByPlatform(List<Post> posts) {
    final Map<String, int> platformCounts = {};

    for (var post in posts) {
      final platform = post.platform ?? 'Unknown';
      platformCounts[platform] = (platformCounts[platform] ?? 0) + 1;
    }

    return platformCounts;
}




  @override
  Widget build(BuildContext context) {
    int tw = platformPostCounts['Twitter'] ?? 0;
    int rd = platformPostCounts['Reddit'] ?? 0;
    int ins = platformPostCounts['Instagram'] ?? 0;
    int ln = platformPostCounts['LinkedIn'] ?? 0;
    int fb = platformPostCounts['Facebook'] ?? 0;

    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.2, -0.5), // Adjust for an offset effect
                radius: 1.5, // Adjust the spread
                colors: [
                  Color(0xFF190B34), // Purple
                  Color(0xFF0A0A0E), // Dark Purple / Black
                ],
                stops: [0.3, 1.0], // Control how colors blend
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      child: Row(
                        children: [
                          // Container(
                          //   child: Padding(
                          //     padding: EdgeInsets.all(10),
                          //     child: Container(
                          //       decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(7),
                          //           color: Colors.white.withOpacity(0.1),
                          //           border: Border.all(
                          //               color: Colors.white.withOpacity(0.2))),
                          //       height: 50,
                          //       width: 50,
                          //       child: Center(
                          //         child: Icon(
                          //           Icons.notifications_active_rounded,
                          //           color: Colors.white,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => NotificationSidebar(),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.white.withOpacity(0.1),
                                border: Border.all(color: Colors.white.withOpacity(0.2)),
                              ),
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Icon(Icons.notifications_active_rounded, color: Colors.white),
                              ),
                            ),
                          ),

                          Expanded(
                              child: Padding(
                                padding:
                                EdgeInsets.symmetric(vertical: 5, horizontal: 35),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        "SENTINOVA",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                          GestureDetector(
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.white.withOpacity(0.1),
                                      border: Border.all(
                                          color: Colors.white.withOpacity(0.2))),
                                  height: 50,
                                  width: 50,
                                  child: Center(
                                    child: Icon(
                                      Icons.person_2_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const Profile()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                // GlowingCard(
                                //   text: 'My Glowing Card',
                                //   glowColor: Colors.blue, // Change glow color
                                //   gradientColors: [
                                //     Color(0xFF6A00F4),
                                //     Color(0xFF20002c)
                                //   ], // Custom gradient
                                // ),

                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(child: SocialCardsRow(
                                    scrollLeftToRight: true,
                                    cards: [
                                      FacebookCard(count: "${fb}+"),
                                      InstagramCard(count: "${ins}+"),
                                      RedditCard(count: "${rd}+"),
                                      LinkedinCard(count: "${ln}+"),
                                      TwitterCard(count: "${tw}+"),

                                    ],
                                  ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),

                                //MediaCard(icon: Icons.facebook, title: "Facebook", count: "15", primaryColor: Colors.blue)
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 35.0),
                              child: Divider(
                                color: Colors.white,
                                height: 2,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: CustomPaint(
                                painter: CornerBorderPainter(),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.25),
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.circular(10)),
                                    height: 300,


                                    child:  GestureDetector(
                                        onTapUp: _handleTap,
                                        child: SizedBox(
                                          width: 300,
                                          height: 300,
                                          child: Container(
                                            child: Stack(

                                              children: [
                                                Positioned.fill(
                                                  child: Image.network(
                                                    widget.event.mapUrl.toString(),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                if (selectedBlock != null)
                                                  Positioned(
                                                    left: selectedBlock!['x1'],
                                                    top: selectedBlock!['y1'],
                                                    child: Container(
                                                      width: selectedBlock!['x2'] - selectedBlock!['x1'],
                                                      height: selectedBlock!['y2'] - selectedBlock!['y1'],
                                                      color: (selectedBlock!['id']==2 || selectedBlock!['id']==3 )? Colors.blue.withOpacity(0.5) : Colors.red.withOpacity(0.5),
                                                      child: Center(
                                                        child: Text(
                                                          selectedBlock!['name'],
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            GlassmorphicButton(
                                text: "JOIN THE COMMUNITY",
                                icon: Icons.message,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CommunityScreen()));
                                }),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "Report a problem",
                              style: TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 35.0),
                              child: Divider(
                                color: Colors.white,
                                height: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(height: 12,),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IssueButton(
                                        label: 'Overcrowding',
                                        icon: ImageIcon(AssetImage('assets/overcrowding.png',), color: Colors.white,), // You can customize per button
                                        onTap: () {
                                          _showProblemDialog(context, 'Overcrowding', widget.event.id.toString(),widget.event.mapUrl.toString());
                                        },
                                      ),
                                      IssueButton(
                                        label: 'Long lines',
                                        icon: ImageIcon(AssetImage('assets/queue.png',), color: Colors.white,), // You can customize per button
                                        onTap: () {
                                          _showProblemDialog(context, 'Long lines', widget.event.id.toString(),widget.event.mapUrl.toString());
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16,),

                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IssueButton(
                                        label: 'Food Issues',
                                        icon: ImageIcon(AssetImage('assets/foodproblems.png',), color: Colors.white,), // You can customize per button
                                        onTap: () {
                                          _showProblemDialog(context, 'Food Issues', widget.event.id.toString(),widget.event.mapUrl.toString());
                                        },
                                      ),
                                      IssueButton(
                                        label: 'Speaker issues',
                                        icon: ImageIcon(AssetImage('assets/speakerissue.png',), color: Colors.white,), // You can customize per button
                                        onTap: () {
                                          _showProblemDialog(context, 'Speaker issues', widget.event.id.toString(),widget.event.mapUrl.toString());
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16,),

                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IssueButton(
                                        label: 'Tech Glitches',
                                        icon: ImageIcon(AssetImage('assets/marketing.png',), color: Colors.white,), // You can customize per button
                                        onTap: () {
                                          _showProblemDialog(context, 'Tech Glitches', widget.event.id.toString(),widget.event.mapUrl.toString());
                                        },
                                      ),
                                      IssueButton(
                                        label: 'Other...',
                                        icon: Icon(Icons.circle, color: Colors.white,) ,// You can customize per button
                                        onTap: () {
                                          _showProblemDialog(context, 'Others', widget.event.id.toString(),widget.event.mapUrl.toString());
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12,),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 35.0),
                              child: Divider(
                                color: Colors.white,
                                height: 2,
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "Share about us!",
                              style: TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            SizedBox(
                              height: 15,
                            ),

                            ShareRow(),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "Live Posts",
                              style: TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 35.0),
                              child: Divider(
                                color: Colors.white,
                                height: 2,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SocialStream(allPosts: eventPosts),
                            SizedBox(
                              height: 25,
                            ),

                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 35.0),
                              child: Divider(
                                color: Colors.white,
                                height: 2,
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "Leave us some feedback",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color.fromRGBO(255, 255, 255, 0.5), // glow
                                        blurRadius: 15,
                                        spreadRadius: 2,
                                        offset: const Offset(0, 0),
                                        blurStyle: BlurStyle.outer
                                    ),
                                  ],
                                ),
                                child: ExpandableTextField(
                                  label: "Description",
                                  hint: "Type your text here...",
                                  controller: TextEditingController(),

                                ),
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Text(
                              "With ❤ by Team Runtime Error",
                              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300),
                            ),


                            // Padding(
                            //   padding: const EdgeInsets.all(16.0),
                            //   child: GridView.count(
                            //     shrinkWrap: true,
                            //     crossAxisCount: 2,
                            //     crossAxisSpacing: 16,
                            //     mainAxisSpacing: 16,
                            //     controller: null,
                            //     children: List.generate(6, (index) {
                            //       return GlassmorphicIconButton(
                            //         label: 'Btn ${index + 1}',
                            //         icon: Icons.star, // You can customize per button
                            //         onTap: () {
                            //           print('Button ${index + 1} tapped!');
                            //         },
                            //       );
                            //     }),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
);
}


  void _showProblemDialog(
      BuildContext context,
      String selectedProblem,
      String eventId,
      String mapUrl,
      ) {
    TextEditingController problemController = TextEditingController();
    Map<String, dynamic>? selectedBlock;

    List<Map<String, dynamic>> blocks = [
      {'id': 1, 'name': 'Gold Block', 'x1': 40.0, 'y1': 54.0, 'x2': 290.0, 'y2': 140.0},
      {'id': 2, 'name': 'Platinum Block', 'x1': 40.0, 'y1': 140.0, 'x2': 290.0, 'y2': 215.0},
      {'id': 3, 'name': 'Diamond Block', 'x1': 40.0, 'y1': 215.0, 'x2': 290.0, 'y2': 240.0},
      {'id': 4, 'name': 'Fanpit', 'x1': 50.0, 'y1': 240.0, 'x2': 270.0, 'y2': 280.0},
    ];

    if (selectedProblem != "Others") {
      problemController.text = selectedProblem;
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            bool _isSubmitting = false;

            void _handleTap(TapUpDetails details) {
              final tapX = details.localPosition.dx;
              final tapY = details.localPosition.dy;

              for (var block in blocks) {
                if (tapX >= block['x1'] &&
                    tapX <= block['x2'] &&
                    tapY >= block['y1'] &&
                    tapY <= block['y2']) {
                  setState(() {
                    selectedBlock = block;
                  });
                  return;
                }
              }

              setState(() {
                selectedBlock = null;
              });
            }

            Future<void> submitIssue() async {
              if (selectedBlock == null || problemController.text.isEmpty) return;

              setState(() {
                _isSubmitting = true;
              });

              final url = Uri.parse('https://hackfest-backend-xrix.onrender.com/api/event/problem');

              final body = {
                'data': {
                  'name': selectedBlock!['id'],
                  'issue': problemController.text,
                },
                'eventId': eventId,
              };

              final response = await http.post(
                url,
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(body),
              );

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    (response.statusCode == 200 || response.statusCode == 201)
                        ? "Issue Submitted Successfully!"
                        : "Failed to submit issue. Try again.",
                  ),
                ),
              );
            }

            return AlertDialog(
              title: Text("Report Issue"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTapUp: _handleTap,
                      child: Stack(
                        children: [
                          Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Image.network(mapUrl, fit: BoxFit.cover),
                          ),
                          if (selectedBlock != null)
                            Positioned(
                              left: selectedBlock!['x1'],
                              top: selectedBlock!['y1'],
                              child: Container(
                                width: selectedBlock!['x2'] - selectedBlock!['x1'],
                                height: selectedBlock!['y2'] - selectedBlock!['y1'],
                                color: Colors.blue.withOpacity(0.5),
                                child: Center(
                                  child: Text(
                                    selectedBlock!['name'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    if (selectedBlock != null)
                      Text(
                        'Selected Block: ${selectedBlock!['name']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    SizedBox(height: 10),
                    TextField(
                      controller: problemController,
                      decoration: InputDecoration(
                        labelText: "Problem Description",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      onChanged: (_) => setState(() {}),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                _isSubmitting
                    ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : ElevatedButton(
                  onPressed: selectedBlock != null &&
                      problemController.text.isNotEmpty
                      ? submitIssue
                      : null,
                  child: Text("Submit"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // void _showProblemDialog(BuildContext context, String selectedProblem, String eventId) {
  //   TextEditingController seatController = TextEditingController();
  //   TextEditingController problemController = TextEditingController();
  //
  //   if (selectedProblem != "Others") {
  //     problemController.text = selectedProblem;
  //   }
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           bool isButtonEnabled = seatController.text.isNotEmpty && problemController.text.isNotEmpty;
  //           bool _isSubmitting = false;
  //
  //           Future<void> submitIssue() async {
  //             setState(() {
  //               _isSubmitting = true;
  //             });
  //
  //             final url = Uri.parse('https://hackfest-backend-xrix.onrender.com/api/event/problem');
  //             // final response = await http.post(
  //             //   url,
  //             //   headers: {'Content-Type': 'application/json'},
  //             //   body: jsonEncode({
  //             //     'data': int.tryParse(seatController.text),
  //             //     'eventId': eventId,
  //             //   }),
  //             // );
  //             final response = await http.post(
  //               url,
  //               headers: {'Content-Type': 'application/json'},
  //               body: jsonEncode({
  //                 'data': {
  //                   'name': int.tryParse(seatController.text),
  //                   'issue': problemController.text,
  //
  //                 },
  //                 'eventId': eventId,
  //               }),
  //             );
  //             print(jsonEncode({
  //               'data': {
  //                 'name': int.tryParse(seatController.text),
  //                 'issue': problemController.text,
  //
  //               },
  //               'eventId': eventId,
  //             }));
  //             Navigator.pop(context); // Close the dialog
  //             print('STATUS: ${response.statusCode}');
  //             print('BODY: ${response.body}');
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(
  //                 content: Text(
  //
  //                   (response.statusCode == 200 || response.statusCode == 201)
  //                       ? "Issue Submitted Successfully!"
  //                       : "Failed to submit issue. Try again.",
  //                 ),
  //               ),
  //             );
  //           }
  //
  //           return StatefulBuilder(
  //             builder: (context, setState) {
  //               return AlertDialog(
  //                 title: Text("Report Issue"),
  //                 content: SingleChildScrollView(
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       TextField(
  //                         controller: seatController,
  //                         keyboardType: TextInputType.number,
  //                         decoration: InputDecoration(
  //                           labelText: "Seat Number",
  //                           labelStyle: TextStyle(color: Colors.grey),
  //                           border: OutlineInputBorder(),
  //                         ),
  //                         onChanged: (_) => setState(() {}),
  //                       ),
  //                       SizedBox(height: 10),
  //                       TextField(
  //                         controller: problemController,
  //                         decoration: InputDecoration(
  //                           labelText: "Problem Description",
  //                           labelStyle: TextStyle(color: Colors.grey),
  //                           border: OutlineInputBorder(),
  //                         ),
  //                         maxLines: 3,
  //                         onChanged: (_) => setState(() {}),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 actions: [
  //                   TextButton(
  //                     onPressed: () => Navigator.pop(context),
  //                     child: Text("Cancel"),
  //                   ),
  //                   _isSubmitting
  //                       ? Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 20),
  //                     child: SizedBox(
  //                       width: 24,
  //                       height: 24,
  //                       child: CircularProgressIndicator(strokeWidth: 2),
  //                     ),
  //                   )
  //                       : ElevatedButton(
  //                     onPressed: seatController.text.isNotEmpty && problemController.text.isNotEmpty
  //                         ? () => submitIssue()
  //                         : null,
  //                     child: Text("Submit"),
  //                   ),
  //                 ],
  //               );
  //             },
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

}