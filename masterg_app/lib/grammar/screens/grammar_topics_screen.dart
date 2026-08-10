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
        _completedTopicIds = (progress['completed_topic_ids'] as List<dynamic>? ?? []).map((e) => e.toString()).toSet();
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
        final haystack = '${topic.title} ${topic.shortDescription}'.toLowerCase();
        return haystack.contains(_query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grammar'),
      ),
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
                        Text('Search grammar topics...', style: theme.textTheme.bodyMedium),
                        const SizedBox(height: 8),
                        TextField(
                          onChanged: _filterTopics,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Search grammar topics...',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: AppTheme.cardBorderRadius,
                            border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.emoji_events_rounded, color: Colors.amber),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Grammar Progress', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                                    Text('$_completedTopics / ${_topics.length} topics completed'),
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
                        final isCompleted = _completedTopicIds.contains(topic.id);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: AppTheme.cardBorderRadius),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              leading: CircleAvatar(
                                backgroundColor: isCompleted ? Colors.green.shade100 : Colors.deepPurple.shade100,
                                child: Icon(isCompleted ? Icons.check_circle_rounded : Icons.menu_book_rounded, color: isCompleted ? Colors.green : Colors.deepPurple),
                              ),
                              title: Text(topic.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(topic.shortDescription),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(isCompleted ? 'Completed' : 'Not completed', style: TextStyle(color: isCompleted ? Colors.green : Colors.grey.shade700, fontWeight: FontWeight.w600)),
                                  Text('+10 points', style: TextStyle(color: Colors.deepPurple.shade500, fontSize: 12)),
                                ],
                              ),
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => GrammarTopicDetailScreen(topic: topic, onProgressUpdated: _loadProgress)),
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

  const GrammarTopicDetailScreen({super.key, required this.topic, required this.onProgressUpdated});

  @override
  State<GrammarTopicDetailScreen> createState() => _GrammarTopicDetailScreenState();
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
  int _pointsAwarded = 0;

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
        final response = await appState.completeGrammarTopic(widget.topic.id, _correctAnswers);
        setState(() {
          _completed = response['topic_completed'] == true;
          _alreadyCompleted = response['already_completed'] == true;
          _pointsAwarded = (response['points_awarded'] ?? 0) as int;
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
        _resultMessage = 'Keep practicing!\nYou got ${_correctAnswers}/${widget.topic.quizQuestions.length}.\nYou need all 5 answers correct to complete this topic.';
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
              Text(widget.topic.title, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
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
              Text('5-question quiz', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              if (!_quizFinished)
                Column(
                  children: [
                    Text('Question ${_currentQuestionIndex + 1} of ${widget.topic.quizQuestions.length}', style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: AppTheme.cardBorderRadius,
                        border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
                      ),
                      child: Text(question.question, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(question.options.length, (index) {
                      final isSelected = _selectedAnswerIndex == index;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: InkWell(
                          onTap: _quizSubmitted ? null : () => setState(() => _selectedAnswerIndex = index),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isSelected ? theme.colorScheme.primary.withOpacity(0.12) : theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant.withOpacity(0.5)),
                            ),
                            child: Text(question.options[index]),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 12),
                    if (!_quizSubmitted)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _selectedAnswerIndex == null ? null : _submitAnswer,
                          child: const Text('Check Answer'),
                        ),
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(isCorrect ? 'Correct!' : 'Not quite.', style: TextStyle(color: isCorrect ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text(question.explanation),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isSubmitting ? null : _nextQuestion,
                              child: Text(_currentQuestionIndex < widget.topic.quizQuestions.length - 1 ? 'Next Question' : 'Finish Quiz'),
                            ),
                          ),
                        ],
                      ),
                  ],
                )
              else
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: AppTheme.cardBorderRadius,
                    border: Border.all(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_resultMessage ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      if (_completed) ...[
                        const SizedBox(height: 8),
                        Text('+10 Points awarded'),
                      ] else if (_alreadyCompleted) ...[
                        const SizedBox(height: 8),
                        const Text('✓ Already Completed'),
                      ],
                      if (_isSubmitting) const Padding(
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
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.arrow_right_rounded, size: 18),
              const SizedBox(width: 6),
              Expanded(child: Text(item)),
            ],
          ),
        )),
      ],
    );
  }
}
