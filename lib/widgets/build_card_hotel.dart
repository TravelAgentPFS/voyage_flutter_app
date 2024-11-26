import 'package:flutter/material.dart';

import 'clip_rounded_image.dart';

class BuildCardHotel extends StatefulWidget{
  const BuildCardHotel({super.key});
  @override
  State<BuildCardHotel> createState() => _BuildCardHotelState();
}
class _BuildCardHotelState extends State<BuildCardHotel>{
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
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRoundedImage(
                imageUrl: '', // Empty string triggers fallback
                height: 200,
                width: double.infinity,
              ),
              SizedBox(height: 5,),
              Text('Bali Retreat',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                    fontVariations: <FontVariation>[FontVariation('wght', 600.0)]
                    )),
              SizedBox(height: 5),
              Text('Ubud, Bali, Indonesia', 
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Montserrat",
                    fontVariations: <FontVariation>[FontVariation('wght', 400.0)]
                    )),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 4),
                  Text('4.9 (123 reviews)', style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  
}