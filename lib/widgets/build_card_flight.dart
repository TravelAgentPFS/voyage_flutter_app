import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class BuildCardFlight extends StatefulWidget {
  final String airlineName;
  final String flightPrice;
  final String duration;
  final String originCity;
  final String airportCodeOrigin;
  final String destinationCity;
  final String airportCodeDestination;
  final List<String> departureDate;
  final List<String> arrivalDate;
  const BuildCardFlight({super.key, required this.airlineName, required this.flightPrice, required this.departureDate, required this.arrivalDate, required this.duration, required this.originCity, required this.airportCodeOrigin, required this.destinationCity, required this.airportCodeDestination});

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
              Text(
                widget.airlineName,
                style: const TextStyle(
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
                  _FlightDetails(
                    city: widget.originCity,
                    airportCode: widget.airportCodeOrigin,
                    time: widget.departureDate[0],
                    date: widget.departureDate[1],
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
                  _FlightDetails(
                    city: widget.destinationCity,
                    airportCode: widget.airportCodeDestination,
                    time: widget.arrivalDate[0],
                    date: widget.arrivalDate[1],
                  ),
                ],
              ),
              const SizedBox(
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
                            const EdgeInsets.symmetric(vertical: 2, horizontal: 7),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(231, 231, 242, 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          widget.duration,
                          style: const TextStyle(
                            color: Color.fromRGBO(38, 34, 65, 1),
                          ),
                        )),
                    Text(
                      '€${widget.flightPrice}',
                      style: const TextStyle(
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
    required this.city,
    required this.airportCode,
    required this.time,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
      width: MediaQuery.of(context).size.width/3, // Set your desired container width
      height: 50,
      child:
        FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          city,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(57, 46, 126, 1),
          ),
        ))),
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
            color: Color.fromRGBO(14, 177, 71, 1),
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
