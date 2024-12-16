// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:voyage_flutter_app/services/query_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<dynamic> _queriesFuture;

  @override
  void initState() {
    super.initState();
    var queryService = QueryService();
    _queriesFuture = queryService.getQueries();
  }

  String formatReadableDate(String rawDate) {
    try {
      // Parse the input string into a DateTime object
      DateTime parsedDate = DateTime.parse(rawDate);

      // Format the DateTime object into a readable string
      String formattedDate =
          DateFormat('MMM d, yyyy h:mm a').format(parsedDate);

      return formattedDate; // Example: "Monday, Dec 16, 2024 10:52 PM"
    } catch (e) {
      // If parsing fails, return the raw date
      return rawDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('History'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<dynamic>(
            future: _queriesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print("Error: ${snapshot.error}");

                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData ||
                  (snapshot.data is List && snapshot.data.isEmpty)) {
                return const Center(child: Text('No history found.'));
              } else {
                var queries = snapshot.data as List<dynamic>;
                return ListView.builder(
                  itemCount: queries.length,
                  itemBuilder: (context, index) {
                    var query = queries[index];
                    return HistoryCard(
                      title: query['queryText'] ?? 'Untitled',
                      date: formatReadableDate(query['createdAt']) ??
                          'Unknown date',
                    );
                  },
                );
              }
            },
          )),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final String title;
  final String date;

  const HistoryCard({Key? key, required this.title, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Section
                  Text(
                    "'' " + title + " '' ",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2, // Prevents overflow
                  ),
                  const SizedBox(height: 12),
                  // Date Section
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(245, 245, 250, 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          date,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(38, 34, 65, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Button Section
            ElevatedButton.icon(
              onPressed: () {
                // Add functionality here
              },
              icon: const Icon(
                Icons.send,
                size: 18,
              ),
              label: const Text('Re-send'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 255, 102, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                textStyle: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
