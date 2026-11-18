import 'package:flutter/material.dart';

import '../../state/app_state.dart';
import '../../theme/theme.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  LeaderboardSnapshot? _leaderboard;
  Object? _loadError;
  bool _isLoading = true;
  bool _hasRequestedLoad = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasRequestedLoad) {
      _hasRequestedLoad = true;
      _loadLeaderboard();
    }
  }

  Future<void> _loadLeaderboard() async {
    setState(() {
      _isLoading = true;
      _loadError = null;
    });
    try {
      final leaderboard = await AppStateProvider.of(context).fetchLeaderboard();
      if (!mounted) return;
      setState(() {
        _leaderboard = leaderboard;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _loadError = error;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: _isLoading && _leaderboard == null
            ? const Center(child: CircularProgressIndicator())
            : _loadError != null && _leaderboard == null
            ? _buildError(theme)
            : RefreshIndicator(
                onRefresh: _loadLeaderboard,
                child: _buildLeaderboard(theme, _leaderboard!),
              ),
      ),
    );
  }

  Widget _buildError(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.leaderboard_rounded,
              size: 54,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              _loadError.toString().replaceFirst('Exception: ', ''),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: _loadLeaderboard,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboard(ThemeData theme, LeaderboardSnapshot leaderboard) {
    final currentIsInTopFive = leaderboard.topUsers.any(
      (entry) => entry.id == leaderboard.currentUser.id,
    );

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      children: [
        _buildHeader(theme),
        const SizedBox(height: 20),
        _buildRankCard(theme, leaderboard),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Text(
                'Top learners',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Text(
              '${leaderboard.totalUsers} learners',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          'Ranked by total points earned',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 14),
        if (leaderboard.topUsers.isEmpty)
          _buildEmptyState(theme)
        else
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: _cardDecoration(theme),
            child: Column(
              children: [
                for (
                  var index = 0;
                  index < leaderboard.topUsers.length;
                  index++
                ) ...[
                  _buildPlayerRow(
                    theme,
                    leaderboard.topUsers[index],
                    isCurrentUser:
                        leaderboard.topUsers[index].id ==
                        leaderboard.currentUser.id,
                  ),
                  if (index < leaderboard.topUsers.length - 1)
                    Divider(
                      height: 1,
                      indent: 68,
                      endIndent: 16,
                      color: theme.colorScheme.outlineVariant.withValues(
                        alpha: 0.4,
                      ),
                    ),
                ],
              ],
            ),
          ),
        if (!currentIsInTopFive) ...[
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Your place',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Icon(
                Icons.south_rounded,
                size: 18,
                color: Color(0xFF64748B),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildPlayerRow(
            theme,
            leaderboard.currentUser,
            isCurrentUser: true,
            elevated: true,
          ),
        ],
        const SizedBox(height: 16),
        Center(
          child: Text(
            'Keep learning to climb the leaderboard',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Leaderboard',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Celebrate progress. Keep climbing.',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: AppTheme.goldGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF59E0B).withValues(alpha: 0.22),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.emoji_events_rounded,
            color: Colors.white,
            size: 26,
          ),
        ),
      ],
    );
  }

  Widget _buildRankCard(ThemeData theme, LeaderboardSnapshot leaderboard) {
    final rank = leaderboard.currentUser.rank;
    final rankSuffix = _rankSuffix(rank);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.22),
            blurRadius: 20,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(19),
              border: Border.all(color: Colors.white.withValues(alpha: 0.24)),
            ),
            child: Text(
              '#$rank',
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'YOUR CURRENT RANK',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.78),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$rank$rankSuffix place',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${leaderboard.currentUser.points}',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'POINTS',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.78),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerRow(
    ThemeData theme,
    LeaderboardEntry player, {
    required bool isCurrentUser,
    bool elevated = false,
  }) {
    final color = _rankColor(player.rank);
    return Container(
      margin: elevated
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? theme.colorScheme.primary.withValues(alpha: 0.08)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(17),
        border: isCurrentUser
            ? Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.3),
              )
            : null,
        boxShadow: elevated ? AppTheme.getSoftShadow(context) : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 38,
            child: Center(
              child: player.rank <= 3
                  ? Icon(
                      Icons.workspace_premium_rounded,
                      color: color,
                      size: 26,
                    )
                  : Text(
                      '${player.rank}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 21,
            backgroundColor: color.withValues(alpha: 0.14),
            child: Text(
              _initials(player.username),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCurrentUser ? '${player.username} (You)' : player.username,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Rank ${player.rank}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.bolt_rounded, color: const Color(0xFFF59E0B), size: 19),
          const SizedBox(width: 3),
          Text(
            '${player.points}',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: _cardDecoration(theme),
      child: Column(
        children: [
          Icon(
            Icons.emoji_events_outlined,
            size: 42,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text(
            'The leaderboard is ready',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Earn points from learning activities to take the lead.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
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
      boxShadow: AppTheme.getSoftShadow(context),
    );
  }

  Color _rankColor(int rank) {
    return switch (rank) {
      1 => const Color(0xFFE5A900),
      2 => const Color(0xFF7C8A9A),
      3 => const Color(0xFFB87333),
      _ => const Color(0xFF6366F1),
    };
  }

  String _rankSuffix(int rank) {
    if (rank % 100 >= 11 && rank % 100 <= 13) return 'th';
    return switch (rank % 10) {
      1 => 'st',
      2 => 'nd',
      3 => 'rd',
      _ => 'th',
    };
  }

  String _initials(String username) {
    final parts = username.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
        .toUpperCase();
  }
}
