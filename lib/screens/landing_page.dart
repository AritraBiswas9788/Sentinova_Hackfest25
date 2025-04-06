/*

import 'package:flutter/material.dart';
import 'package:sentinova_hackfest/dataclass/event_model.dart';
import '../services/api_service_events.dart';
import 'event_pass_gate.dart';



class LandingPage extends StatelessWidget {
  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("All Events")),
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
        child: FutureBuilder<Events>(
          future: api.fetchEvents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());

            if (snapshot.hasError)
              return Center(child: Text("Error: ${snapshot.error}"));

            if (!snapshot.hasData || snapshot.data!.events.isEmpty)
              return Center(child: Text("No events available"));

            final events = snapshot.data!.events;

            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: EventCard(event: event),
                );

                */
/*Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(event.name ?? 'Unnamed Event'),
                    subtitle: Text("Location: ${event.location ?? 'Unknown'}"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EventPasswordGate(event: event),
                        ),
                      );// Navigate to a details page, passing the full `event` object
                    },
                  ),
                );*//*

              },
            );
          },
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final DateTime date = DateTime.parse(event.date.toString());
    final formattedDate =
        "${date.day}/${date.month}/${date.year}";

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1A1A1A),
            const Color(0xFF1F1F1F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(255, 255, 255, 0.3),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
       */
/* boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withOpacity(0.4),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],*//*

        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Row(


          children: [

            Image.network(
              event.mapUrl.toString(),
              height: 160,
              width: 160,
              fit: BoxFit.cover,
            ),
            Column(
              children: [

                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.name.toString().toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.redAccent,
                              blurRadius: 10,
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        event.description.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.white54, size: 16),
                          const SizedBox(width: 6),
                          Text(formattedDate, style: const TextStyle(color: Colors.white70)),
                          const Spacer(),
                          const Icon(Icons.location_on, color: Colors.white54, size: 16),
                          const SizedBox(width: 6),
                          Text(event.location.toString(), style: const TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/
