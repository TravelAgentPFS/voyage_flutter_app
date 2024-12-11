// import 'dart:developer';

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voyage_flutter_app/widgets/build_card_activities.dart';
import 'package:voyage_flutter_app/widgets/build_card_flight.dart';
import 'package:voyage_flutter_app/widgets/build_card_hotel.dart';
import 'package:intl/intl.dart'; // for date formatting


class ActivitiesTabBar extends StatefulWidget {
  final dynamic activities;
  final dynamic hotels;
  final dynamic flights;
  const ActivitiesTabBar({super.key, this.activities, this.hotels, this.flights});

  @override
  State<ActivitiesTabBar> createState() => _ActivitiesTabBar();
}

class _ActivitiesTabBar extends State<ActivitiesTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, dynamic> airlineData = {};
  Map<String, dynamic> iataData = {};

  // Load the JSON file
  Future<void> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/carrier_codes.json');
    setState(() {
      airlineData = json.decode(jsonString);
    });
  }
  Future<void> loadAllJsonData() async {
    // Loop through all alphabet files
    for (int i = 0; i < 26; i++) {
      String fileName = String.fromCharCode(97 + i); // 'a' to 'z'
      String filePath = 'assets/iata_codes/$fileName.json';

      try {
        // Load JSON file content
        String jsonString = await rootBundle.loadString(filePath);
        Map<String, dynamic> jsonData = json.decode(jsonString);

        // Merge the loaded data into iataData
        iataData.addAll(jsonData);
        log(iataData.length.toString());
      } catch (e) {
        // Handle error if a file is missing or malformed
        log('Error loading $filePath: $e');
      }
    }
  }
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    loadJsonData();
    loadAllJsonData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height - 250+ (size.width * 0.2),
      child: Column(
        children: [
          TabBar(
            indicatorColor: const Color.fromARGB(255, 116, 162, 165),
            labelColor: const Color.fromARGB(255, 116, 162, 165),
            tabAlignment: TabAlignment.center,
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(icon: Icon(Icons.explore), text: ' Activities '),
              Tab(icon: Icon(Icons.hotel), text: ' Hotels '),
              Tab(icon: Icon(Icons.flight_takeoff), text: ' Flights '),
              // Tab(icon: Icon(Icons.restaurant), text: ' Restaurant '),
              // Tab(icon: Icon(Icons.airport_shuttle), text: ' Transport '),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCardActivitiesList(
                  count: 10,
                  activities:widget.activities!=null?widget.activities["data"]:{},
                
              ),
              _buildCardHotelList(count: 3, imageUrls: [
                "assets/images/best-hotel-bali.jpeg",
                "assets/images/best-hotels-bali-melia-nusa-dua.jpeg",
                "assets/images/best-hotels-bali-four-seasons-ubud.jpeg",
                "assets/images/best-hotel-bali.jpeg",
              ], locations: [
                "Ubud, Bali, Indonesia",
                "Nepal",
                "Paris, France",
                "Ubud, Bali, Indonesia",
              ], names: [
                "Bali Retreat",
                "Mount Everest",
                "Paris Tour",
                "Bali Retreat",
              ], numberReviews: [
                125,
                69,
                25,
                125,
              ], prices: [
                200,
                180,
                220,
                200,
              ], rates: [
                4.8,
                3.5,
                3.2,
                4.8,
              ]),
              _buildCardFlightsList(count: 30, flights:widget.flights ?? {}),
            ],
          ),
        ),
      ],
      // ),
      // ),
    ));
  }

//Think about: when selecting an event, location, restaurant, etc... add it all to a checklist.
//This checklist will be saved in the backend. A checklist will have "objectives" that the client can set to "complete"

  Widget _buildCardActivitiesList({required int count,dynamic activities}) {
    // log(activities.toString());
    // return Text("SSSWFAFAF");
    if(activities!=null){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: count, // Example: 5 cards per tab
      itemBuilder: (context, index) {
        return BuildCardActivities(
          activityName: activities?[index]["name"],
          activityData: activities?[index],
          activityThumbnail:
              activities?[index]["pictures"] != null && activities?[index]["pictures"].length > 0
                  ? activities[index]["pictures"][0]: "", // Pass image if available
        );
      },
    );
  }
    return const Center(child: SizedBox(width: 250,
        child: Text("No activity results found for your query...",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "Montserrat",fontSize: 20, fontVariations: <FontVariation>[FontVariation('wght', 300.0)]),
                ),));
  }

  Widget _buildCardHotelList({
    required int count,
    required List<double> rates,
    required List<int> numberReviews,
    required List<double> prices,
    required List<String> imageUrls,
    required List<String> locations,
    required List<String> names,
  }) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: count, // Example: 5 cards per tab
      itemBuilder: (context, index) {
        return BuildCardHotel(
          hotelName: names[index],
          imageUrl: imageUrls[index],
          location: locations[index],
          numberReviews: numberReviews[index],
          price: prices[index],
          rate: rates[index],
        );
      },
    );
  }

  Widget _buildCardFlightsList({required int count, dynamic flights}) {
    if(flights!=null){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: count, // Example: 5 cards per tab
      itemBuilder: (context, index) {
        String carrierCode = flights?[index]["segments"][0]["carrier"];
        String originCode = flights?[index]["itinerary"]["origin"];
        String destinationCode = flights?[index]["itinerary"]["destination"];
        return BuildCardFlight(
          originCity:iataData[originCode]??originCode,
          airportCodeOrigin:flights?[index]["itinerary"]["origin"],
          destinationCity:iataData[destinationCode]??destinationCode,
          airportCodeDestination:flights?[index]["itinerary"]["destination"],
          airlineName:airlineData[carrierCode]??carrierCode,
          flightPrice: flights?[index]["price"]["total"],
          departureDate: formatDateTime(flights?[index]["itinerary"]["departure_time"]),
          arrivalDate: formatDateTime(flights?[index]["itinerary"]["arrival_time"]),
          duration: calculateDuration(flights?[index]["itinerary"]["departure_time"],flights?[index]["itinerary"]["arrival_time"])
          );
      },
    );
    }
    return const Center(child: SizedBox(width: 250,
        child: Text("No flight results found for your query...",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "Montserrat",fontSize: 20, fontVariations: <FontVariation>[FontVariation('wght', 300.0)]),
                ),));
  }

  String calculateDuration(String departureTime, String arrivalTime) {
    DateTime departure = DateTime.parse(departureTime);
    DateTime arrival = DateTime.parse(arrivalTime);
    Duration duration = arrival.difference(departure);
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    return '$hours Hours, $minutes min';
  }
  List<String> formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime = DateFormat('h:mm a').format(dateTime);
    String formattedDate = DateFormat('EEE, MMM d').format(dateTime);
    return [formattedTime, formattedDate];
  }
}
