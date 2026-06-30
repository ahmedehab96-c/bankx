import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Settings and profile list tile with optional trailing widget.
class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.title,
    required this.icon,
    this.subtitle,
    this.trailing,
    this.iconColor,
    this.onTap,
    this.showDivider = true,
  });

  final String title;
  final IconData icon;
  final String? subtitle;
  final Widget? trailing;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 2,
          ),
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: (iconColor ?? Theme.of(context).colorScheme.primary)
                  .withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor ?? Theme.of(context).colorScheme.primary,
              size: 22,
            ),
          ),
          title: Text(
            title,
            style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Theme.of(context).hintColor,
                  ),
                )
              : null,
          trailing: trailing ?? const Icon(Icons.chevron_right, size: 22),
        ),
        if (showDivider)
          Divider(height: 1, indent: 58, color: Theme.of(context).dividerColor),
      ],
    );
  }
}
