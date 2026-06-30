import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Single label/value row inside a card container.
class DetailInfoTile extends StatelessWidget {
  const DetailInfoTile({
    super.key,
    required this.label,
    required this.value,
    this.onCopy,
    this.trailing,
  });

  final String label;
  final String value;
  final VoidCallback? onCopy;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null)
            trailing!
          else if (onCopy != null)
            IconButton(
              onPressed: onCopy,
              icon: const Icon(Icons.copy_outlined, size: 20),
            ),
        ],
      ),
    );
  }
}

/// Card with multiple label/value rows (e.g. transaction details).
class DetailInfoCard extends StatelessWidget {
  const DetailInfoCard({super.key, required this.rows});

  final List<DetailInfoRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: rows
            .map(
              (r) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      r.label,
                      style: GoogleFonts.inter(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        r.value,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class DetailInfoRow {
  const DetailInfoRow(this.label, this.value);
  final String label;
  final String value;
}
