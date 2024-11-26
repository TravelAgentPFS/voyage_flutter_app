import 'package:flutter/material.dart';
import 'package:voyage_flutter_app/widgets/build_card_experience.dart';

class ActivitiesTabBar extends StatefulWidget {
  const ActivitiesTabBar({super.key});

  @override
  State<ActivitiesTabBar> createState() => _ActivitiesTabBar();
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
          TabBar(
            indicatorColor: const Color.fromARGB(255, 116, 162, 165),
            labelColor: const Color.fromARGB(255, 116, 162, 165),
            tabAlignment: TabAlignment.start,
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(icon: Icon(Icons.explore), text: ' Experience '),
              Tab(icon: Icon(Icons.hotel), text: ' Hotels '),
              Tab(icon: Icon(Icons.car_rental), text: ' Rentals '),
              Tab(icon: Icon(Icons.restaurant), text: ' Restaurant '),
              Tab(icon: Icon(Icons.airport_shuttle), text: ' Transport '),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCardExperienceList(
                  count: 3,
                  attractionNames: ["Bali Retreat", "Mount Everest", "Paris Tour"],
                  locationNames: ["Ubud, Bali, Indonesia", "Nepal", "Paris, France"],
                  categories: [
                    ["Mountain", "Adventure"],
                    ["Adventure", "High Altitude"],
                    ["Tourism", "Romantic"]
                  ],
                ),
                Text("hello"),
                Text("hello"),
                Text("hello"),
                Text("hello"),
                // _buildCardList(),
                // _buildCardList(),
                // _buildCardList(),
                // _buildCardList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

//Think about: when selecting an event, location, restaurant, etc... add it all to a checklist. 
//This checklist will be saved in the backend. A checklist will have "objectives" that the client can set to "complete"

  Widget _buildCardExperienceList({
  required int count,
  required List<String> attractionNames,
  required List<String> locationNames,
  required List<List<String>> categories,
  List<String>? attractionImages,
}) {
  return ListView.builder(
    padding: const EdgeInsets.all(16.0),
    itemCount: count, // Example: 5 cards per tab
    itemBuilder: (context, index) {
      return BuildCardExperience(
        attractionName: attractionNames[index], 
        locationName: locationNames[index], 
        categories: categories[index], 
        attractionImage: attractionImages != null && attractionImages.length > index 
            ? attractionImages[index] 
            : "null", // Pass image if available
      );
    },
  );
}

Widget _buildCardHotelList({
  required int count,
  required List<String> attractionNames,
  required List<String> locationNames,
  required List<List<String>> categories,
  List<String>? attractionImages,
}) {
  return ListView.builder(
    padding: const EdgeInsets.all(16.0),
    itemCount: count, // Example: 5 cards per tab
    itemBuilder: (context, index) {
      return BuildCardExperience(
        attractionName: attractionNames[index], 
        locationName: locationNames[index], 
        categories: categories[index], 
        attractionImage: attractionImages != null && attractionImages.length > index 
            ? attractionImages[index] 
            : "null", // Pass image if available
      );
    },
  );
}

  
}