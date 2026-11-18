import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../state/app_state.dart';
import '../../theme/theme.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final theme = Theme.of(context);
    final stats = appState.stats;
    final activities = [
      _ActivityData('Words', stats.wordsLearned, const Color(0xFF60A5FA)),
      _ActivityData(
        'Grammar',
        stats.grammarLessonsCompleted,
        const Color(0xFFA78BFA),
      ),
      _ActivityData(
        'Speaking',
        stats.speakingSessionsCompleted,
        const Color(0xFFFB923C),
      ),
      _ActivityData(
        'Chat',
        stats.chatSessionsCompleted,
        const Color(0xFF34D399),
      ),
    ];
    final completedActivities = activities.fold<int>(
      0,
      (total, activity) => total + activity.value,
    );

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 30),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildHeader(theme),
                  const SizedBox(height: 22),
                  _buildPointsCard(
                    theme,
                    points: appState.pointBalance,
                    streak: appState.streak.days,
                  ),
                  const SizedBox(height: 24),
                  _buildSectionHeading(
                    theme,
                    title: 'Your learning',
                    subtitle: 'A snapshot of what you have accomplished.',
                  ),
                  const SizedBox(height: 14),
                  _buildActivityCard(
                    theme,
                    activities: activities,
                    total: completedActivities,
                  ),
                  const SizedBox(height: 24),
                  _buildSectionHeading(
                    theme,
                    title: 'Your milestones',
                    subtitle: 'Keep showing up. Every step counts.',
                  ),
                  const SizedBox(height: 14),
                  _buildMilestones(
                    theme,
                    longestStreak: appState.streak.longestDays,
                    totalActivities: completedActivities,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Progress updates as you learn',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Progress',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Look how far you’ve come.',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.insights_rounded,
            color: theme.colorScheme.primary,
            size: 25,
          ),
        ),
      ],
    );
  }

  Widget _buildPointsCard(
    ThemeData theme, {
    required int points,
    required int streak,
  }) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.24),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.bolt_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'TOTAL POINTS',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              const Icon(
                Icons.auto_awesome_rounded,
                color: Color(0xFFFFD166),
                size: 22,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '$points',
            style: theme.textTheme.displaySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.2,
              height: 1,
            ),
          ),
          const SizedBox(height: 18),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.22)),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(
                Icons.local_fire_department_rounded,
                color: Color(0xFFFFD166),
                size: 20,
              ),
              const SizedBox(width: 7),
              Text(
                '$streak day${streak == 1 ? '' : 's'} in a row',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              const Text(
                'Keep it up!',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeading(
    ThemeData theme, {
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(subtitle, style: theme.textTheme.bodySmall),
      ],
    );
  }

  Widget _buildActivityCard(
    ThemeData theme, {
    required List<_ActivityData> activities,
    required int total,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: _cardDecoration(theme),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Activity breakdown',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Completed across all your learning',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$total total',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          SizedBox(
            height: 164,
            child: CustomPaint(
              painter: _ActivityChartPainter(
                activities: activities,
                gridColor: theme.colorScheme.outlineVariant.withValues(
                  alpha: 0.55,
                ),
                labelColor: theme.colorScheme.onSurfaceVariant,
              ),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 9),
          Row(
            children: activities
                .map(
                  (activity) => Expanded(
                    child: Center(
                      child: Text(
                        activity.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestones(
    ThemeData theme, {
    required int longestStreak,
    required int totalActivities,
  }) {
    return Row(
      children: [
        Expanded(
          child: _milestoneCard(
            theme,
            title: 'Best streak',
            value: '$longestStreak',
            unit: 'days',
            icon: Icons.emoji_events_rounded,
            color: const Color(0xFFF59E0B),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _milestoneCard(
            theme,
            title: 'Activities',
            value: '$totalActivities',
            unit: 'completed',
            icon: Icons.check_circle_rounded,
            color: const Color(0xFF10B981),
          ),
        ),
      ],
    );
  }

  Widget _milestoneCard(
    ThemeData theme, {
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(theme),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 21),
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(unit, style: theme.textTheme.bodySmall),
          const SizedBox(height: 10),
          Text(
            title,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration(ThemeData theme) {
    return BoxDecoration(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(
        color: theme.colorScheme.outlineVariant.withValues(alpha: 0.55),
      ),
      boxShadow: [
        BoxShadow(
          color: theme.brightness == Brightness.dark
              ? Colors.black.withValues(alpha: 0.12)
              : Colors.black.withValues(alpha: 0.025),
          blurRadius: 12,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }
}

class _ActivityData {
  const _ActivityData(this.label, this.value, this.color);

  final String label;
  final int value;
  final Color color;
}

class _ActivityChartPainter extends CustomPainter {
  const _ActivityChartPainter({
    required this.activities,
    required this.gridColor,
    required this.labelColor,
  });

  final List<_ActivityData> activities;
  final Color gridColor;
  final Color labelColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (activities.isEmpty || size.isEmpty) return;

    const topPadding = 20.0;
    const bottomPadding = 8.0;
    const leftPadding = 25.0;
    const rightPadding = 8.0;
    final chartHeight = size.height - topPadding - bottomPadding;
    final chartWidth = size.width - leftPadding - rightPadding;
    final baseline = topPadding + chartHeight;
    final maxValue = math.max(
      1,
      activities.fold<int>(
        0,
        (maxValue, item) => math.max(maxValue, item.value),
      ),
    );
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;

    for (var line = 0; line <= 3; line++) {
      final y = topPadding + chartHeight * line / 3;
      canvas.drawLine(
        Offset(leftPadding, y),
        Offset(size.width - rightPadding, y),
        gridPaint,
      );
    }

    final slotWidth = chartWidth / activities.length;
    final barWidth = math.min(34.0, slotWidth * 0.46);
    for (var index = 0; index < activities.length; index++) {
      final activity = activities[index];
      final barHeight = chartHeight * activity.value / maxValue;
      final x = leftPadding + slotWidth * index + (slotWidth - barWidth) / 2;
      final y = baseline - barHeight;
      final rect = Rect.fromLTWH(x, y, barWidth, barHeight);
      final radius = Radius.circular(math.min(9, barWidth / 2));
      final barPaint = Paint()
        ..shader = LinearGradient(
          colors: [activity.color.withValues(alpha: 0.72), activity.color],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(rect);

      if (barHeight > 0) {
        canvas.drawRRect(
          RRect.fromRectAndCorners(rect, topLeft: radius, topRight: radius),
          barPaint,
        );
      }

      final valuePainter = TextPainter(
        text: TextSpan(
          text: '${activity.value}',
          style: TextStyle(
            color: labelColor,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final valueY = math.max(0.0, y - valuePainter.height - 5);
      valuePainter.paint(
        canvas,
        Offset(x + (barWidth - valuePainter.width) / 2, valueY),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ActivityChartPainter oldDelegate) {
    if (oldDelegate.gridColor != gridColor ||
        oldDelegate.labelColor != labelColor ||
        oldDelegate.activities.length != activities.length) {
      return true;
    }
    for (var index = 0; index < activities.length; index++) {
      final oldActivity = oldDelegate.activities[index];
      final activity = activities[index];
      if (oldActivity.value != activity.value ||
          oldActivity.color != activity.color ||
          oldActivity.label != activity.label) {
        return true;
      }
    }
    return false;
  }
}
