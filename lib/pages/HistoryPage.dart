import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            HistoryCard(
              title: 'Query 1',
              date: '2023/10/01',
            ),
            HistoryCard(
              title: 'Query  2',
              date: '2023/10/02',
            ),
            // Add more HistoryCard widgets here
          ],
        ),
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final String title;
  final String date;

  HistoryCard({required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
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
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 7),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(231, 231, 242, 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      date,
                      style: TextStyle(
                        color: Color.fromRGBO(38, 34, 65, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: () {
                // Add functionality here
              },
              icon: Icon(
                Icons.search,
                size: 18,
              ),
              label: Text('Re-send'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 239, 132, 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
