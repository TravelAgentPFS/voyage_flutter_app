import 'package:flutter/material.dart';
import 'package:voyage_flutter_app/widgets/clip_rounded_image.dart';

class HotelDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: height, // Full height of the screen
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRoundedImage(
                      imageUrl:
                          "https://balidave.com/wp-content/uploads/2022/11/best-hotels-bali-four-seasons-ubud.jpeg",
                      height: height * 0.35,
                      width: double.infinity,
                    ),
                    Positioned(
                      top: 30.0,
                      left: 16.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        child: IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    // Share icon
                    Positioned(
                      top: 30.0,
                      right: 16.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        child: IconButton(
                          icon: const Icon(Icons.share, color: Colors.white),
                          onPressed: () {
                            // Add share functionality here
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Laskar Cinta Hotel',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: const Color.fromARGB(255, 188, 23, 11),
                              ),
                              Text(
                                'Noth Sragerntina, Austria',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber),
                                  const SizedBox(width: 4),
                                  RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '4.8',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Montserrat",
                                            color: Colors
                                                .black, // Adjust the color as needed
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' ( 102 reviews ) ',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "Montserrat",
                                              color: Color.fromARGB(
                                                  255, 133, 133, 133),
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
                              const Text(
                                '\$170/night',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontFamily: "Montserrat",
                                    fontVariations: <FontVariation>[
                                      FontVariation('wght', 500.0)
                                    ]),
                              )
                            ],
                          ),
                          const SizedBox(height: 25.0),
                          const Text(
                            'Description :',
                            style: TextStyle(
                                fontSize: 22.0,
                                fontFamily: "Raleway",
                                fontVariations: <FontVariation>[
                                  FontVariation('wght', 500.0)
                                ]),
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'In addition to the standards of Indonesia Care, all guests will receive free Wi-Fi in all rooms and free parking if arriving by car. Strategically  you close access and proximity to local attractions and more.',
                            style: TextStyle(
                              fontSize: 16.0,
                              height: 1.5, // Adjust line spacing
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          const Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage('assets/host.jpg'),
                                radius: 20.0,
                              ),
                              SizedBox(width: 8.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mohamed Amine',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('Ask Questions'),
                                ],
                              ),
                              Spacer(),
                              Icon(Icons.phone, size: 24.0, color: Colors.blue),
                              SizedBox(width: 16.0),
                              Icon(Icons.message,
                                  size: 24.0, color: Colors.blue),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: SizedBox(
                                width: double
                                    .infinity, // Makes the button take full width
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Your button action here
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 116, 162, 165),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: const Text(
                                    "Reserver",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
