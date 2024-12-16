// ignore_for_file: file_names
import 'package:flutter/material.dart';
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
    print("chof" + queryService.getQueries().toString());
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
                      date: query['createdAt'] ?? 'Unknown date',
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

  const HistoryCard({
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(date),
      ),
    );
  }
}
