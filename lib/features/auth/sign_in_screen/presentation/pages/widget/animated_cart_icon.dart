import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedCartIcon extends StatefulWidget {
  const AnimatedCartIcon({super.key});

  @override
  _AnimatedCartIconState createState() => _AnimatedCartIconState();
}

class _AnimatedCartIconState extends State<AnimatedCartIcon> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _entryAnimation;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(); // Makes animation loop forever
    
    // Entry animation from left (first 30% of duration)
    _entryAnimation = Tween<Offset>(
      begin: const Offset(-2, 0), // Starts from left outside screen
      end: Offset.zero,           // Ends at center
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );
    
    // Continuous shaking animation (last 70% of duration)
    _shakeAnimation = Tween<double>(
      begin: -0.03, // Slight left tilt
      end: 0.03,    // Slight right tilt
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _entryAnimation.value,
          child: Transform.rotate(
            angle: _shakeAnimation.value,
            child: SvgPicture.asset(
              'assets/svg_images/route.svg',
              width: 140,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}