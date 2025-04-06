import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class NotificationSidebar extends StatefulWidget {
  @override
  _NotificationSidebarState createState() => _NotificationSidebarState();
}

class _NotificationSidebarState extends State<NotificationSidebar> {
  List<String> alerts = [
    "🎤 Live Performance at 7 PM!",
    "📢 Workshop on AI starts in 30 mins",
    "🏆 Coding Contest winners announced!",
    "🎁 Collect your goodies from Booth 3"
  ];

  void refreshAlerts() {
    // Simulate refreshing or re-fetching data
    setState(() {
      alerts.shuffle(); // or fetch new alerts from backend
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: Key('notification_sidebar'),
      onDismissed: (_) => Navigator.pop(context),
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.85),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.notifications, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "Alerts",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.refresh, color: Colors.white),
                      onPressed: refreshAlerts,
                      tooltip: 'Refresh Alerts',
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Expanded(
                  child: AnimationLimiter(
                    child: ListView.builder(
                      itemCount: alerts.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: Duration(milliseconds: 400),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Card(
                                color: Colors.white.withOpacity(0.1),
                                elevation: 2,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  leading: Icon(Icons.event, color: Colors.white),
                                  title: Text(
                                    alerts[index],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
