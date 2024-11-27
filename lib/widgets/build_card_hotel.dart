import 'package:flutter/material.dart';
import 'package:voyage_flutter_app/pages/hotel/HotelDetails.dart';

import 'clip_rounded_image.dart';

class BuildCardHotel extends StatefulWidget {
  final String imageUrl, hotelName, location;
  final int numberReviews;
  final double rate, price;
  const BuildCardHotel({
    super.key,
    required this.imageUrl,
    required this.hotelName,
    required this.location,
    required this.price,
    required this.rate,
    required this.numberReviews,
  });
  @override
  State<BuildCardHotel> createState() => _BuildCardHotelState();
}

class _BuildCardHotelState extends State<BuildCardHotel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => HotelDetailsPage(),
                  );
                },
                child: ClipRoundedImage(
                  imageUrl: widget.imageUrl,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Bali Retreat',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat",
                          fontVariations: <FontVariation>[
                            FontVariation('wght', 600.0)
                          ])),
                  Text('\$${widget.price}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat",
                          fontVariations: <FontVariation>[
                            FontVariation('wght', 400.0)
                          ])),
                ],
              ),
              const SizedBox(height: 5),
              Text(widget.location,
                  style: const TextStyle(
                      fontSize: 15,
                      fontFamily: "Montserrat",
                      fontVariations: <FontVariation>[
                        FontVariation('wght', 400.0)
                      ])),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 4),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${widget.rate}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                            color: Colors.black, // Adjust the color as needed
                          ),
                        ),
                        TextSpan(
                          text: ' ( ${(widget.numberReviews)} reviews ) ',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Montserrat",
                              color: Color.fromARGB(255, 133, 133, 133),
                              fontVariations: <FontVariation>[
                                FontVariation('wght', 400.0)
                              ] // Adjust the color as needed
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
