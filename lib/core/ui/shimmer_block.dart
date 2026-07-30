import 'package:flutter/material.dart';

/// The Design_System widget rendering a single pulsing placeholder rectangle
/// (Requirement 4 AC 14, AC 15, AC 18).
///
/// This is hand-written rather than built on the declared `shimmer` package:
/// that package's widget animates a sweeping gradient, a different visual
/// from the opacity pulse Requirement 4 AC 14 specifies, so using it would
/// violate that acceptance criterion.
class ShimmerBlock extends StatefulWidget {
  const ShimmerBlock({this.width, this.height, this.borderRadius, super.key});

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  State<ShimmerBlock> createState() => _ShimmerBlockState();
}

class _ShimmerBlockState extends State<ShimmerBlock>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.3, end: 0.7).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          // `surfaceVariant` is deprecated by the Flutter framework in favor
          // of `surfaceContainerHighest`, but Requirement 4 AC 15 specifies
          // the `surfaceVariant` color by name, so it is read explicitly
          // here to stay consistent with the same suppression pattern used
          // in `color_schemes.dart`.
          // ignore: deprecated_member_use
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: widget.borderRadius,
        ),
      ),
    );
  }
}
