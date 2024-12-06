import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BuildCardFlight extends StatefulWidget {
  const BuildCardFlight({Key? key}) : super(key: key);

  @override
  State<BuildCardFlight> createState() => _BuildCardFlightState();
}

class _BuildCardFlightState extends State<BuildCardFlight> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Airline Name
              const Text(
                "Emirates Airlines",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Color.fromRGBO(57, 46, 126, 1),
                ),
              ),
              const SizedBox(height: 16.0),

              // Flight Details Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Departure Column
                  const _FlightDetails(
                    city: "Dubai",
                    airportCode: "DXB",
                    time: "7:00 AM",
                    date: "Fri, Apr 7",
                  ),

                  // Airplane Icon
                  Column(
                    children: [
                      Transform.rotate(
                        angle: 1.5708, // 90 degrees in radians
                        child: const Icon(
                          Icons.airplanemode_active_rounded,
                          color: Color.fromRGBO(57, 46, 126, 1),
                          size: 36.0,
                        ),
                      ),
                    ],
                  ),

                  // Arrival Column
                  const _FlightDetails(
                    city: "Tokyo",
                    airportCode: "HND",
                    time: "6:00 PM",
                    date: "Fri, Apr 7",
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 7),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(231, 231, 242, 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          "12 Hours, 23 min",
                          style: TextStyle(
                            color: Color.fromRGBO(38, 34, 65, 1),
                          ),
                        )),
                    const Text(
                      '\$200',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(49, 40, 107, 1),
                          fontSize: 22),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Flight Details Widget
class _FlightDetails extends StatelessWidget {
  final String city;
  final String airportCode;
  final String time;
  final String date;

  const _FlightDetails({
    Key? key,
    required this.city,
    required this.airportCode,
    required this.time,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          city,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(57, 46, 126, 1),
          ),
        ),
        Text(
          airportCode,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          time,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(57, 46, 126, 1),
          ),
        ),
        Text(
          date,
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
