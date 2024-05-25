import 'package:ajira_social/common/constants.dart';
import 'package:ajira_social/theme/theme_manager.dart';
import 'package:flutter/material.dart';

/// A widget representing a profile tile with an icon and a name.
class ProfileTile extends StatelessWidget {
  /// Constructs a [ProfileTile] with required icon and name parameters.
  const ProfileTile({
    required this.iconData,
    required this.name,
    super.key,
  });

  /// The icon to be displayed in the tile.
  final IconData iconData;

  /// The name of the profile tile.
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: context.secondaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: horizontalPadding8 + verticalPadding8,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    trailing: Icon(iconData),
                    title: Text(
                      name,
                      style: context.titleMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
