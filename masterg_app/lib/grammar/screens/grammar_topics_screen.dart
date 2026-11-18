import 'package:flutter/material.dart';
import '../../state/app_state.dart';
import '../../theme/theme.dart';
import '../data/grammar_data.dart';
import '../models/grammar_topic.dart';

class GrammarTopicsScreen extends StatefulWidget {
  const GrammarTopicsScreen({super.key});

  @override
  State<GrammarTopicsScreen> createState() => _GrammarTopicsScreenState();
}

class _GrammarTopicsScreenState extends State<GrammarTopicsScreen> {
  late final List<GrammarTopic> _topics;
  List<GrammarTopic> _filteredTopics = [];
  String _query = '';
  bool _isLoading = true;
  Set<String> _completedTopicIds = <String>{};
  int _totalPoints = 0;
  int _completedTopics = 0;

  @override
  void initState() {
    super.initState();
    _topics = GrammarData.a1Topics;
    _filteredTopics = _topics;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _loadProgress();
    });
  }

  Future<void> _loadProgress() async {
    if (!mounted) return;

    final appState = AppStateProvider.of(context);
    if (appState.accessToken == null) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      return;
    }

    try {
      final progress = await appState.fetchGrammarProgress();
      if (!mounted) return;
      setState(() {
        _completedTopicIds =
            (progress['completed_topic_ids'] as List<dynamic>? ?? [])
                .map((e) => e.toString())
                .toSet();
        _totalPoints = progress['total_points'] ?? 0;
        _completedTopics = progress['completed_topics'] ?? 0;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  void _filterTopics(String value) {
    setState(() {
      _query = value.trim().toLowerCase();
      _filteredTopics = _topics.where((topic) {
        final haystack = '${topic.title} ${topic.shortDescription}'
            .toLowerCase();
        return haystack.contains(_query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Grammar')),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Search grammar topics...',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          onChanged: _filterTopics,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Search grammar topics...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: AppTheme.cardBorderRadius,
                            border: Border.all(
                              color: theme.colorScheme.outlineVariant
                                  .withValues(alpha:0.5),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.emoji_events_rounded,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Grammar Progress',
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      '$_completedTopics / ${_topics.length} topics completed',
                                    ),
                                    Text('$_totalPoints points'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                      itemCount: _filteredTopics.length,
                      itemBuilder: (context, index) {
                        final topic = _filteredTopics[index];
                        final isCompleted = _completedTopicIds.contains(
                          topic.id,
                        );
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: AppTheme.cardBorderRadius,
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              leading: CircleAvatar(
                                backgroundColor: isCompleted
                                    ? Colors.green.shade100
                                    : Colors.deepPurple.shade100,
                                child: Icon(
                                  isCompleted
                                      ? Icons.check_circle_rounded
                                      : Icons.menu_book_rounded,
                                  color: isCompleted
                                      ? Colors.green
                                      : Colors.deepPurple,
                                ),
                              ),
                              title: Text(
                                topic.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(topic.shortDescription),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    isCompleted ? 'Completed' : 'Not completed',
                                    style: TextStyle(
                                      color: isCompleted
                                          ? Colors.green
                                          : Colors.grey.shade700,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '+10 points',
                                    style: TextStyle(
                                      color: Colors.deepPurple.shade500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        GrammarTopicDetailScreen(
                                          topic: topic,
                                          onProgressUpdated: _loadProgress,
                                        ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class GrammarTopicDetailScreen extends StatefulWidget {
  final GrammarTopic topic;
  final Future<void> Function() onProgressUpdated;

  const GrammarTopicDetailScreen({
    super.key,
    required this.topic,
    required this.onProgressUpdated,
  });

  @override
  State<GrammarTopicDetailScreen> createState() =>
      _GrammarTopicDetailScreenState();
}

class _GrammarTopicDetailScreenState extends State<GrammarTopicDetailScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  int _correctAnswers = 0;
  bool _quizFinished = false;
  bool _isSubmitting = false;
  bool _quizSubmitted = false;
  String? _resultMessage;
  bool _completed = false;
  bool _alreadyCompleted = false;
  void _submitAnswer() {
    final question = widget.topic.quizQuestions[_currentQuestionIndex];
    final isCorrect = _selectedAnswerIndex == question.correctAnswerIndex;
    if (isCorrect) {
      _correctAnswers += 1;
    }
    setState(() {
      _quizSubmitted = true;
      _resultMessage = isCorrect ? 'Correct!' : 'Not quite.';
    });
  }

  Future<void> _nextQuestion() async {
    if (_currentQuestionIndex < widget.topic.quizQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex += 1;
        _selectedAnswerIndex = null;
        _quizSubmitted = false;
        _resultMessage = null;
      });
      return;
    }

    await _finishQuiz();
  }

  Future<void> _finishQuiz() async {
    setState(() => _quizFinished = true);
    if (_correctAnswers == widget.topic.quizQuestions.length) {
      final appState = AppStateProvider.of(context);
      if (appState.accessToken == null) {
        setState(() {
          _resultMessage = 'Internet connection required to save progress.';
        });
        return;
      }

      setState(() => _isSubmitting = true);
      try {
        final response = await appState.completeGrammarTopic(
          widget.topic.id,
          _correctAnswers,
        );
        setState(() {
          _completed = response['topic_completed'] == true;
          _alreadyCompleted = response['already_completed'] == true;
          _resultMessage = _alreadyCompleted
              ? '✓ Already Completed\nNo additional points awarded.'
              : '🎉 Excellent!\nYou completed this topic.';
        });
        await widget.onProgressUpdated();
      } catch (e) {
        setState(() {
          _resultMessage = e.toString();
        });
      } finally {
        setState(() => _isSubmitting = false);
      }
    } else {
      setState(() {
        _resultMessage =
            'Keep practicing!\nYou got $_correctAnswers/${widget.topic.quizQuestions.length}.\nYou need all 5 answers correct to complete this topic.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final question = widget.topic.quizQuestions[_currentQuestionIndex];
    final isCorrect = _selectedAnswerIndex == question.correctAnswerIndex;

    return Scaffold(
      appBar: AppBar(title: Text(widget.topic.title)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.topic.title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(widget.topic.introduction, style: theme.textTheme.bodyLarge),
              const SizedBox(height: 20),
              _buildSection('When to use', widget.topic.whenToUse),
              const SizedBox(height: 16),
              _buildSection('Rules', widget.topic.rules),
              const SizedBox(height: 16),
              _buildSection('Structures', widget.topic.structures),
              const SizedBox(height: 16),
              _buildSection('Examples', widget.topic.examples),
              const SizedBox(height: 16),
              _buildSection('Common mistakes', widget.topic.commonMistakes),
              const SizedBox(height: 16),
              _buildSection('Tips', widget.topic.tips),
              const SizedBox(height: 24),
              Text(
                'Quick practice',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Choose the best answer to complete the sentence.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              if (!_quizFinished)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'QUESTION ${_currentQuestionIndex + 1}',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          '${_currentQuestionIndex + 1} / ${widget.topic.quizQuestions.length}',
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value:
                            (_currentQuestionIndex + 1) /
                            widget.topic.quizQuestions.length,
                        minHeight: 6,
                        backgroundColor: theme.colorScheme.primary.withValues(
                          alpha: 0.12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            theme.colorScheme.primary.withValues(alpha: 0.11),
                            theme.colorScheme.secondary.withValues(alpha: 0.07),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.16,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.edit_note_rounded,
                                color: theme.colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 7),
                              Text(
                                'COMPLETE THE SENTENCE',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.7,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            question.question,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontSize: 20,
                              height: 1.4,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'YOUR ANSWER',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...List.generate(question.options.length, (index) {
                      final isSelected = _selectedAnswerIndex == index;
                      final isCorrectOption =
                          _quizSubmitted &&
                          index == question.correctAnswerIndex;
                      final isWrongSelection =
                          _quizSubmitted &&
                          isSelected &&
                          index != question.correctAnswerIndex;
                      final highlightColor = isCorrectOption
                          ? const Color(0xFF16A36A)
                          : isWrongSelection
                          ? theme.colorScheme.error
                          : theme.colorScheme.primary;
                      final isHighlighted =
                          isCorrectOption ||
                          isWrongSelection ||
                          (!_quizSubmitted && isSelected);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 9),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          decoration: BoxDecoration(
                            color: isHighlighted
                                ? highlightColor.withValues(alpha: 0.09)
                                : theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(17),
                            border: Border.all(
                              color: isHighlighted
                                  ? highlightColor
                                  : theme.colorScheme.outlineVariant.withValues(
                                      alpha: 0.65,
                                    ),
                              width: isHighlighted ? 1.6 : 1,
                            ),
                            boxShadow: isSelected && !_quizSubmitted
                                ? [
                                    BoxShadow(
                                      color: theme.colorScheme.primary
                                          .withValues(alpha: 0.08),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : null,
                          ),
                          child: InkWell(
                            onTap: _quizSubmitted
                                ? null
                                : () => setState(
                                    () => _selectedAnswerIndex = index,
                                  ),
                            borderRadius: BorderRadius.circular(17),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 13,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 34,
                                    height: 34,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isHighlighted
                                          ? highlightColor
                                          : theme
                                                .colorScheme
                                                .surfaceContainerHighest,
                                      borderRadius: BorderRadius.circular(11),
                                    ),
                                    child: isCorrectOption
                                        ? const Icon(
                                            Icons.check_rounded,
                                            color: Colors.white,
                                            size: 20,
                                          )
                                        : isWrongSelection
                                        ? const Icon(
                                            Icons.close_rounded,
                                            color: Colors.white,
                                            size: 20,
                                          )
                                        : Text(
                                            String.fromCharCode(65 + index),
                                            style: TextStyle(
                                              color: isHighlighted
                                                  ? Colors.white
                                                  : theme
                                                        .colorScheme
                                                        .onSurfaceVariant,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 13,
                                            ),
                                          ),
                                  ),
                                  const SizedBox(width: 13),
                                  Expanded(
                                    child: Text(
                                      question.options[index],
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(
                                            fontWeight: isSelected
                                                ? FontWeight.w800
                                                : FontWeight.w600,
                                            color: isHighlighted
                                                ? highlightColor
                                                : theme.colorScheme.onSurface,
                                          ),
                                    ),
                                  ),
                                  if (!_quizSubmitted && isSelected)
                                    Icon(
                                      Icons.radio_button_checked_rounded,
                                      color: theme.colorScheme.primary,
                                    )
                                  else if (!_quizSubmitted)
                                    Icon(
                                      Icons.radio_button_unchecked_rounded,
                                      color: theme.colorScheme.outline,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    if (!_quizSubmitted)
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: SizedBox(
                          height: 54,
                          child: FilledButton.icon(
                            onPressed: _selectedAnswerIndex == null
                                ? null
                                : _submitAnswer,
                            icon: const Icon(
                              Icons.check_circle_outline_rounded,
                            ),
                            label: const Text('Check answer'),
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      Container(
                        margin: const EdgeInsets.only(top: 7),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              (isCorrect
                                      ? const Color(0xFF16A36A)
                                      : theme.colorScheme.error)
                                  .withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color:
                                (isCorrect
                                        ? const Color(0xFF16A36A)
                                        : theme.colorScheme.error)
                                    .withValues(alpha: 0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  isCorrect
                                      ? Icons.check_circle_rounded
                                      : Icons.info_rounded,
                                  color: isCorrect
                                      ? const Color(0xFF16A36A)
                                      : theme.colorScheme.error,
                                ),
                                const SizedBox(width: 9),
                                Text(
                                  isCorrect
                                      ? 'That’s correct!'
                                      : 'Keep learning',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: isCorrect
                                        ? const Color(0xFF16A36A)
                                        : theme.colorScheme.error,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 7),
                            Text(
                              question.explanation,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                height: 1.45,
                              ),
                            ),
                            const SizedBox(height: 14),
                            SizedBox(
                              height: 50,
                              child: FilledButton.icon(
                                onPressed: _isSubmitting ? null : _nextQuestion,
                                icon: Icon(
                                  _currentQuestionIndex <
                                          widget.topic.quizQuestions.length - 1
                                      ? Icons.arrow_forward_rounded
                                      : Icons.flag_rounded,
                                ),
                                label: Text(
                                  _currentQuestionIndex <
                                          widget.topic.quizQuestions.length - 1
                                      ? 'Next question'
                                      : 'Finish quiz',
                                ),
                                style: FilledButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                )
              else
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: AppTheme.cardBorderRadius,
                    border: Border.all(
                      color: theme.colorScheme.outlineVariant.withValues(alpha:0.5),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _resultMessage ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (_completed) ...[
                        const SizedBox(height: 8),
                        Text('+10 Points awarded'),
                      ] else if (_alreadyCompleted) ...[
                        const SizedBox(height: 8),
                        const Text('✓ Already Completed'),
                      ],
                      if (_isSubmitting)
                        const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.arrow_right_rounded, size: 18),
                const SizedBox(width: 6),
                Expanded(child: Text(item)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
