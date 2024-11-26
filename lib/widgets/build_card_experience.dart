import 'package:flutter/material.dart';

import 'clip_rounded_image.dart';

class BuildCardExperience extends StatefulWidget {
  final String? attractionImage;
  final String attractionName;
  final String locationName;
  final List<String> categories;
  const BuildCardExperience({super.key,
     this.attractionImage,
    required  this.attractionName,
    required  this.locationName,
    required  this.categories
  });

  @override
  State<BuildCardExperience> createState() => _BuildCardExperienceState();
}

class _BuildCardExperienceState extends State<BuildCardExperience> {

  final ScrollController _scrollController = ScrollController();
  bool _showLeftGradient = false;
  bool _showRightGradient = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    // _handleScroll();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    final currentScrollPosition = _scrollController.offset;
    final containerWidth = MediaQuery.of(context).size.width; // Get the width of the container
  final contentWidth = maxScrollExtent + containerWidth; // Total content width (scrollable width)
    setState(() {
      // Show left gradient only if not scrolled all the way to the start
      _showLeftGradient = currentScrollPosition > 0;

      // Show right gradient only if not scrolled all the way to the end
      _showRightGradient = currentScrollPosition < (contentWidth - containerWidth);
    });
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
              ClipRoundedImage(
                imageUrl: widget.attractionImage?? '', // Empty string triggers fallback
                height: 200,
                width: double.infinity,
              ),
              const SizedBox(height: 5),
              Text(
                widget.attractionName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                  fontVariations: <FontVariation>[FontVariation('wght', 600.0)],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.locationName,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: "Montserrat",
                  fontVariations: <FontVariation>[FontVariation('wght', 400.0)],
                ),
              ),
              const SizedBox(height: 8),
              const Divider(),
              Stack(
                children: [
                  SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: 
                        widget.categories.map((category) => categoryLabel(category)).toList()
                        // categoryLabel("Beach"),
                        // categoryLabel("Mountain"),
                        // categoryLabel("Adventure"),
                        // categoryLabel("Safari"),
                        // categoryLabel("Relaxation"),
                      ,
                    ),
                  ),
                  // Left fade
                  if (_showLeftGradient)
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 20,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                             Color.fromARGB(255, 247, 242, 250),
                             Color.fromARGB(0, 247, 242, 250),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                  // Right fade
                  if (_showRightGradient)
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 20,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                             Color.fromARGB(0, 247, 242, 250),
                             Color.fromARGB(255, 247, 242, 250),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
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

  Widget categoryLabel(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 44, 50, 44),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          name,
          style: const TextStyle(
            fontFamily: "Raleway",
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
