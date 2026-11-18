import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../state/app_state.dart';
import '../../theme/theme.dart';

class SpeakingPracticeScreen extends StatefulWidget {
  const SpeakingPracticeScreen({super.key});

  @override
  State<SpeakingPracticeScreen> createState() => _SpeakingPracticeScreenState();
}

class _SpeakingPracticeScreenState extends State<SpeakingPracticeScreen>
    with TickerProviderStateMixin {
  final SpeechToText _speech = SpeechToText();
  final FlutterTts _tts = FlutterTts();
  final ScrollController _scrollController = ScrollController();

  bool _speechInitialized = false;
  bool _conversationActive = false;
  bool _isListening = false;
  bool _isThinking = false;
  bool _isSpeaking = false;
  bool _hasCompletedTurn = false;
  bool _sessionRewarded = false;
  String _recognizedText = '';
  String? _errorMessage;

  late AnimationController _idleController;
  late AnimationController _pulseController;
  late AnimationController _mouthController;
  late AnimationController _blinkController;
  late Animation<double> _idleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _mouthAnimation;

  @override
  void initState() {
    super.initState();
    unawaited(_configureSpeechOutput());

    _idleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
    _idleAnimation = Tween<double>(begin: -4.0, end: 4.0).animate(
      CurvedAnimation(parent: _idleController, curve: Curves.easeInOut),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _mouthController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..repeat(reverse: true);
    _mouthAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _mouthController, curve: Curves.easeInOut),
    );

    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _startBlinkLoop();
  }

  void _startBlinkLoop() {
    Future.delayed(Duration(milliseconds: 2500 + math.Random().nextInt(2000)), () {
      if (!mounted) return;
      _blinkController.forward().then((_) {
        if (!mounted) return;
        _blinkController.reverse().then((_) {
          if (mounted) _startBlinkLoop();
        });
      });
    });
  }

  @override
  void dispose() {
    _conversationActive = false;
    unawaited(_speech.cancel());
    unawaited(_tts.stop());
    _scrollController.dispose();
    _idleController.dispose();
    _pulseController.dispose();
    _mouthController.dispose();
    _blinkController.dispose();
    super.dispose();
  }

  Future<void> _configureSpeechOutput() async {
    try {
      await _tts.setLanguage('en-US');
      await _tts.setSpeechRate(0.48);
      await _tts.awaitSpeakCompletion(true);
    } catch (_) {
      if (mounted) {
        setState(() => _errorMessage = 'Text-to-speech is unavailable on this device.');
      }
    }
  }

  Future<void> _startConversation() async {
    setState(() {
      _conversationActive = true;
      _errorMessage = null;
      _sessionRewarded = false;
      _hasCompletedTurn = false;
    });

    try {
      if (!_speechInitialized) {
        _speechInitialized = await _speech.initialize(
          onStatus: _handleSpeechStatus,
          onError: _handleSpeechError,
        );
      }
      if (!mounted) return;
      if (!_speechInitialized) {
        throw Exception('Speech recognition is unavailable. Check microphone permissions.');
      }
      await _listenForUser();
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _conversationActive = false;
        _errorMessage = error.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  Future<void> _listenForUser() async {
    if (!_conversationActive || _isThinking || _isSpeaking || !_speechInitialized) return;

    try {
      await _speech.listen(
        onResult: _handleSpeechResult,
        listenOptions: SpeechListenOptions(
          cancelOnError: true,
          partialResults: true,
          listenMode: ListenMode.dictation,
          autoPunctuation: true,
          localeId: 'en_US',
          listenFor: const Duration(seconds: 45),
          pauseFor: const Duration(seconds: 2),
        ),
      );
      if (mounted) setState(() => _errorMessage = null);
    } catch (error) {
      if (!mounted) return;
      setState(() => _errorMessage = 'Could not start listening: $error');
    }
  }

  void _handleSpeechStatus(String status) {
    if (!mounted) return;
    setState(() => _isListening = status == SpeechToText.listeningStatus);
  }

  void _handleSpeechError(dynamic error) {
    if (!mounted) return;
    setState(() {
      _isListening = false;
      _errorMessage = 'Speech recognition stopped. Tap the mic to try again.';
    });
  }

  void _handleSpeechResult(SpeechRecognitionResult result) {
    final transcript = result.recognizedWords.trim();
    if (!mounted || transcript.isEmpty) return;

    setState(() => _recognizedText = transcript);
    if (result.finalResult && !_isThinking) {
      unawaited(_sendToAssistant(transcript));
    }
  }

  Future<void> _sendToAssistant(String transcript) async {
    if (!_conversationActive || _isThinking) return;
    setState(() {
      _isListening = false;
      _isThinking = true;
      _recognizedText = '';
      _errorMessage = null;
    });
    final appState = AppStateProvider.of(context);
    await _speech.stop();

    final error = await appState.sendChatMessage(transcript);
    if (!mounted) return;
    if (error != null) {
      setState(() {
        _isThinking = false;
        _errorMessage = error;
      });
      _scrollToLatestMessage();
      return;
    }

    final messages = appState.chatHistory;
    final reply = messages.isNotEmpty && !messages.last.isUser ? messages.last.text : null;
    if (reply == null) {
      setState(() {
        _isThinking = false;
        _errorMessage = 'The assistant did not return a reply. Try again.';
      });
      return;
    }

    _hasCompletedTurn = true;
    _scrollToLatestMessage();
    setState(() {
      _isThinking = false;
      _isSpeaking = true;
    });

    try {
      await _tts.speak(reply);
    } catch (_) {
      if (mounted) {
        setState(() => _errorMessage = 'Could not play the assistant reply aloud.');
      }
    }

    if (!mounted) return;
    setState(() => _isSpeaking = false);
    if (_conversationActive) await _listenForUser();
  }

  Future<void> _endConversation() async {
    if (!_conversationActive) return;
    final appState = AppStateProvider.of(context);
    setState(() {
      _conversationActive = false;
      _isListening = false;
      _isThinking = false;
      _isSpeaking = false;
      _recognizedText = '';
    });
    await _speech.stop();
    await _tts.stop();

    if (_hasCompletedTurn && !_sessionRewarded) {
      try {
        await appState.completeSpeakingSession();
        _sessionRewarded = true;
      } catch (_) {
        if (mounted) {
          setState(() => _errorMessage = 'Conversation ended, but speaking points could not be saved.');
        }
      }
    }
  }

  void _scrollToLatestMessage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(0, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
      }
    });
  }

  String get _statusLabel {
    if (_isListening) return 'Listening...';
    if (_isThinking) return 'Thinking...';
    if (_isSpeaking) return 'Speaking...';
    if (_conversationActive) return 'Your turn!';
    return 'Tap to start';
  }

  Color _statusColor(ThemeData theme) {
    if (_isListening) return const Color(0xFF22C55E);
    if (_isThinking) return const Color(0xFFF59E0B);
    if (_isSpeaking) return theme.colorScheme.primary;
    return theme.colorScheme.onSurfaceVariant;
  }

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final messages = appState.chatHistory;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F0FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Speaking Practice'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () async {
            if (_conversationActive) await _endConversation();
            if (context.mounted) Navigator.pop(context);
          },
        ),
        actions: [
          if (_conversationActive)
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8, height: 8,
                    decoration: const BoxDecoration(color: Color(0xFFEF4444), shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 6),
                  const Text('LIVE', style: TextStyle(color: Color(0xFFEF4444), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                ],
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Cartoon character area
            _buildCharacterArea(theme, isDark),

            // Chat messages
            Expanded(
              child: messages.isEmpty && !_conversationActive
                  ? _buildEmptyState(theme)
                  : messages.isEmpty
                      ? Center(
                          child: Text(
                            'Say hello to start!',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          reverse: true,
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                          itemCount: messages.length + (_recognizedText.isNotEmpty ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == 0 && _recognizedText.isNotEmpty) {
                              return _buildPartialTranscript(theme);
                            }
                            final msgIndex = _recognizedText.isNotEmpty ? index - 1 : index;
                            final message = messages[messages.length - 1 - msgIndex];
                            return _buildMessage(theme, isDark, message);
                          },
                        ),
            ),

            if (_errorMessage != null) _buildError(theme),

            // Bottom controls
            _buildBottomControls(theme, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacterArea(ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: Listenable.merge([_idleAnimation, _pulseAnimation, _mouthAnimation, _blinkController]),
            builder: (context, _) {
              return Transform.translate(
                offset: Offset(0, _idleAnimation.value),
                child: Transform.scale(
                  scale: (_isSpeaking || _isListening) ? _pulseAnimation.value : 1.0,
                  child: SizedBox(
                    width: 140,
                    height: 140,
                    child: CustomPaint(
                      painter: _GBotCharacterPainter(
                        mouthOpen: _isSpeaking ? _mouthAnimation.value : (_isListening ? 0.15 : 0.0),
                        blinkAmount: _blinkController.value,
                        isThinking: _isThinking,
                        isListening: _isListening,
                        isSpeaking: _isSpeaking,
                        primaryColor: theme.colorScheme.primary,
                        isDark: isDark,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Container(
              key: ValueKey(_statusLabel),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: _statusColor(theme).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isListening)
                    _buildPulseDot(const Color(0xFF22C55E))
                  else if (_isThinking)
                    SizedBox(
                      width: 14, height: 14,
                      child: CircularProgressIndicator(strokeWidth: 2, color: _statusColor(theme)),
                    )
                  else if (_isSpeaking)
                    Icon(Icons.volume_up_rounded, size: 16, color: _statusColor(theme)),
                  if (_isListening || _isThinking || _isSpeaking) const SizedBox(width: 8),
                  Text(
                    _statusLabel,
                    style: TextStyle(
                      color: _statusColor(theme),
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPulseDot(Color color) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          width: 10 + (_pulseAnimation.value - 0.95) * 30,
          height: 10 + (_pulseAnimation.value - 0.95) * 30,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72, height: 72,
              decoration: BoxDecoration(
                gradient: AppTheme.warmGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: const Color(0xFF6366F1).withValues(alpha: 0.2), blurRadius: 20, offset: const Offset(0, 8)),
                ],
              ),
              child: const Icon(Icons.mic_rounded, color: Colors.white, size: 34),
            ),
            const SizedBox(height: 24),
            Text(
              'Practice Speaking English',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              'Have a real-time voice conversation with G-Bot.\nSpeak naturally and get instant feedback!',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(ThemeData theme, bool isDark, Message message) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.78),
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: isUser ? AppTheme.primaryGradient : null,
          color: isUser ? null : (isDark ? const Color(0xFF1E293B) : Colors.white),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 18),
          ),
          border: isUser ? null : Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4)),
          boxShadow: [
            BoxShadow(
              color: isUser
                  ? const Color(0xFF6366F1).withValues(alpha: 0.12)
                  : Colors.black.withValues(alpha: isDark ? 0.1 : 0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUser) ...[
              Container(
                width: 22, height: 22,
                decoration: const BoxDecoration(shape: BoxShape.circle, gradient: AppTheme.warmGradient),
                child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 12),
              ),
              const SizedBox(width: 10),
            ],
            Flexible(
              child: Text(
                message.text,
                style: TextStyle(
                  color: isUser ? Colors.white : theme.colorScheme.onSurface,
                  fontSize: 14.5,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartialTranscript(ThemeData theme) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.78),
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.08),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(4),
          ),
          border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.2), style: BorderStyle.solid),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.graphic_eq_rounded, size: 16, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                _recognizedText,
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.colorScheme.error.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, size: 18, color: theme.colorScheme.error),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _errorMessage!,
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls(ThemeData theme, bool isDark) {
    final busy = _isThinking || _isSpeaking;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withValues(alpha: 0.25) : const Color(0xFF6366F1).withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_conversationActive && !_isListening && !busy)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: _listenForUser,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mic_rounded, size: 18, color: theme.colorScheme.primary),
                    const SizedBox(width: 6),
                    Text(
                      'Tap to resume listening',
                      style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          Row(
            children: [
              if (_conversationActive) ...[
                // End conversation button
                Container(
                  width: 54, height: 54,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: IconButton(
                    onPressed: busy ? null : _endConversation,
                    icon: const Icon(Icons.call_end_rounded, color: Color(0xFFEF4444)),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: SizedBox(
                  height: 54,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: _conversationActive ? null : AppTheme.primaryGradient,
                      color: _conversationActive
                          ? (busy ? theme.colorScheme.surfaceContainerHighest : theme.colorScheme.primary.withValues(alpha: 0.1))
                          : null,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: _conversationActive
                          ? null
                          : [BoxShadow(color: const Color(0xFF6366F1).withValues(alpha: 0.25), blurRadius: 16, offset: const Offset(0, 6))],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: busy ? null : (_conversationActive ? _listenForUser : _startConversation),
                        borderRadius: BorderRadius.circular(16),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _conversationActive
                                    ? (_isListening ? Icons.graphic_eq_rounded : Icons.mic_rounded)
                                    : Icons.mic_rounded,
                                color: _conversationActive ? theme.colorScheme.primary : Colors.white,
                                size: 22,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                _conversationActive
                                    ? (_isListening ? 'Listening...' : (busy ? 'Please wait...' : 'Tap to speak'))
                                    : 'Start Voice Conversation',
                                style: TextStyle(
                                  color: _conversationActive ? theme.colorScheme.primary : Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GBotCharacterPainter extends CustomPainter {
  final double mouthOpen;
  final double blinkAmount;
  final bool isThinking;
  final bool isListening;
  final bool isSpeaking;
  final Color primaryColor;
  final bool isDark;

  _GBotCharacterPainter({
    required this.mouthOpen,
    required this.blinkAmount,
    required this.isThinking,
    required this.isListening,
    required this.isSpeaking,
    required this.primaryColor,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = size.width * 0.42;

    // Shadow
    canvas.drawCircle(
      Offset(cx, cy + 6),
      radius + 4,
      Paint()
        ..color = primaryColor.withValues(alpha: 0.08)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
    );

    // Body glow for active states
    if (isSpeaking || isListening) {
      canvas.drawCircle(
        Offset(cx, cy),
        radius + 10,
        Paint()
          ..color = (isSpeaking ? primaryColor : const Color(0xFF22C55E)).withValues(alpha: 0.12)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16),
      );
    }

    // Main head circle
    final headGradient = RadialGradient(
      center: const Alignment(-0.3, -0.3),
      colors: [
        const Color(0xFF818CF8),
        primaryColor,
        const Color(0xFF6366F1),
      ],
      stops: const [0.0, 0.5, 1.0],
    );
    canvas.drawCircle(
      Offset(cx, cy),
      radius,
      Paint()..shader = headGradient.createShader(Rect.fromCircle(center: Offset(cx, cy), radius: radius)),
    );

    // Highlight
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx - radius * 0.2, cy - radius * 0.35), width: radius * 0.7, height: radius * 0.35),
      Paint()..color = Colors.white.withValues(alpha: 0.18),
    );

    // Ears / antenna
    final earPaint = Paint()..color = const Color(0xFFA78BFA);
    canvas.drawCircle(Offset(cx - radius * 0.85, cy - radius * 0.5), 10, earPaint);
    canvas.drawCircle(Offset(cx + radius * 0.85, cy - radius * 0.5), 10, earPaint);
    // Antenna
    final antennaPaint = Paint()
      ..color = const Color(0xFFA78BFA)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(cx, cy - radius), Offset(cx, cy - radius - 16), antennaPaint);
    canvas.drawCircle(Offset(cx, cy - radius - 18), 5, Paint()..color = const Color(0xFFFBBF24));

    // Eyes
    final eyeY = cy - radius * 0.12;
    final leftEyeX = cx - radius * 0.3;
    final rightEyeX = cx + radius * 0.3;
    final eyeRadius = radius * 0.18;

    _drawEye(canvas, leftEyeX, eyeY, eyeRadius);
    _drawEye(canvas, rightEyeX, eyeY, eyeRadius);

    // Thinking dots instead of mouth
    if (isThinking) {
      final dotPaint = Paint()..color = Colors.white;
      for (var i = 0; i < 3; i++) {
        canvas.drawCircle(
          Offset(cx - 12.0 + i * 12.0, cy + radius * 0.35),
          3.5,
          dotPaint,
        );
      }
      return;
    }

    // Mouth
    final mouthY = cy + radius * 0.3;
    if (mouthOpen > 0.05) {
      // Open mouth (talking)
      final mouthWidth = radius * 0.45;
      final mouthHeight = radius * 0.22 * mouthOpen;
      final mouthRect = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, mouthY), width: mouthWidth, height: mouthHeight),
        Radius.circular(mouthHeight / 2),
      );
      canvas.drawRRect(mouthRect, Paint()..color = const Color(0xFF312E81));
      // Tongue
      if (mouthOpen > 0.5) {
        canvas.drawOval(
          Rect.fromCenter(center: Offset(cx, mouthY + mouthHeight * 0.2), width: mouthWidth * 0.4, height: mouthHeight * 0.5),
          Paint()..color = const Color(0xFFF472B6),
        );
      }
    } else {
      // Smile
      final smilePath = Path();
      smilePath.moveTo(cx - radius * 0.22, mouthY - 2);
      smilePath.quadraticBezierTo(cx, mouthY + radius * 0.16, cx + radius * 0.22, mouthY - 2);
      canvas.drawPath(
        smilePath,
        Paint()
          ..color = Colors.white
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round,
      );
    }

    // Cheeks / blush
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx - radius * 0.55, cy + radius * 0.15), width: 14, height: 9),
      Paint()..color = const Color(0xFFF472B6).withValues(alpha: 0.3),
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx + radius * 0.55, cy + radius * 0.15), width: 14, height: 9),
      Paint()..color = const Color(0xFFF472B6).withValues(alpha: 0.3),
    );
  }

  void _drawEye(Canvas canvas, double x, double y, double radius) {
    // White
    canvas.drawOval(
      Rect.fromCenter(center: Offset(x, y), width: radius * 2, height: radius * 2.2 * (1 - blinkAmount * 0.9)),
      Paint()..color = Colors.white,
    );

    if (blinkAmount < 0.8) {
      // Pupil
      final pupilSize = radius * 0.55;
      canvas.drawCircle(
        Offset(x, y),
        pupilSize,
        Paint()..color = const Color(0xFF1E1B4B),
      );
      // Sparkle
      canvas.drawCircle(
        Offset(x - pupilSize * 0.35, y - pupilSize * 0.35),
        pupilSize * 0.3,
        Paint()..color = Colors.white,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GBotCharacterPainter old) {
    return old.mouthOpen != mouthOpen ||
        old.blinkAmount != blinkAmount ||
        old.isThinking != isThinking ||
        old.isListening != isListening ||
        old.isSpeaking != isSpeaking;
  }
}
