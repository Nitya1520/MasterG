import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../config/api_config.dart';
import '../../state/app_state.dart';

class RapidFireScreen extends StatefulWidget {
  const RapidFireScreen({super.key});

  @override
  State<RapidFireScreen> createState() => _RapidFireScreenState();
}

class _RapidFireScreenState extends State<RapidFireScreen> {
  final TextEditingController _answerController = TextEditingController();
  late AppState _appState;
  List<Map<String, String>> _words = [];
  bool _hasInitialized = false;
  bool _isLoading = true;
  bool _isSaving = false;
  bool _isComplete = false;
  bool _scoreSaved = false;
  int _currentIndex = 0;
  int _score = 0;
  int _totalPoints = 0;
  String? _errorMessage;
  String? _saveError;
  String? _answerFeedback;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hasInitialized) return;

    _hasInitialized = true;
    _appState = AppStateProvider.of(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _loadRound();
    });
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  Future<void> _loadRound() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _appState.authenticatedRequest(
        (token) => http
            .post(
              Uri.parse('${ApiConfig.apiBaseUrl}/vocabulary/rapid-fire/words/'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: '{}',
            )
            .timeout(const Duration(seconds: 35)),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw Exception(
          data is Map<String, dynamic>
              ? data['error']?.toString() ??
                    'Could not load a vocabulary round.'
              : 'Could not load a vocabulary round.',
        );
      }

      final rawWords = data['words'];
      if (rawWords is! List || rawWords.length != 10) {
        throw Exception('The server did not return 10 vocabulary words.');
      }
      final words = rawWords.map((item) {
        if (item is! Map ||
            item['english'] is! String ||
            item['gujarati'] is! String) {
          throw Exception('The server returned an invalid vocabulary word.');
        }
        return {
          'english': (item['english'] as String).trim(),
          'gujarati': (item['gujarati'] as String).trim(),
        };
      }).toList();

      if (!mounted) return;
      setState(() {
        _words = words;
        _isLoading = false;
        _currentIndex = 0;
        _score = 0;
        _isComplete = false;
        _scoreSaved = false;
        _totalPoints = _appState.pointBalance;
        _answerFeedback = null;
        _answerController.clear();
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = error.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  void _checkAnswer() {
    if (_words.isEmpty || _isComplete || _isSaving) return;
    final answer = _answerController.text.trim().toLowerCase();
    if (answer.isEmpty) {
      setState(() => _answerFeedback = 'Type the English spelling first.');
      return;
    }

    final expected = _words[_currentIndex]['english']!.trim().toLowerCase();
    if (answer != expected) {
      setState(() => _answerFeedback = 'Not quite. Try spelling it again.');
      return;
    }

    _answerController.clear();
    setState(() {
      _score += 1;
      _currentIndex += 1;
      _answerFeedback = null;
      if (_currentIndex == _words.length) {
        _isComplete = true;
      }
    });

    if (_isComplete) _saveScore();
  }

  void _skipWord() {
    if (_words.isEmpty || _isComplete || _isSaving) return;

    _answerController.clear();
    setState(() {
      _currentIndex += 1;
      _answerFeedback = null;
      if (_currentIndex == _words.length) {
        _isComplete = true;
      }
    });

    if (_isComplete) _saveScore();
  }

  Future<void> _saveScore() async {
    if (_isSaving || _scoreSaved) return;
    setState(() {
      _isSaving = true;
      _saveError = null;
    });
    try {
      final points = await _appState.submitPoints(
        _score,
        activity: 'rapid_fire',
      );
      if (!mounted) return;
      setState(() {
        _totalPoints = points;
        _scoreSaved = true;
      });
    } catch (error) {
      if (!mounted) return;
      setState(
        () => _saveError = error.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rapid Fire'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null
            ? _buildError(theme)
            : _isComplete
            ? _buildResults(theme)
            : _buildQuestion(theme),
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
              size: 48,
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
              onPressed: _loadRound,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(ThemeData theme) {
    final word = _words[_currentIndex];
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Word ${_currentIndex + 1} of 10',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '$_score correct',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: _currentIndex / 10,
                  minHeight: 7,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.translate_rounded,
                      color: theme.colorScheme.primary,
                      size: 30,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      word['gujarati']!,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Spell this word in English',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _answerController,
                autofocus: true,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _checkAnswer(),
                decoration: InputDecoration(
                  labelText: 'English spelling',
                  border: const OutlineInputBorder(),
                  errorText: _answerFeedback,
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 52,
                child: FilledButton.icon(
                  onPressed: _checkAnswer,
                  icon: const Icon(Icons.check_rounded),
                  label: const Text('Check spelling'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: _skipWord,
                  icon: const Icon(Icons.skip_next_rounded),
                  label: const Text('Next (skip word)'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResults(ThemeData theme) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.bolt_rounded,
              size: 58,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Round complete',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '$_score / 10',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _scoreSaved ? 'Added to your points' : 'Saving your points…',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 6),
            Text(
              'Total: $_totalPoints points',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            if (_saveError != null) ...[
              const SizedBox(height: 10),
              Text(
                _saveError!,
                textAlign: TextAlign.center,
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ],
            const SizedBox(height: 24),
            if (_isSaving)
              const CircularProgressIndicator()
            else if (!_scoreSaved)
              FilledButton.icon(
                onPressed: _saveScore,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Retry saving points'),
              )
            else
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Done'),
              ),
          ],
        ),
      ),
    );
  }
}
