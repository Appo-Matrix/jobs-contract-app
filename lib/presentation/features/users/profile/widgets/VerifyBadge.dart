
// ── Initials fallback avatar ───────────────────────────────────────────────────
import 'package:flutter/material.dart';

class InitialsAvatar extends StatelessWidget {
  final String initials;
  final Color color;

  const InitialsAvatar({required this.initials, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      alignment: Alignment.center,
      child: Text(
        initials,
        style: const TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

// ── Individual verification badge ─────────────────────────────────────────────
class VerifyBadge extends StatelessWidget {
  final String label;
  final bool verified;

  const VerifyBadge({required this.label, required this.verified});

  @override
  Widget build(BuildContext context) {
    final Color color = verified ? Colors.green : Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            verified ? Icons.verified : Icons.warning_amber_rounded,
            color: color,
            size: 13,
          ),
          const SizedBox(width: 4),
          Text(
            '$label ${verified ? "Verified" : "Unverified"}',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}