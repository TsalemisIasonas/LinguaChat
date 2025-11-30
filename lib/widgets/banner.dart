import 'package:flutter/material.dart';
import 'package:lingua_chat/styles/colors.dart';

class LinguaBanner extends StatelessWidget {
  const LinguaBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BannerClipper(),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              gradientColorStart,
              gradientColorEnd,
            ],
            stops: [0.1, 0.3],
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.only(left: 80.0, top: 120.0),
          child: Text(
            'LINGUA\n\t\t\t\t\t\t\tCHAT',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              height: 1.2,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class BannerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    
    // Start from top-left
    path.lineTo(0, 0);
    
    // Top edge
    path.lineTo(size.width, 0);
    
    // Right edge going down (shorter)
    path.lineTo(size.width, size.height - 120);
    
    // Big curved bottom-right corner
    path.quadraticBezierTo(
      size.width - 120, // control point x
      size.height, // control point y
      120, // end point x
      size.height, // end point y
    );
    
    // Bottom edge
    path.lineTo(90, size.height);
    
    // Small curved bottom-left corner (extends further down)
    path.quadraticBezierTo(
      30, // control point x
      size.height, // control point y
      0, // end point x
      size.height - 80, // end point y
    );
    
    // Left edge going up (extends further down than right)
    path.lineTo(0, 0);
    
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
