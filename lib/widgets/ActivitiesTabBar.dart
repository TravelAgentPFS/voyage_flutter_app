import 'package:flutter/material.dart';

class ActivitiesTabBar extends StatefulWidget {
  @override
  _ActivitiesTabBar createState() => _ActivitiesTabBar();
}

class _ActivitiesTabBar extends State<ActivitiesTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            // color: Colors.red,
            child: TabBar(
              tabAlignment: TabAlignment.start,
              controller: _tabController,
              isScrollable: true,
              tabs: const [
                Tab(icon: Icon(Icons.hotel), text: 'Hotels'),
                Tab(icon: Icon(Icons.car_rental), text: 'Rentals'),
                Tab(icon: Icon(Icons.explore), text: 'Experience'),
                Tab(icon: Icon(Icons.restaurant), text: 'Restaurant'),
                Tab(icon: Icon(Icons.airport_shuttle), text: 'Transport'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCard(),
                _buildCard(),
                _buildCard(),
                _buildCard(),
                _buildCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LayoutBuilder(builder: (context, constraints) {
        double imageHeight =
            constraints.maxHeight * 0.5; // 50% of the card's height
        return Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRoundedImage(
                imageUrl:
                    "https://media.istockphoto.com/id/1096649766/photo/indonesian.jpg?s=2048x2048&w=is&k=20&c=mxP3Te7ELZ0Ak_X0hVsgQPU-Eh6_MGjrbrCTLyTcOtA=",
                height: imageHeight,
                width: double.infinity,
              ),
              const Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bali Retreat',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Ubud, Bali, Indonesia',
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        SizedBox(width: 4),
                        Text('4.9 (123 reviews)',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ClipRoundedImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;

  const ClipRoundedImage({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
      child: Image.network(
        imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }
}
