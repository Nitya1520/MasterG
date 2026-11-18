import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../config/api_config.dart';
import '../../grammar/data/grammar_data.dart';
import '../../grammar/models/grammar_topic.dart';
import '../../state/app_state.dart';
import '../../theme/theme.dart';

class RevisionScreen extends StatefulWidget {
  const RevisionScreen({super.key});

  @override
  State<RevisionScreen> createState() => _RevisionScreenState();
}

class _RevisionScreenState extends State<RevisionScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  _RevisionMode _mode = _RevisionMode.menu;

  List<_RevisionCard> _cards = [];
  List<GrammarQuizQuestion> _grammarQuestions = [];
  List<String> _grammarQuestionTopics = [];

  int _totalWordsLearned = 0;
  int _completedGrammarCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadRevisionData());
  }

  Future<void> _loadRevisionData() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final appState = AppStateProvider.of(context);
      final response = await appState.authenticatedRequest(
        (token) => http
            .get(
              Uri.parse(
                '${ApiConfig.apiBaseUrl}/vocabulary/revision/?count=20',
              ),
              headers: {'Authorization': 'Bearer $token'},
            )
            .timeout(const Duration(seconds: 12)),
      );

      if (!mounted) return;
      if (response.statusCode != 200) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Could not load revision data.';
        });
        return;
      }

      final data = jsonDecode(response.body);
      final words = (data['words'] as List?) ?? [];
      final completedTopicIds =
          ((data['completed_grammar_topics'] as List?) ?? [])
              .cast<String>()
              .toSet();
      _totalWordsLearned = data['total_words_learned'] ?? 0;
      _completedGrammarCount = completedTopicIds.length;

      _cards = words
          .map(
            (w) => _RevisionCard(
              word: w['word'] ?? '',
              pronunciation: w['pronunciation'] ?? '',
              gujaratiMeaning: w['gujarati_meaning'] ?? '',
              englishMeaning: w['english_meaning'] ?? '',
              level: w['level'] ?? '',
              sentences: ((w['sentences'] as List?) ?? []).cast<String>(),
            ),
          )
          .toList();

      _grammarQuestions = [];
      _grammarQuestionTopics = [];
      for (final topic in GrammarData.a1Topics) {
        if (completedTopicIds.contains(topic.id)) {
          for (final q in topic.quizQuestions) {
            _grammarQuestions.add(q);
            _grammarQuestionTopics.add(topic.title);
          }
        }
      }
      _grammarQuestions.shuffle();
      if (_grammarQuestions.length > 15) {
        _grammarQuestionTopics = _grammarQuestionTopics.sublist(0, 15);
        _grammarQuestions = _grammarQuestions.sublist(0, 15);
      }

      setState(() => _isLoading = false);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Connection error. Make sure the API is running.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F172A)
          : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Revision'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            if (_mode != _RevisionMode.menu) {
              setState(() => _mode = _RevisionMode.menu);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null
            ? _buildError(theme)
            : _buildBody(theme, isDark),
      ),
    );
  }

  Widget _buildBody(ThemeData theme, bool isDark) {
    return switch (_mode) {
      _RevisionMode.menu => _buildMenu(theme, isDark),
      _RevisionMode.flashcards => _FlashcardSession(
        cards: _cards,
        onDone: () => setState(() => _mode = _RevisionMode.menu),
      ),
      _RevisionMode.grammar => _GrammarRevisionSession(
        questions: _grammarQuestions,
        topicNames: _grammarQuestionTopics,
        onDone: () => setState(() => _mode = _RevisionMode.menu),
      ),
    };
  }

  Widget _buildMenu(ThemeData theme, bool isDark) {
    final hasVocab = _cards.isNotEmpty;
    final hasGrammar = _grammarQuestions.isNotEmpty;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: [
        // Header
        Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: AppTheme.goldGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.psychology_alt_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Review & Revise',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Strengthen what you\'ve learned',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Stats overview
        _buildStatsRow(theme, isDark),
        const SizedBox(height: 24),

        // Flashcard mode
        _buildModeCard(
          theme,
          isDark,
          icon: Icons.style_rounded,
          title: 'Vocabulary Flashcards',
          subtitle: hasVocab
              ? '${_cards.length} words to review'
              : 'Learn some words first!',
          gradient: AppTheme.primaryGradient,
          shadowColor: const Color(0xFF6366F1),
          enabled: hasVocab,
          onTap: () => setState(() => _mode = _RevisionMode.flashcards),
          features: const [
            'Tap to flip cards',
            'Swipe right = Know it',
            'Swipe left = Still learning',
          ],
        ),
        const SizedBox(height: 16),

        // Grammar quiz mode
        _buildModeCard(
          theme,
          isDark,
          icon: Icons.quiz_rounded,
          title: 'Grammar Quick Quiz',
          subtitle: hasGrammar
              ? '${_grammarQuestions.length} questions ready'
              : 'Complete grammar topics first!',
          gradient: AppTheme.warmGradient,
          shadowColor: const Color(0xFFEC4899),
          enabled: hasGrammar,
          onTap: () => setState(() => _mode = _RevisionMode.grammar),
          features: const [
            'Random questions from completed topics',
            'Instant feedback',
            'Track your accuracy',
          ],
        ),
        const SizedBox(height: 24),

        Center(
          child: Text(
            'Revision strengthens memory retention',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(ThemeData theme, bool isDark) {
    return Row(
      children: [
        Expanded(
          child: _buildStatChip(
            theme,
            isDark,
            Icons.translate_rounded,
            '$_totalWordsLearned',
            'Words Learned',
            const Color(0xFF6366F1),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatChip(
            theme,
            isDark,
            Icons.rule_folder_rounded,
            '$_completedGrammarCount',
            'Grammar Done',
            const Color(0xFF8B5CF6),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatChip(
            theme,
            isDark,
            Icons.style_rounded,
            '${_cards.length}',
            'To Review',
            const Color(0xFFF59E0B),
          ),
        ),
      ],
    );
  }

  Widget _buildStatChip(
    ThemeData theme,
    bool isDark,
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildModeCard(
    ThemeData theme,
    bool isDark, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Gradient gradient,
    required Color shadowColor,
    required bool enabled,
    required VoidCallback onTap,
    required List<String> features,
  }) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
            ),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withValues(alpha: 0.06),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (enabled)
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: theme.colorScheme.primary,
                      size: 22,
                    ),
                ],
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: features
                    .map(
                      (f) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.06,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          f,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
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
              Icons.cloud_off_rounded,
              size: 54,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _loadRevisionData,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Data Models ─────────────────────────────────────────

enum _RevisionMode { menu, flashcards, grammar }

class _RevisionCard {
  final String word;
  final String pronunciation;
  final String gujaratiMeaning;
  final String englishMeaning;
  final String level;
  final List<String> sentences;

  const _RevisionCard({
    required this.word,
    required this.pronunciation,
    required this.gujaratiMeaning,
    required this.englishMeaning,
    required this.level,
    required this.sentences,
  });
}

// ─── Flashcard Session ───────────────────────────────────

class _FlashcardSession extends StatefulWidget {
  final List<_RevisionCard> cards;
  final VoidCallback onDone;

  const _FlashcardSession({required this.cards, required this.onDone});

  @override
  State<_FlashcardSession> createState() => _FlashcardSessionState();
}

class _FlashcardSessionState extends State<_FlashcardSession>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isFlipped = false;
  int _knownCount = 0;
  int _learningCount = 0;
  bool _isComplete = false;
  double _dragX = 0;

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_flipController.isAnimating) return;
    if (_isFlipped) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() => _isFlipped = !_isFlipped);
  }

  void _markKnown() {
    setState(() => _knownCount++);
    _nextCard();
  }

  void _markLearning() {
    setState(() => _learningCount++);
    _nextCard();
  }

  void _nextCard() {
    if (_isFlipped) {
      _flipController.value = 0;
      _isFlipped = false;
    }
    setState(() {
      _dragX = 0;
      if (_currentIndex + 1 >= widget.cards.length) {
        _isComplete = true;
      } else {
        _currentIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (_isComplete) return _buildResults(theme, isDark);

    final card = widget.cards[_currentIndex];
    final progress = (_currentIndex + 1) / widget.cards.length;

    return Column(
      children: [
        // Progress bar
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
          child: Row(
            children: [
              Text(
                '${_currentIndex + 1}/${widget.cards.length}',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 7,
                    backgroundColor: theme.colorScheme.primary.withValues(
                      alpha: 0.1,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$_knownCount',
                  style: const TextStyle(
                    color: Color(0xFF22C55E),
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$_learningCount',
                  style: const TextStyle(
                    color: Color(0xFFF59E0B),
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Swipe hint
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.arrow_back_rounded,
                    size: 14,
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.7),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Still learning',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFF59E0B).withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
              Text(
                'Tap to flip',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Know it',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF22C55E).withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 14,
                    color: const Color(0xFF22C55E).withValues(alpha: 0.7),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Card
        Expanded(
          child: GestureDetector(
            onTap: _flipCard,
            onHorizontalDragUpdate: (details) =>
                setState(() => _dragX += details.delta.dx),
            onHorizontalDragEnd: (details) {
              if (_dragX > 80) {
                _markKnown();
              } else if (_dragX < -80) {
                _markLearning();
              } else {
                setState(() => _dragX = 0);
              }
            },
            child: Center(
              child: AnimatedBuilder(
                animation: _flipAnimation,
                builder: (context, _) {
                  final angle = _flipAnimation.value * math.pi;
                  final isFront = angle < math.pi / 2;
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.translationValues(_dragX * 0.8, 0.0, 0.0)
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(angle),
                    child: isFront
                        ? _buildCardFront(theme, isDark, card)
                        : Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()..rotateY(math.pi),
                            child: _buildCardBack(theme, isDark, card),
                          ),
                  );
                },
              ),
            ),
          ),
        ),

        // Action buttons
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: _markLearning,
                    icon: const Icon(Icons.refresh_rounded, size: 20),
                    label: const Text('Still Learning'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFF59E0B),
                      side: const BorderSide(
                        color: Color(0xFFF59E0B),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: _markKnown,
                    icon: const Icon(Icons.check_rounded, size: 20),
                    label: const Text('Know It'),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF22C55E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardFront(ThemeData theme, bool isDark, _RevisionCard card) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: _dragX > 40
              ? const Color(0xFF22C55E).withValues(alpha: 0.5)
              : _dragX < -40
              ? const Color(0xFFF59E0B).withValues(alpha: 0.5)
              : theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
          width: _dragX.abs() > 40 ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : const Color(0xFF6366F1).withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              card.level,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            card.word,
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: theme.colorScheme.primary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            card.pronunciation,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontStyle: FontStyle.italic,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.5,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.touch_app_rounded,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  'Tap to see meaning',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack(ThemeData theme, bool isDark, _RevisionCard card) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
              : [const Color(0xFFF1F0FB), Colors.white],
        ),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : const Color(0xFF6366F1).withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              card.word,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            _buildMeaningSection(
              theme,
              'Gujarati',
              card.gujaratiMeaning,
              Icons.translate_rounded,
            ),
            const SizedBox(height: 16),
            _buildMeaningSection(
              theme,
              'English',
              card.englishMeaning,
              Icons.menu_book_rounded,
            ),
            if (card.sentences.isNotEmpty) ...[
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'EXAMPLE',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ...card.sentences.map(
                (s) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '"',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          s,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMeaningSection(
    ThemeData theme,
    String label,
    String meaning,
    IconData icon,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 15, color: theme.colorScheme.primary),
              const SizedBox(width: 6),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            meaning,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResults(ThemeData theme, bool isDark) {
    final total = widget.cards.length;
    final knownPercent = total > 0 ? (_knownCount / total * 100).round() : 0;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                gradient: knownPercent >= 70
                    ? AppTheme.successGradient
                    : AppTheme.goldGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color:
                        (knownPercent >= 70
                                ? const Color(0xFF10B981)
                                : const Color(0xFFF59E0B))
                            .withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                knownPercent >= 70
                    ? Icons.emoji_events_rounded
                    : Icons.psychology_rounded,
                color: Colors.white,
                size: 44,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              knownPercent >= 70 ? 'Great Recall!' : 'Keep Practicing!',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              knownPercent >= 70
                  ? 'You remembered most of your vocabulary!'
                  : 'Review these words again soon to strengthen memory.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildResultBadge(
                  theme,
                  '$_knownCount',
                  'Known',
                  const Color(0xFF22C55E),
                ),
                const SizedBox(width: 16),
                _buildResultBadge(
                  theme,
                  '$_learningCount',
                  'Learning',
                  const Color(0xFFF59E0B),
                ),
                const SizedBox(width: 16),
                _buildResultBadge(
                  theme,
                  '$knownPercent%',
                  'Recall',
                  theme.colorScheme.primary,
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: widget.onDone,
                  child: const Text(
                    'Back to Revision',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultBadge(
    ThemeData theme,
    String value,
    String label,
    Color color,
  ) {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Grammar Revision Session ────────────────────────────

class _GrammarRevisionSession extends StatefulWidget {
  final List<GrammarQuizQuestion> questions;
  final List<String> topicNames;
  final VoidCallback onDone;

  const _GrammarRevisionSession({
    required this.questions,
    required this.topicNames,
    required this.onDone,
  });

  @override
  State<_GrammarRevisionSession> createState() =>
      _GrammarRevisionSessionState();
}

class _GrammarRevisionSessionState extends State<_GrammarRevisionSession> {
  int _currentIndex = 0;
  int? _selectedAnswer;
  bool _answered = false;
  int _correctCount = 0;
  bool _isComplete = false;

  void _selectAnswer(int index) {
    if (_answered) return;
    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (index == widget.questions[_currentIndex].correctAnswerIndex)
        _correctCount++;
    });
  }

  void _nextQuestion() {
    if (_currentIndex + 1 >= widget.questions.length) {
      setState(() => _isComplete = true);
      return;
    }
    setState(() {
      _currentIndex++;
      _selectedAnswer = null;
      _answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (_isComplete) return _buildResults(theme, isDark);

    final question = widget.questions[_currentIndex];
    final topicName = _currentIndex < widget.topicNames.length
        ? widget.topicNames[_currentIndex]
        : '';
    final progress = (_currentIndex + 1) / widget.questions.length;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${_currentIndex + 1}/${widget.questions.length}',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '$_correctCount correct',
                    style: TextStyle(
                      color: const Color(0xFF22C55E),
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: theme.colorScheme.primary.withValues(
                    alpha: 0.1,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (topicName.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.menu_book_rounded,
                          size: 14,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            topicName,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.colorScheme.primary.withValues(alpha: 0.08),
                        theme.colorScheme.secondary.withValues(alpha: 0.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Text(
                    question.question,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                ...List.generate(question.options.length, (index) {
                  final isSelected = _selectedAnswer == index;
                  final isCorrect = index == question.correctAnswerIndex;
                  final showCorrect = _answered && isCorrect;
                  final showWrong = _answered && isSelected && !isCorrect;
                  final color = showCorrect
                      ? const Color(0xFF22C55E)
                      : showWrong
                      ? theme.colorScheme.error
                      : (isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outlineVariant);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: () => _selectAnswer(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color:
                              (showCorrect ||
                                  showWrong ||
                                  (!_answered && isSelected))
                              ? color.withValues(alpha: 0.08)
                              : (isDark
                                    ? const Color(0xFF1E293B)
                                    : Colors.white),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: color.withValues(
                              alpha: showCorrect || showWrong ? 1.0 : 0.5,
                            ),
                            width: showCorrect || showWrong ? 1.8 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: showCorrect
                                    ? const Color(0xFF22C55E)
                                    : showWrong
                                    ? theme.colorScheme.error
                                    : isSelected
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: showCorrect
                                  ? const Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    )
                                  : showWrong
                                  ? const Icon(
                                      Icons.close_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    )
                                  : Text(
                                      String.fromCharCode(65 + index),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 13,
                                        color: isSelected
                                            ? Colors.white
                                            : theme
                                                  .colorScheme
                                                  .onSurfaceVariant,
                                      ),
                                    ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                question.options[index],
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),

                if (_answered) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          (_selectedAnswer == question.correctAnswerIndex
                                  ? const Color(0xFF22C55E)
                                  : theme.colorScheme.error)
                              .withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color:
                            (_selectedAnswer == question.correctAnswerIndex
                                    ? const Color(0xFF22C55E)
                                    : theme.colorScheme.error)
                                .withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _selectedAnswer == question.correctAnswerIndex
                                  ? Icons.check_circle_rounded
                                  : Icons.info_rounded,
                              color:
                                  _selectedAnswer == question.correctAnswerIndex
                                  ? const Color(0xFF22C55E)
                                  : theme.colorScheme.error,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _selectedAnswer == question.correctAnswerIndex
                                  ? 'Correct!'
                                  : 'Not quite',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color:
                                    _selectedAnswer ==
                                        question.correctAnswerIndex
                                    ? const Color(0xFF22C55E)
                                    : theme.colorScheme.error,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          question.explanation,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton.icon(
                      onPressed: _nextQuestion,
                      icon: Icon(
                        _currentIndex < widget.questions.length - 1
                            ? Icons.arrow_forward_rounded
                            : Icons.flag_rounded,
                        size: 20,
                      ),
                      label: Text(
                        _currentIndex < widget.questions.length - 1
                            ? 'Next Question'
                            : 'See Results',
                      ),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResults(ThemeData theme, bool isDark) {
    final total = widget.questions.length;
    final percent = total > 0 ? (_correctCount / total * 100).round() : 0;
    final great = percent >= 70;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                gradient: great
                    ? AppTheme.successGradient
                    : AppTheme.warmGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color:
                        (great
                                ? const Color(0xFF10B981)
                                : const Color(0xFFEC4899))
                            .withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                great ? Icons.school_rounded : Icons.menu_book_rounded,
                color: Colors.white,
                size: 44,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              great ? 'Excellent Recall!' : 'Room to Grow',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              great
                  ? 'Your grammar knowledge is strong!'
                  : 'Review the topics you missed and try again.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildResultBadge(
                  theme,
                  '$_correctCount/$total',
                  'Correct',
                  const Color(0xFF22C55E),
                ),
                const SizedBox(width: 16),
                _buildResultBadge(
                  theme,
                  '$percent%',
                  'Accuracy',
                  theme.colorScheme.primary,
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: widget.onDone,
                  child: const Text(
                    'Back to Revision',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultBadge(
    ThemeData theme,
    String value,
    String label,
    Color color,
  ) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
