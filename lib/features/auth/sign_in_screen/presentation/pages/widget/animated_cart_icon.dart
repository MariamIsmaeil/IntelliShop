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
    );

    _entryAnimation = Tween<Offset>(
      begin: const Offset(-2, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    _shakeAnimation = Tween<double>(
      begin: -0.03,
      end: 0.03,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    _startLoop();
  }

  Future<void> _startLoop() async {
    while (mounted) {
      await _controller.forward(from: 0);               // دخول + اهتزاز
      await Future.delayed(const Duration(seconds: 30)); // اهتزاز نص دقيقة
      if (mounted) {
  setState(() {
    // التغيير
  });
}
                                   // تحديث للـ build لو لازم
      await Future.delayed(const Duration(seconds: 1));  // وقت خروجه
      _controller.reset();                               // يرجع من الأول
    }
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
