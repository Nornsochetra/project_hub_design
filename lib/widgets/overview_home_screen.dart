import 'package:flutter/material.dart';

class OverviewHomeScreen extends StatelessWidget {
  final String title;
  final String dateText; // e.g. "Dec 15"
  final double progress; // 0.0 - 1.0
  final List<ImageProvider> members;

  const OverviewHomeScreen({
    super.key,
    required this.title,
    required this.dateText,
    required this.progress,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();

    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF5AA3FF), // blue
            Color(0xFF66E6C3), // mint/green
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Date (top-right)
          Positioned(
            top: 4,
            right: 10,
            child: Text(
              dateText,
              style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontWeight: FontWeight.w600,
                fontSize: 16
              ),
            ),
          ),

          // Title (top-left)
          Positioned(
            top: 2,
            left: 10,
            right: 0,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // Progress circle (bottom-left)
          Positioned(
            left: 10,
            bottom: 10,
            child: _ProgressRing(
              progress: progress,
              label: '$percent%',
            ),
          ),

          // Members (bottom-right)
          Positioned(
            right: 10,
            bottom: 14,
            child: _MemberStack(members: members),
          ),
        ],
      ),
    );
  }
}

class _ProgressRing extends StatelessWidget {
  final double progress;
  final String label;

  const _ProgressRing({
    required this.progress,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      height: 96,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 10, // ⬅️ thicker ring
              backgroundColor: Colors.white.withOpacity(0.25),
              valueColor:
              AlwaysStoppedAnimation(Colors.white70.withOpacity(0.85)),
            ),
          ),
          Text(
            label, // stays same size
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18, //  unchanged
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberStack extends StatelessWidget {
  final List<ImageProvider> members;

  const _MemberStack({required this.members});

  @override
  Widget build(BuildContext context) {
    final show = members.take(4).toList(); // show max 4
    return SizedBox(
      height: 36,
      width: 36 + (show.length - 1) * 20,
      child: Stack(
        children: [
          for (int i = 0; i < show.length; i++)
            Positioned(
              left: i * 20,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: show[i],
                ),
              ),
            ),
        ],
      ),
    );
  }
}