import 'package:flutter/material.dart';

class CustomMarkerWidget extends StatefulWidget {
  const CustomMarkerWidget({
    required this.imageUrl,
    required this.battery,
    super.key,
  });

  final String imageUrl;
  final int battery;

  @override
  State<CustomMarkerWidget> createState() => _CustomMarkerWidgetState();
}

class _CustomMarkerWidgetState extends State<CustomMarkerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _pulseAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Elegant, Uber-like minimalist design
    return SizedBox(
      width: 120,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. Animated pulsing ripple (Radar effect)
          Positioned(
            bottom: 15,
            child: AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Container(
                  width: 50 + (_pulseAnimation.value * 50),
                  height: 20 + (_pulseAnimation.value * 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.elliptical(100, 40)),
                    color: Colors.black.withOpacity(
                      0.3 * (1 - _pulseAnimation.value),
                    ),
                  ),
                );
              },
            ),
          ),

          // Base shadow for the pin
          Positioned(
            bottom: 25,
            child: Container(
              width: 12,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(12, 6)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),

          // 2. The sleek Marker Pin (Custom teardrop-like layout)
          Positioned(
            bottom: 30,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Elegant User Badge
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.black, // Sleek black base (Uber style)
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ), // Soft elevation
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 58,
                      height: 58,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: ClipOval(
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                // Pin point
                CustomPaint(
                  size: const Size(16, 12),
                  painter: _TrianglePainter(color: Colors.black),
                ),
              ],
            ),
          ),

          // 3. Floating Modern Status Indicator (Battery)
          Positioned(
            top: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        width: 18,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Container(
                        width: 18 * (widget.battery / 100).clamp(0.0, 1.0),
                        height: 8,
                        decoration: BoxDecoration(
                          color: widget.battery > 20
                              ? Colors
                                    .black // Sleek minimal black
                              : Colors.redAccent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${widget.battery}%',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TrianglePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
