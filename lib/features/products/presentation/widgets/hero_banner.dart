import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const AppNetworkImage(
            imageUrl:
                'https://images.unsplash.com/photo-1483985988355-763728e1935b?auto=format&fit=crop&w=800&q=80',
            width: double.infinity,
            height: double.infinity,
          ),
          // Dark Gradient Overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.15),
                  Color.fromRGBO(0, 0, 0, 0.7),
                ],
              ),
            ),
          ),
          // Text Overlay
          const Positioned(
            bottom: 24,
            left: 20,
            child: AppText.h1(
              'Street clothes',
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
