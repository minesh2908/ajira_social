import 'package:ajira_social/theme/theme_manager.dart';
import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    required this.child,
    this.isLoading = false,
    this.padding,
    super.key,
  });

  final bool isLoading;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: isLoading,
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
        if (isLoading)
          Material(
            color: Theme.of(context).brightness == Brightness.light
                ? context.onPrimary.withOpacity(.5)
                : context.onPrimary.withOpacity(.15),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
