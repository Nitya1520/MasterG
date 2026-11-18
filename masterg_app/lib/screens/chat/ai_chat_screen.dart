import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../state/app_state.dart';
import '../../theme/theme.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final SpeechToText _speech = SpeechToText();
  bool _isTyping = false;
  bool _speechInitialized = false;
  bool _isListening = false;
  String _textBeforeDictation = '';
  String? _speechError;

  final List<String> _suggestions = [
    "Check my grammar",
    "Describe my day",
    "Teach me an idiom",
    "Practice greetings",
  ];

  @override
  void dispose() {
    _speech.cancel();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _toggleVoiceInput() async {
    if (_isListening) {
      await _speech.stop();
      return;
    }
    if (_isTyping) return;

    setState(() => _speechError = null);
    try {
      if (!_speechInitialized) {
        _speechInitialized = await _speech.initialize(
          onStatus: _handleSpeechStatus,
          onError: _handleSpeechError,
        );
      }
      if (!mounted) return;
      if (!_speechInitialized) {
        setState(() => _speechError = 'Speech recognition unavailable. Check microphone permissions.');
        return;
      }

      _textBeforeDictation = _textController.text.trim();
      await _speech.listen(
        onResult: _handleSpeechResult,
        listenOptions: SpeechListenOptions(
          cancelOnError: true,
          partialResults: true,
          listenMode: ListenMode.dictation,
          autoPunctuation: true,
          localeId: 'en_US',
          listenFor: const Duration(seconds: 45),
          pauseFor: const Duration(seconds: 3),
        ),
      );
      if (mounted) setState(() => _speechError = null);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isListening = false;
        _speechError = 'Could not start speech recognition. Check microphone permissions.';
      });
    }
  }

  void _handleSpeechStatus(String status) {
    if (!mounted) return;
    setState(() => _isListening = status == SpeechToText.listeningStatus);
  }

  void _handleSpeechError(dynamic _) {
    if (!mounted) return;
    setState(() {
      _isListening = false;
      _speechError = 'Speech recognition stopped. Tap the mic to retry.';
    });
  }

  void _handleSpeechResult(SpeechRecognitionResult result) {
    if (!mounted) return;
    final transcript = result.recognizedWords.trim();
    if (transcript.isEmpty) return;

    final prefix = _textBeforeDictation;
    final separator = prefix.isEmpty ? '' : ' ';
    final text = '$prefix$separator$transcript';
    _textController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
    setState(() => _speechError = null);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage([String? text]) async {
    if (_isTyping) return;
    if (_isListening) {
      await _speech.stop();
      if (!mounted) return;
    }
    final messageText = text ?? _textController.text.trim();
    if (messageText.isEmpty) return;

    final appState = AppStateProvider.of(context);
    _textController.clear();
    setState(() {
      _isTyping = true;
      _isListening = false;
      _speechError = null;
    });
    _scrollToBottom();

    final error = await appState.sendChatMessage(messageText);
    if (mounted) {
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), behavior: SnackBarBehavior.floating),
        );
      }
      setState(() => _isTyping = false);
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.warmGradient,
              ),
              child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("G-Bot", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                Row(
                  children: [
                    Container(
                      width: 7, height: 7,
                      decoration: const BoxDecoration(color: Color(0xFF22C55E), shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 5),
                    Text("AI English Tutor", style: theme.textTheme.bodySmall?.copyWith(fontSize: 11)),
                  ],
                ),
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(18),
                itemCount: appState.chatHistory.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == appState.chatHistory.length && _isTyping) {
                    return _buildTypingIndicator(theme);
                  }
                  return _buildMessageBubble(theme, isDark, appState.chatHistory[index]);
                },
              ),
            ),

            if (appState.chatHistory.length < 3)
              SizedBox(
                height: 44,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _suggestions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ActionChip(
                        backgroundColor: theme.colorScheme.surface,
                        surfaceTintColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        side: BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.2)),
                        label: Text(
                          _suggestions[index],
                          style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                        onPressed: () => _sendMessage(_suggestions[index]),
                      ),
                    );
                  },
                ),
              ),

            Container(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(top: BorderSide(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4))),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isListening || _speechError != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            _speechError == null ? Icons.graphic_eq_rounded : Icons.info_outline_rounded,
                            size: 16,
                            color: _speechError == null ? theme.colorScheme.primary : theme.colorScheme.error,
                          ),
                          const SizedBox(width: 7),
                          Expanded(
                            child: Text(
                              _speechError ?? 'Listening... speak now.',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: _speechError == null ? theme.colorScheme.primary : theme.colorScheme.error,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Row(
                    children: [
                      Container(
                        width: 42, height: 42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isListening
                              ? theme.colorScheme.error.withValues(alpha: 0.1)
                              : theme.colorScheme.primary.withValues(alpha: 0.08),
                        ),
                        child: IconButton(
                          iconSize: 20,
                          tooltip: _isListening ? 'Stop voice input' : 'Dictate a message',
                          icon: Icon(
                            _isListening ? Icons.stop_rounded : Icons.mic_rounded,
                            color: _isListening ? theme.colorScheme.error : theme.colorScheme.primary,
                          ),
                          onPressed: _toggleVoiceInput,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          onSubmitted: (_) => _sendMessage(),
                          decoration: const InputDecoration(
                            hintText: 'Type or dictate in English...',
                            filled: true,
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 42, height: 42,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppTheme.primaryGradient,
                        ),
                        child: IconButton(
                          iconSize: 20,
                          icon: const Icon(Icons.send_rounded, color: Colors.white),
                          onPressed: () => _sendMessage(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ThemeData theme, bool isDark, Message message) {
    if (!message.isUser) return _buildAssistantBubble(theme, isDark, message);

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.75),
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(4),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6366F1).withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          message.text,
          style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildAssistantBubble(ThemeData theme, bool isDark, Message message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.88),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(6),
            bottomRight: Radius.circular(18),
          ),
          border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4)),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withValues(alpha: 0.12) : Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 24, height: 24,
                    decoration: const BoxDecoration(shape: BoxShape.circle, gradient: AppTheme.warmGradient),
                    child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 13),
                  ),
                  const SizedBox(width: 7),
                  Text('G-Bot', style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w800)),
                ],
              ),
              const SizedBox(height: 10),
              _buildFormattedText(theme, message.text),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormattedText(ThemeData theme, String text) {
    final lines = text.trim().split('\n');
    final children = <Widget>[];
    var previousWasBlank = false;

    for (final rawLine in lines) {
      final line = rawLine.trim();
      if (line.isEmpty) {
        if (children.isNotEmpty && !previousWasBlank) children.add(const SizedBox(height: 8));
        previousWasBlank = true;
        continue;
      }

      final bulletMatch = RegExp(r'^(?:[-*•]|\d+[.)])\s+').firstMatch(line);
      final content = bulletMatch == null ? line : line.substring(bulletMatch.end);

      children.add(
        Padding(
          padding: EdgeInsets.only(bottom: rawLine == lines.last ? 0 : 4, left: bulletMatch == null ? 0 : 2),
          child: bulletMatch == null
              ? _buildRichText(theme, content)
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7, right: 8),
                      child: Container(
                        width: 5, height: 5,
                        decoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle),
                      ),
                    ),
                    Expanded(child: _buildRichText(theme, content)),
                  ],
                ),
        ),
      );
      previousWasBlank = false;
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children);
  }

  Widget _buildRichText(ThemeData theme, String text) {
    final spans = <TextSpan>[];
    final boldPattern = RegExp(r'\*\*(.+?)\*\*');
    var currentIndex = 0;

    for (final match in boldPattern.allMatches(text)) {
      if (match.start > currentIndex) spans.add(TextSpan(text: text.substring(currentIndex, match.start)));
      spans.add(TextSpan(text: match.group(1), style: const TextStyle(fontWeight: FontWeight.w800)));
      currentIndex = match.end;
    }
    if (currentIndex < text.length) spans.add(TextSpan(text: text.substring(currentIndex)));
    if (spans.isEmpty) spans.add(TextSpan(text: text));

    return SelectableText.rich(
      TextSpan(
        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface, fontSize: 14.5, height: 1.5),
        children: spans,
      ),
    );
  }

  Widget _buildTypingIndicator(ThemeData theme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(18),
          ),
          border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            return Container(
              margin: const EdgeInsets.only(right: 4),
              width: 7, height: 7,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ),
    );
  }
}
