class GrammarQuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  const GrammarQuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });
}

class GrammarTopic {
  final String id;
  final String level;
  final String title;
  final String shortDescription;
  final String introduction;
  final List<String> whenToUse;
  final List<String> rules;
  final List<String> structures;
  final List<String> examples;
  final List<String> negativeExamples;
  final List<String> questionExamples;
  final List<String> commonMistakes;
  final List<String> tips;
  final List<GrammarQuizQuestion> quizQuestions;

  const GrammarTopic({
    required this.id,
    required this.level,
    required this.title,
    required this.shortDescription,
    required this.introduction,
    required this.whenToUse,
    required this.rules,
    required this.structures,
    required this.examples,
    required this.negativeExamples,
    required this.questionExamples,
    required this.commonMistakes,
    required this.tips,
    required this.quizQuestions,
  });
}
