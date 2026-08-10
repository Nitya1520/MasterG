import '../models/grammar_topic.dart';

class GrammarData {
  static const List<GrammarTopic> a1Topics = [
    GrammarTopic(
      id: 'basic_sentence_structure',
      level: 'A1',
      title: 'Basic Sentence Structure',
      shortDescription: 'Build clear sentences with subject, verb, and object.',
      introduction: 'A basic sentence usually has a subject and a verb. English sentences often follow a clear order to be easy to understand.',
      whenToUse: [
        'When you create simple statements',
        'When you want clear everyday communication',
        'When you form basic questions or negatives',
      ],
      rules: [
        'Most English statements follow subject + verb + object order.',
        'A sentence needs a subject and a verb to be complete.',
        'Questions and negatives need auxiliary verbs in many tenses.',
      ],
      structures: [
        'Subject + verb',
        'Subject + verb + object',
        'Subject + auxiliary + verb',
      ],
      examples: [
        'I like coffee.',
        'She reads books.',
        'We study English.',
      ],
      negativeExamples: [
        'I likes coffee.',
        'She read books.',
      ],
      questionExamples: [
        'Do you like tea?',
        'Does she play football?',
      ],
      commonMistakes: [
        'Missing the subject: “Like coffee.”',
        'Using the wrong verb form: “She like books.”',
      ],
      tips: [
        'Start with a simple subject and verb.',
        'Check whether the sentence is a statement, question, or negative.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'She _____ coffee every morning.', options: ['drink', 'drinks', 'drinking', 'drunk'], correctAnswerIndex: 1, explanation: 'We use the third-person singular form with “she”.'),
        GrammarQuizQuestion(question: 'They _____ to school by bus.', options: ['go', 'goes', 'going', 'gone'], correctAnswerIndex: 0, explanation: 'With “they”, we use the base form of the verb.'),
        GrammarQuizQuestion(question: 'I _____ English every day.', options: ['study', 'studies', 'studying', 'studied'], correctAnswerIndex: 0, explanation: 'With “I”, we use the base form of the verb.'),
        GrammarQuizQuestion(question: 'We _____ football after school.', options: ['play', 'plays', 'playing', 'played'], correctAnswerIndex: 0, explanation: 'With “we”, the base form is correct.'),
        GrammarQuizQuestion(question: 'He _____ a car.', options: ['have', 'has', 'having', 'had'], correctAnswerIndex: 1, explanation: 'With “he”, we use “has” for possession.'),
      ],
    ),
    GrammarTopic(
      id: 'subject_pronouns',
      level: 'A1',
      title: 'Subject Pronouns',
      shortDescription: 'Use pronouns like I, you, he, she, we, and they.',
      introduction: 'Subject pronouns replace names and identify who performs the action.',
      whenToUse: [
        'When you want to avoid repeating names',
        'When you talk about people or things',
      ],
      rules: [
        'I, you, he, she, we, and they are subject pronouns.',
        'Use he for a male person, she for a female person, and they for plural nouns or people.',
      ],
      structures: [
        'I + verb',
        'You + verb',
        'He/She/It + verb + s',
      ],
      examples: [
        'I am happy.',
        'You are kind.',
        'They are students.',
      ],
      negativeExamples: [
        'Me am happy.',
        'He is a teacher.',
      ],
      questionExamples: [
        'She is my friend.',
        'We are ready.',
      ],
      commonMistakes: [
        'Using object pronouns as subjects: “Him is late.”',
      ],
      tips: [
        'Replace the noun with a pronoun to simplify sentences.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: '_____ am a student.', options: ['He', 'She', 'I', 'They'], correctAnswerIndex: 2, explanation: 'Use “I” for the speaker.'),
        GrammarQuizQuestion(question: '_____ is my brother.', options: ['He', 'I', 'We', 'You'], correctAnswerIndex: 0, explanation: 'Use “he” for a male person.'),
        GrammarQuizQuestion(question: '_____ are my friends.', options: ['She', 'They', 'He', 'Me'], correctAnswerIndex: 1, explanation: 'Use “they” for plural people.'),
        GrammarQuizQuestion(question: '_____ are happy today.', options: ['We', 'It', 'She', 'Him'], correctAnswerIndex: 0, explanation: 'Use “we” when speaking about a group including yourself.'),
        GrammarQuizQuestion(question: '_____ is reading a book.', options: ['They', 'You', 'She', 'I'], correctAnswerIndex: 2, explanation: 'Use “she” for a single female person.'),
      ],
    ),
    GrammarTopic(
      id: 'object_pronouns',
      level: 'A1',
      title: 'Object Pronouns',
      shortDescription: 'Use me, you, him, her, us, and them as objects.',
      introduction: 'Object pronouns are used when the pronoun receives the action.',
      whenToUse: [
        'After verbs',
        'After prepositions',
      ],
      rules: [
        'Use me, you, him, her, us, and them as objects.',
        'Object pronouns usually follow verbs or prepositions.',
      ],
      structures: [
        'Verb + object pronoun',
        'Preposition + object pronoun',
      ],
      examples: [
        'She called me.',
        'He gave it to us.',
      ],
      negativeExamples: [
        'She called I.',
      ],
      questionExamples: [
        'Please help us.',
      ],
      commonMistakes: [
        'Using subject pronouns instead of object pronouns.',
      ],
      tips: [
        'If the pronoun receives the action, it is usually an object pronoun.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'She saw _____ at the park.', options: ['I', 'me', 'we', 'he'], correctAnswerIndex: 1, explanation: 'The pronoun receives the action, so we use the object pronoun “me”.'),
        GrammarQuizQuestion(question: 'Can you help _____?', options: ['we', 'us', 'our', 'ours'], correctAnswerIndex: 1, explanation: '“Us” is the object pronoun after the verb “help”.'),
        GrammarQuizQuestion(question: 'I know _____ well.', options: ['he', 'him', 'his', 'he’s'], correctAnswerIndex: 1, explanation: '“Him” is the correct object form.'),
        GrammarQuizQuestion(question: 'Please give the book to _____', options: ['she', 'her', 'hers', 'herself'], correctAnswerIndex: 1, explanation: '“Her” is the object pronoun after the preposition “to”.'),
        GrammarQuizQuestion(question: 'They invited _____ to the party.', options: ['we', 'us', 'our', 'ours'], correctAnswerIndex: 1, explanation: '“Us” is the object pronoun after the verb “invited”.'),
      ],
    ),
    GrammarTopic(
      id: 'possessive_adjectives',
      level: 'A1',
      title: 'Possessive Adjectives',
      shortDescription: 'Show belonging with my, your, his, her, our, and their.',
      introduction: 'Possessive adjectives describe ownership and come before a noun.',
      whenToUse: [
        'To show possession',
        'To describe belonging',
      ],
      rules: [
        'Use my, your, his, her, our, and their before a noun.',
        'They do not stand alone.',
      ],
      structures: [
        'My + noun',
        'Your + noun',
      ],
      examples: [
        'My phone is new.',
        'Their house is big.',
      ],
      negativeExamples: [
        'Mine phone is new.',
      ],
      questionExamples: [
        'Her birthday is tomorrow.',
      ],
      commonMistakes: [
        'Confusing possessive adjectives with pronouns.',
      ],
      tips: [
        'If the word is followed by a noun, use a possessive adjective.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'This is _____ book.', options: ['my', 'mine', 'me', 'I'], correctAnswerIndex: 0, explanation: 'We use “my” before a noun.'),
        GrammarQuizQuestion(question: 'She likes _____ teacher.', options: ['her', 'hers', 'she', 'he'], correctAnswerIndex: 0, explanation: '“Her” is a possessive adjective before the noun “teacher”.'),
        GrammarQuizQuestion(question: 'We forgot _____ keys.', options: ['our', 'ours', 'us', 'we'], correctAnswerIndex: 0, explanation: '“Our” modifies the noun “keys”.'),
        GrammarQuizQuestion(question: 'They brought _____ bags.', options: ['their', 'theirs', 'them', 'they'], correctAnswerIndex: 0, explanation: '“Their” belongs before the noun “bags”.'),
        GrammarQuizQuestion(question: 'I love _____ new car.', options: ['my', 'mine', 'me', 'I'], correctAnswerIndex: 0, explanation: 'Use “my” before the noun “car”.'),
      ],
    ),
    GrammarTopic(
      id: 'possessive_pronouns',
      level: 'A1',
      title: 'Possessive Pronouns',
      shortDescription: 'Use mine, yours, his, hers, ours, and theirs.',
      introduction: 'Possessive pronouns stand alone and replace a noun phrase.',
      whenToUse: [
        'When you do not repeat the noun',
        'To show ownership clearly',
      ],
      rules: [
        'Mine, yours, his, hers, ours, and theirs stand alone.',
        'They do not need a noun after them.',
      ],
      structures: [
        'This book is mine.',
        'The house is theirs.',
      ],
      examples: [
        'This bag is mine.',
        'The red pen is hers.',
      ],
      negativeExamples: [
        'This bag is my.',
      ],
      questionExamples: [
        'These shoes are yours.',
      ],
      commonMistakes: [
        'Using a possessive adjective when a pronoun is needed.',
      ],
      tips: [
        'If there is no noun after it, use a possessive pronoun.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'This pen is _____', options: ['my', 'mine', 'me', 'I'], correctAnswerIndex: 1, explanation: 'Without a noun after it, we use the possessive pronoun “mine”.'),
        GrammarQuizQuestion(question: 'The blue bike is _____', options: ['your', 'yours', 'you', 'yourself'], correctAnswerIndex: 1, explanation: '“Yours” stands alone and shows possession.'),
        GrammarQuizQuestion(question: 'The house is _____', options: ['their', 'theirs', 'them', 'they'], correctAnswerIndex: 1, explanation: '“Theirs” is the correct possessive pronoun.'),
        GrammarQuizQuestion(question: 'Those books are _____', options: ['our', 'ours', 'us', 'we'], correctAnswerIndex: 1, explanation: 'The noun is omitted, so “ours” is correct.'),
        GrammarQuizQuestion(question: 'The jacket is _____', options: ['her', 'hers', 'she', 'herself'], correctAnswerIndex: 1, explanation: 'Use “hers” when the noun is not repeated.'),
      ],
    ),
    GrammarTopic(
      id: 'demonstratives',
      level: 'A1',
      title: 'Demonstratives',
      shortDescription: 'Use this, that, these, and those to point to things.',
      introduction: 'Demonstratives help us point to people or objects near or far.',
      whenToUse: [
        'When pointing to objects',
        'When showing distance',
      ],
      rules: [
        'Use this and these for things near you.',
        'Use that and those for things farther away.',
      ],
      structures: [
        'This + singular noun',
        'These + plural noun',
      ],
      examples: [
        'This is my bag.',
        'Those are my shoes.',
      ],
      negativeExamples: [
        'These is my bag.',
      ],
      questionExamples: [
        'That is your book.',
      ],
      commonMistakes: [
        'Using singular and plural forms incorrectly.',
      ],
      tips: [
        'Think about distance and number.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: '_____ is my phone.', options: ['This', 'That', 'These', 'Those'], correctAnswerIndex: 0, explanation: '“This” is used for a singular thing near you.'),
        GrammarQuizQuestion(question: '_____ are my books.', options: ['This', 'That', 'These', 'Those'], correctAnswerIndex: 2, explanation: '“These” is used for plural things near you.'),
        GrammarQuizQuestion(question: '_____ is your house over there.', options: ['This', 'That', 'These', 'Those'], correctAnswerIndex: 1, explanation: '“That” is used for a singular thing far away.'),
        GrammarQuizQuestion(question: '_____ are the shoes on the shelf.', options: ['This', 'That', 'These', 'Those'], correctAnswerIndex: 3, explanation: '“Those” is used for plural things far away.'),
        GrammarQuizQuestion(question: '_____ is a great idea.', options: ['This', 'That', 'These', 'Those'], correctAnswerIndex: 0, explanation: '“This” can also refer to a singular idea or thing near us.'),
      ],
    ),
    GrammarTopic(
      id: 'singular_plural_nouns',
      level: 'A1',
      title: 'Singular and Plural Nouns',
      shortDescription: 'Make nouns singular or plural correctly.',
      introduction: 'Nouns can be singular for one thing or plural for more than one.',
      whenToUse: [
        'When talking about one or more things',
        'When describing quantities',
      ],
      rules: [
        'Add -s to most singular nouns to make them plural.',
        'Some nouns have irregular plurals.',
      ],
      structures: [
        'one book',
        'two books',
      ],
      examples: [
        'One apple.',
        'Three apples.',
      ],
      negativeExamples: [
        'Two apple.',
      ],
      questionExamples: [
        'A child / two children.',
      ],
      commonMistakes: [
        'Forgetting irregular plural forms.',
      ],
      tips: [
        'Learn common irregular plurals.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I have one cat and two _____.', options: ['cats', 'cat', 'cats', 'cates'], correctAnswerIndex: 0, explanation: 'The plural of “cat” is “cats”.'),
        GrammarQuizQuestion(question: 'There are three _____ in the room.', options: ['child', 'childs', 'children', 'childes'], correctAnswerIndex: 2, explanation: '“Child” has an irregular plural: “children”.'),
        GrammarQuizQuestion(question: 'She bought five _____', options: ['book', 'books', 'bookes', 'books'], correctAnswerIndex: 1, explanation: 'Most nouns add -s to become plural.'),
        GrammarQuizQuestion(question: 'My brother has two _____', options: ['dog', 'dogs', 'doges', 'dogs'], correctAnswerIndex: 1, explanation: 'The plural of “dog” is “dogs”.'),
        GrammarQuizQuestion(question: 'We saw many _____ in the park.', options: ['bird', 'birds', 'birdes', 'birds'], correctAnswerIndex: 1, explanation: 'Most plural nouns simply add -s.'),
      ],
    ),
    GrammarTopic(
      id: 'countable_uncountable_nouns',
      level: 'A1',
      title: 'Countable and Uncountable Nouns',
      shortDescription: 'Understand how to talk about things you can count and things you cannot count.',
      introduction: 'Some nouns are countable and some are uncountable.',
      whenToUse: [
        'When talking about quantity',
        'When choosing articles or quantifiers',
      ],
      rules: [
        'Countable nouns can take a number: one apple, two apples.',
        'Uncountable nouns usually do not take a plural form.',
      ],
      structures: [
        'How many + countable noun',
        'How much + uncountable noun',
      ],
      examples: [
        'How many books do you have?',
        'How much water do you drink?',
      ],
      negativeExamples: [
        'How many waters do you drink?',
      ],
      questionExamples: [
        'I have some rice.',
      ],
      commonMistakes: [
        'Using plural forms with uncountable nouns.',
      ],
      tips: [
        'Think about whether you can count the item easily.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'How many _____ do you need?', options: ['water', 'rice', 'books', 'information'], correctAnswerIndex: 2, explanation: 'Books are countable, so we use “How many”.'),
        GrammarQuizQuestion(question: 'How much _____ do you drink?', options: ['apples', 'chairs', 'juice', 'pens'], correctAnswerIndex: 2, explanation: 'Juice is uncountable, so we use “How much”.'),
        GrammarQuizQuestion(question: 'I bought three _____', options: ['bread', 'milk', 'apples', 'music'], correctAnswerIndex: 2, explanation: 'Apples are countable.'),
        GrammarQuizQuestion(question: 'We need some _____ for the recipe.', options: ['sugar', 'chairs', 'tables', 'books'], correctAnswerIndex: 0, explanation: 'Sugar is uncountable.'),
        GrammarQuizQuestion(question: 'There are many _____ in the garden.', options: ['flowers', 'water', 'rice', 'information'], correctAnswerIndex: 0, explanation: 'Flowers are countable.'),
      ],
    ),
    GrammarTopic(
      id: 'articles',
      level: 'A1',
      title: 'Articles: A / An / The',
      shortDescription: 'Use articles correctly with singular and specific nouns.',
      introduction: 'Articles tell us whether a noun is general, specific, or singular.',
      whenToUse: [
        'When introducing a noun',
        'When talking about a specific thing',
      ],
      rules: [
        'Use a before a consonant sound.',
        'Use an before a vowel sound.',
        'Use the for something specific or already known.',
      ],
      structures: [
        'a + noun',
        'an + noun',
        'the + noun',
      ],
      examples: [
        'I have a book.',
        'She has an apple.',
        'The book is on the table.',
      ],
      negativeExamples: [
        'I have an book.',
        'She has a apple.',
      ],
      questionExamples: [
        'She is a teacher.',
      ],
      commonMistakes: [
        'Using a and an incorrectly based on spelling instead of sound.',
      ],
      tips: [
        'Listen to the first sound, not the first letter.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'She has _____ apple.', options: ['a', 'an', 'the', 'none'], correctAnswerIndex: 1, explanation: 'Use “an” before a vowel sound.'),
        GrammarQuizQuestion(question: 'I saw _____ elephant at the zoo.', options: ['a', 'an', 'the', 'none'], correctAnswerIndex: 1, explanation: '“Elephant” starts with a vowel sound.'),
        GrammarQuizQuestion(question: 'Please open _____ window.', options: ['a', 'an', 'the', 'none'], correctAnswerIndex: 2, explanation: '“The” is used because the window is specific.'),
        GrammarQuizQuestion(question: 'He is _____ doctor.', options: ['a', 'an', 'the', 'none'], correctAnswerIndex: 0, explanation: 'Use “a” before a consonant sound.'),
        GrammarQuizQuestion(question: 'I need _____ umbrella.', options: ['a', 'an', 'the', 'none'], correctAnswerIndex: 1, explanation: '“Umbrella” begins with a vowel sound.'),
      ],
    ),
    GrammarTopic(
      id: 'am_is_are',
      level: 'A1',
      title: 'Am / Is / Are',
      shortDescription: 'Use the verb be in the present tense.',
      introduction: 'The verb be is one of the most common verbs in English.',
      whenToUse: [
        'When describing people or things',
        'When talking about identity or state',
      ],
      rules: [
        'Use am with I.',
        'Use is with he, she, it, and singular nouns.',
        'Use are with you, we, they, and plural nouns.',
      ],
      structures: [
        'I am',
        'You are',
        'He/She/It is',
      ],
      examples: [
        'I am tired.',
        'She is happy.',
        'We are ready.',
      ],
      negativeExamples: [
        'She are happy.',
      ],
      questionExamples: [
        'Are you ready?',
      ],
      commonMistakes: [
        'Choosing the wrong form of “be”.',
      ],
      tips: [
        'Match the verb with the subject.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I _____ tired.', options: ['am', 'is', 'are', 'be'], correctAnswerIndex: 0, explanation: '“Am” is used with “I”.'),
        GrammarQuizQuestion(question: 'She _____ happy today.', options: ['am', 'is', 'are', 'be'], correctAnswerIndex: 1, explanation: '“Is” is used with “she”.'),
        GrammarQuizQuestion(question: 'We _____ ready.', options: ['am', 'is', 'are', 'be'], correctAnswerIndex: 2, explanation: '“Are” is used with “we”.'),
        GrammarQuizQuestion(question: 'They _____ at home.', options: ['am', 'is', 'are', 'be'], correctAnswerIndex: 2, explanation: '“Are” is used with “they”.'),
        GrammarQuizQuestion(question: 'He _____ a teacher.', options: ['am', 'is', 'are', 'be'], correctAnswerIndex: 1, explanation: '“Is” is used with “he”.'),
      ],
    ),
    GrammarTopic(
      id: 'have_has',
      level: 'A1',
      title: 'Have / Has',
      shortDescription: 'Show possession or experience with have and has.',
      introduction: 'Have and has are used to show possession or experience.',
      whenToUse: [
        'When talking about possession',
        'When describing experiences',
      ],
      rules: [
        'Use have with I, you, we, they.',
        'Use has with he, she, it, and singular nouns.',
      ],
      structures: [
        'I have',
        'She has',
      ],
      examples: [
        'I have a pen.',
        'She has a car.',
      ],
      negativeExamples: [
        'She have a car.',
      ],
      questionExamples: [
        'Do you have a laptop?',
      ],
      commonMistakes: [
        'Using have with he or she.',
      ],
      tips: [
        'Remember the subject agreement.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I _____ a blue notebook.', options: ['has', 'have', 'having', 'had'], correctAnswerIndex: 1, explanation: 'Use “have” with “I”.'),
        GrammarQuizQuestion(question: 'She _____ a new bicycle.', options: ['has', 'have', 'had', 'having'], correctAnswerIndex: 0, explanation: 'Use “has” with “she”.'),
        GrammarQuizQuestion(question: 'They _____ two dogs.', options: ['has', 'have', 'had', 'having'], correctAnswerIndex: 1, explanation: 'Use “have” with “they”.'),
        GrammarQuizQuestion(question: 'He _____ a big family.', options: ['has', 'have', 'had', 'having'], correctAnswerIndex: 0, explanation: 'Use “has” with “he”.'),
        GrammarQuizQuestion(question: 'We _____ enough time.', options: ['has', 'have', 'had', 'having'], correctAnswerIndex: 1, explanation: 'Use “have” with “we”.'),
      ],
    ),
    GrammarTopic(
      id: 'there_is_there_are',
      level: 'A1',
      title: 'There Is / There Are',
      shortDescription: 'Describe what exists in a place.',
      introduction: 'We use there is and there are to talk about existence.',
      whenToUse: [
        'When describing a place',
        'When introducing something new',
      ],
      rules: [
        'Use there is for singular nouns.',
        'Use there are for plural nouns.',
      ],
      structures: [
        'There is + singular noun',
        'There are + plural noun',
      ],
      examples: [
        'There is a cat in the garden.',
        'There are two cats in the garden.',
      ],
      negativeExamples: [
        'There are a cat in the garden.',
      ],
      questionExamples: [
        'Is there a bus stop nearby?',
      ],
      commonMistakes: [
        'Choosing the wrong form for singular or plural nouns.',
      ],
      tips: [
        'Look at the noun after the verb.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'There _____ a book on the table.', options: ['is', 'are', 'be', 'been'], correctAnswerIndex: 0, explanation: 'Use “is” for a singular noun.'),
        GrammarQuizQuestion(question: 'There _____ three chairs in the room.', options: ['is', 'are', 'be', 'been'], correctAnswerIndex: 1, explanation: 'Use “are” for a plural noun.'),
        GrammarQuizQuestion(question: 'There _____ some milk in the fridge.', options: ['is', 'are', 'be', 'been'], correctAnswerIndex: 0, explanation: '“Milk” is uncountable, but the singular form “is” is used.'),
        GrammarQuizQuestion(question: 'There _____ two windows in the kitchen.', options: ['is', 'are', 'be', 'been'], correctAnswerIndex: 1, explanation: 'Use “are” for a plural noun.'),
        GrammarQuizQuestion(question: 'There _____ a lot of students here.', options: ['is', 'are', 'be', 'been'], correctAnswerIndex: 1, explanation: 'The phrase “a lot of students” is plural, so “are” is correct.'),
      ],
    ),
    GrammarTopic(
      id: 'present_simple',
      level: 'A1',
      title: 'Present Simple',
      shortDescription: 'Talk about habits, routines, and facts.',
      introduction: 'We use the Present Simple to talk about habits, routines, facts, and regular actions.',
      whenToUse: [
        'Daily habits',
        'Regular activities',
        'General facts',
        'Permanent situations',
      ],
      rules: [
        'Use the base verb with I, you, we, they.',
        'Add -s or -es to the verb with he, she, it.',
        'We often use time expressions such as every day or usually.',
      ],
      structures: [
        'I/You/We/They + base verb',
        'He/She/It + verb + s/es',
      ],
      examples: [
        'I work every day.',
        'She works every day.',
      ],
      negativeExamples: [
        'She work every day.',
      ],
      questionExamples: [
        'Do you like coffee?',
      ],
      commonMistakes: [
        'Forgetting the -s with he, she, it.',
      ],
      tips: [
        'Check the subject before choosing the verb form.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'She _____ to school every day.', options: ['go', 'goes', 'going', 'gone'], correctAnswerIndex: 1, explanation: 'We use “goes” with she in the Present Simple.'),
        GrammarQuizQuestion(question: 'They _____ English at school.', options: ['study', 'studies', 'studying', 'studied'], correctAnswerIndex: 0, explanation: 'With “they”, we use the base form.'),
        GrammarQuizQuestion(question: 'My father _____ coffee.', options: ['drink', 'drinks', 'drinking', 'drunk'], correctAnswerIndex: 1, explanation: 'The verb needs the -s form with “father”.'),
        GrammarQuizQuestion(question: 'We _____ breakfast at 7 a.m.', options: ['eat', 'eats', 'eating', 'ate'], correctAnswerIndex: 0, explanation: 'With “we”, the base form is correct.'),
        GrammarQuizQuestion(question: 'He _____ very fast.', options: ['run', 'runs', 'running', 'ran'], correctAnswerIndex: 1, explanation: 'Use “runs” with he in the Present Simple.'),
      ],
    ),
    GrammarTopic(
      id: 'present_simple_negative',
      level: 'A1',
      title: 'Present Simple Negative',
      shortDescription: 'Make negative sentences in the present simple.',
      introduction: 'Use do not / does not to make present simple negatives.',
      whenToUse: [
        'When saying what someone does not do',
        'When making general negative statements',
      ],
      rules: [
        'Use do not with I, you, we, they.',
        'Use does not with he, she, it.',
      ],
      structures: [
        'I do not + base verb',
        'She does not + base verb',
      ],
      examples: [
        'I do not like tea.',
        'She does not work on Sundays.',
      ],
      negativeExamples: [
        'She do not like tea.',
      ],
      questionExamples: [
        'Do not worry.',
      ],
      commonMistakes: [
        'Forgetting to use the base verb after do/does not.',
      ],
      tips: [
        'The main verb stays in the base form after do/does not.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I _____ like spicy food.', options: ['don’t', 'doesn’t', 'didn’t', 'won’t'], correctAnswerIndex: 0, explanation: 'Use “don’t” with “I”.'),
        GrammarQuizQuestion(question: 'She _____ play tennis on Mondays.', options: ['don’t', 'doesn’t', 'didn’t', 'won’t'], correctAnswerIndex: 1, explanation: 'Use “doesn’t” with “she”.'),
        GrammarQuizQuestion(question: 'They _____ live here.', options: ['don’t', 'doesn’t', 'didn’t', 'won’t'], correctAnswerIndex: 0, explanation: 'Use “don’t” with “they”.'),
        GrammarQuizQuestion(question: 'He _____ speak French.', options: ['don’t', 'doesn’t', 'didn’t', 'won’t'], correctAnswerIndex: 1, explanation: 'Use “doesn’t” with “he”.'),
        GrammarQuizQuestion(question: 'We _____ watch TV at night.', options: ['don’t', 'doesn’t', 'didn’t', 'won’t'], correctAnswerIndex: 0, explanation: 'Use “don’t” with “we”.'),
      ],
    ),
    GrammarTopic(
      id: 'present_simple_questions',
      level: 'A1',
      title: 'Present Simple Questions',
      shortDescription: 'Ask questions in the present simple correctly.',
      introduction: 'We form present simple questions with do or does.',
      whenToUse: [
        'When asking about habits',
        'When asking for general information',
      ],
      rules: [
        'Use do with I, you, we, they.',
        'Use does with he, she, it.',
      ],
      structures: [
        'Do + subject + base verb?',
        'Does + subject + base verb?',
      ],
      examples: [
        'Do you like music?',
        'Does she work here?',
      ],
      negativeExamples: [
        'Does you like music?',
      ],
      questionExamples: [
        'Do they live nearby?',
      ],
      commonMistakes: [
        'Using “does” with I, you, we, they.',
      ],
      tips: [
        'Use the help verb before the subject.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: '_____ you like tea?', options: ['Do', 'Does', 'Did', 'Will'], correctAnswerIndex: 0, explanation: 'Use “Do” with “you”.'),
        GrammarQuizQuestion(question: '_____ she play tennis?', options: ['Do', 'Does', 'Did', 'Will'], correctAnswerIndex: 1, explanation: 'Use “Does” with “she”.'),
        GrammarQuizQuestion(question: '_____ they live in London?', options: ['Do', 'Does', 'Did', 'Will'], correctAnswerIndex: 0, explanation: 'Use “Do” with “they”.'),
        GrammarQuizQuestion(question: '_____ he work here?', options: ['Do', 'Does', 'Did', 'Will'], correctAnswerIndex: 1, explanation: 'Use “Does” with “he”.'),
        GrammarQuizQuestion(question: '_____ we need a map?', options: ['Do', 'Does', 'Did', 'Will'], correctAnswerIndex: 0, explanation: 'Use “Do” with “we”.'),
      ],
    ),
    GrammarTopic(
      id: 'present_continuous',
      level: 'A1',
      title: 'Present Continuous',
      shortDescription: 'Talk about actions happening now.',
      introduction: 'We use the Present Continuous for actions happening at the moment of speaking.',
      whenToUse: [
        'Actions happening right now',
        'Temporary situations',
      ],
      rules: [
        'Use am/is/are + verb-ing.',
        'Use it for actions happening now.',
      ],
      structures: [
        'I am + verb-ing',
        'He is + verb-ing',
      ],
      examples: [
        'I am reading a book.',
        'They are playing football.',
      ],
      negativeExamples: [
        'They playing football.',
      ],
      questionExamples: [
        'Are you listening?',
      ],
      commonMistakes: [
        'Forgetting the auxiliary verb.',
      ],
      tips: [
        'Look for words like now or at the moment.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'She _____ a book right now.', options: ['read', 'reads', 'is reading', 'reading'], correctAnswerIndex: 2, explanation: 'Use the present continuous for actions happening now.'),
        GrammarQuizQuestion(question: 'They _____ football in the park.', options: ['play', 'are playing', 'plays', 'played'], correctAnswerIndex: 1, explanation: 'The present continuous uses “are + verb-ing”.'),
        GrammarQuizQuestion(question: 'I _____ to music.', options: ['am listening', 'listening', 'listen', 'listens'], correctAnswerIndex: 0, explanation: 'Use “am + verb-ing” with “I”.'),
        GrammarQuizQuestion(question: 'We _____ dinner.', options: ['are cooking', 'cooked', 'cook', 'cooks'], correctAnswerIndex: 0, explanation: 'Use “are + verb-ing” with “we”.'),
        GrammarQuizQuestion(question: 'He _____ TV at the moment.', options: ['watches', 'watching', 'is watching', 'watched'], correctAnswerIndex: 2, explanation: 'Use “is + verb-ing” with “he”.'),
      ],
    ),
    GrammarTopic(
      id: 'present_simple_vs_continuous',
      level: 'A1',
      title: 'Present Simple vs Present Continuous',
      shortDescription: 'Choose between habits and actions happening now.',
      introduction: 'We choose the present simple for routines and the present continuous for actions happening now.',
      whenToUse: [
        'For routines',
        'For temporary actions',
      ],
      rules: [
        'Use the present simple for routines and facts.',
        'Use the present continuous for actions happening now.',
      ],
      structures: [
        'Present simple: I work every day',
        'Present continuous: I am working now',
      ],
      examples: [
        'I usually walk to school.',
        'I am walking to school now.',
      ],
      negativeExamples: [
        'I am usually walking to school.',
      ],
      questionExamples: [
        'What are you doing now?',
      ],
      commonMistakes: [
        'Using the continuous form for ordinary habits.',
      ],
      tips: [
        'Check whether the action is routine or happening now.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'She usually _____ tea in the morning.', options: ['drinks', 'is drinking', 'drink', 'drinking'], correctAnswerIndex: 0, explanation: 'The present simple describes a routine.'),
        GrammarQuizQuestion(question: 'Right now, they _____ in the garden.', options: ['play', 'are playing', 'plays', 'played'], correctAnswerIndex: 1, explanation: 'The present continuous describes an action happening now.'),
        GrammarQuizQuestion(question: 'I _____ breakfast every day at 8.', options: ['eat', 'am eating', 'eats', 'eating'], correctAnswerIndex: 0, explanation: 'The present simple is used for a daily routine.'),
        GrammarQuizQuestion(question: 'Look! The baby _____!', options: ['sleeps', 'is sleeping', 'sleep', 'slept'], correctAnswerIndex: 1, explanation: 'The present continuous is used for an action happening now.'),
        GrammarQuizQuestion(question: 'My brother _____ to work by bus every day.', options: ['goes', 'is going', 'go', 'going'], correctAnswerIndex: 0, explanation: 'The present simple suits a regular habit.'),
      ],
    ),
    GrammarTopic(
      id: 'past_simple',
      level: 'A1',
      title: 'Past Simple',
      shortDescription: 'Talk about finished actions in the past.',
      introduction: 'We use the Past Simple for actions that happened and finished in the past.',
      whenToUse: [
        'Finished actions',
        'Past routines',
      ],
      rules: [
        'Use the past form of the verb.',
        'Regular verbs often end in -ed.',
      ],
      structures: [
        'Subject + past verb',
      ],
      examples: [
        'I visited my grandma yesterday.',
        'She watched a film last night.',
      ],
      negativeExamples: [
        'I visit my grandma yesterday.',
      ],
      questionExamples: [
        'Did you call me?',
      ],
      commonMistakes: [
        'Using the present form instead of the past form.',
      ],
      tips: [
        'Check whether the action is finished.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'We _____ to the beach last weekend.', options: ['go', 'went', 'going', 'gone'], correctAnswerIndex: 1, explanation: '“Went” is the past simple form of “go”.'),
        GrammarQuizQuestion(question: 'She _____ a letter yesterday.', options: ['writes', 'wrote', 'writing', 'written'], correctAnswerIndex: 1, explanation: '“Wrote” is the past simple form of “write”.'),
        GrammarQuizQuestion(question: 'They _____ football after school.', options: ['played', 'play', 'playing', 'plays'], correctAnswerIndex: 0, explanation: '“Played” is the correct past simple form.'),
        GrammarQuizQuestion(question: 'I _____ my homework last night.', options: ['did', 'do', 'does', 'doing'], correctAnswerIndex: 0, explanation: '“Did” is the past simple form of “do”.'),
        GrammarQuizQuestion(question: 'He _____ home early.', options: ['came', 'come', 'comes', 'coming'], correctAnswerIndex: 0, explanation: '“Came” is the past simple form of “come”.'),
      ],
    ),
    GrammarTopic(
      id: 'was_were',
      level: 'A1',
      title: 'Was / Were',
      shortDescription: 'Use the past forms of be correctly.',
      introduction: 'Was and were are past forms of the verb be.',
      whenToUse: [
        'When describing the past',
        'When talking about states in the past',
      ],
      rules: [
        'Use was with I, he, she, it.',
        'Use were with you, we, they.',
      ],
      structures: [
        'I was',
        'They were',
      ],
      examples: [
        'I was tired yesterday.',
        'They were happy.',
      ],
      negativeExamples: [
        'They was happy.',
      ],
      questionExamples: [
        'Were you at home?',
      ],
      commonMistakes: [
        'Using was with plural subjects.',
      ],
      tips: [
        'Choose the form based on the subject.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I _____ at school yesterday.', options: ['was', 'were', 'am', 'is'], correctAnswerIndex: 0, explanation: 'Use “was” with “I”.'),
        GrammarQuizQuestion(question: 'They _____ in the library.', options: ['was', 'were', 'is', 'am'], correctAnswerIndex: 1, explanation: 'Use “were” with “they”.'),
        GrammarQuizQuestion(question: 'She _____ very busy last week.', options: ['was', 'were', 'am', 'are'], correctAnswerIndex: 0, explanation: 'Use “was” with “she”.'),
        GrammarQuizQuestion(question: 'We _____ tired after the trip.', options: ['was', 'were', 'is', 'am'], correctAnswerIndex: 1, explanation: 'Use “were” with “we”.'),
        GrammarQuizQuestion(question: 'He _____ happy yesterday.', options: ['was', 'were', 'is', 'are'], correctAnswerIndex: 0, explanation: 'Use “was” with “he”.'),
      ],
    ),
    GrammarTopic(
      id: 'regular_past_verbs',
      level: 'A1',
      title: 'Regular Past Verbs',
      shortDescription: 'Form regular verbs in the past tense.',
      introduction: 'Regular past verbs often end in -ed.',
      whenToUse: [
        'When talking about completed actions',
        'When forming simple past sentences',
      ],
      rules: [
        'Add -ed to most regular verbs.',
        'Some need spelling changes such as -ied or double letters.',
      ],
      structures: [
        'Subject + verb-ed',
      ],
      examples: [
        'She cleaned the room.',
        'We played tennis.',
      ],
      negativeExamples: [
        'She clean the room.',
      ],
      questionExamples: [
        'Did you study yesterday?',
      ],
      commonMistakes: [
        'Forgetting the -ed ending.',
      ],
      tips: [
        'Check whether the verb is regular or irregular.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'She _____ the dishes after dinner.', options: ['wash', 'washed', 'washing', 'washes'], correctAnswerIndex: 1, explanation: 'Regular past verbs often add -ed.'),
        GrammarQuizQuestion(question: 'We _____ a movie last night.', options: ['watch', 'watched', 'watching', 'watches'], correctAnswerIndex: 1, explanation: '“Watched” is the regular past form.'),
        GrammarQuizQuestion(question: 'He _____ his homework carefully.', options: ['do', 'did', 'done', 'doing'], correctAnswerIndex: 1, explanation: '“Did” is the irregular past form of “do”.'),
        GrammarQuizQuestion(question: 'They _____ the house yesterday.', options: ['clean', 'cleaned', 'cleaning', 'cleans'], correctAnswerIndex: 1, explanation: 'The regular past form is “cleaned”.'),
        GrammarQuizQuestion(question: 'I _____ the email this morning.', options: ['send', 'sent', 'sending', 'sended'], correctAnswerIndex: 1, explanation: 'This is an irregular verb, not a regular -ed verb.'),
      ],
    ),
    GrammarTopic(
      id: 'common_irregular_verbs',
      level: 'A1',
      title: 'Common Irregular Verbs',
      shortDescription: 'Learn frequent irregular past forms.',
      introduction: 'Some verbs do not follow the -ed rule in the past simple.',
      whenToUse: [
        'When speaking about the past',
        'When you need common verbs',
      ],
      rules: [
        'Irregular verbs have special past forms.',
        'They need to be learned individually.',
      ],
      structures: [
        'Subject + irregular past form',
      ],
      examples: [
        'I went home.',
        'She saw a bird.',
      ],
      negativeExamples: [
        'She goed home.',
      ],
      questionExamples: [
        'We had lunch.',
      ],
      commonMistakes: [
        'Adding -ed to irregular verbs.',
      ],
      tips: [
        'Keep a small list of common irregular verbs and review it often.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I _____ to the store yesterday.', options: ['go', 'went', 'gone', 'going'], correctAnswerIndex: 1, explanation: '“Went” is the past simple form of “go”.'),
        GrammarQuizQuestion(question: 'She _____ a wonderful song.', options: ['hear', 'heard', 'hearing', 'hears'], correctAnswerIndex: 1, explanation: '“Heard” is the past simple form of “hear”.'),
        GrammarQuizQuestion(question: 'We _____ lunch at noon.', options: ['eat', 'ate', 'eaten', 'eating'], correctAnswerIndex: 1, explanation: '“Ate” is the past simple form of “eat”.'),
        GrammarQuizQuestion(question: 'He _____ a new car last year.', options: ['buy', 'bought', 'buying', 'buys'], correctAnswerIndex: 1, explanation: '“Bought” is the past simple form of “buy”.'),
        GrammarQuizQuestion(question: 'They _____ a great time.', options: ['have', 'had', 'having', 'has'], correctAnswerIndex: 1, explanation: '“Had” is the past simple form of “have”.'),
      ],
    ),
    GrammarTopic(
      id: 'future_with_will',
      level: 'A1',
      title: 'Future with Will',
      shortDescription: 'Make simple future predictions and decisions.',
      introduction: 'We use will for promises, predictions, and quick decisions.',
      whenToUse: [
        'Predictions',
        'Promises',
        'Quick decisions',
      ],
      rules: [
        'Use will + base verb.',
        'Will is often used for spontaneous decisions.',
      ],
      structures: [
        'Subject + will + base verb',
      ],
      examples: [
        'I will call you later.',
        'It will rain tomorrow.',
      ],
      negativeExamples: [
        'I will calling you later.',
      ],
      questionExamples: [
        'Will you come?',
      ],
      commonMistakes: [
        'Using the wrong form after will.',
      ],
      tips: [
        'Remember that the main verb stays in the base form.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I _____ help you.', options: ['will', 'am', 'do', 'did'], correctAnswerIndex: 0, explanation: 'Use “will” for a promise or decision.'),
        GrammarQuizQuestion(question: 'She _____ be here soon.', options: ['will', 'is', 'does', 'did'], correctAnswerIndex: 0, explanation: '“Will” expresses the future.'),
        GrammarQuizQuestion(question: 'They _____ arrive at noon.', options: ['will', 'are', 'do', 'did'], correctAnswerIndex: 0, explanation: '“Will” is correct for prediction.'),
        GrammarQuizQuestion(question: 'We _____ visit tomorrow.', options: ['will', 'are', 'have', 'did'], correctAnswerIndex: 0, explanation: 'Use “will” for a planned future action.'),
        GrammarQuizQuestion(question: 'He _____ not come today.', options: ['will', 'is', 'does', 'did'], correctAnswerIndex: 0, explanation: 'The negative future uses “will not”.'),
      ],
    ),
    GrammarTopic(
      id: 'going_to',
      level: 'A1',
      title: 'Going To',
      shortDescription: 'Talk about plans and intentions.',
      introduction: 'We use going to for plans and intentions.',
      whenToUse: [
        'Plans',
        'Intentions',
        'Predictions based on evidence',
      ],
      rules: [
        'Use am/is/are + going to + base verb.',
      ],
      structures: [
        'I am going to + verb',
      ],
      examples: [
        'I am going to study tonight.',
        'They are going to visit us.',
      ],
      negativeExamples: [
        'I going to study tonight.',
      ],
      questionExamples: [
        'Are you going to call her?',
      ],
      commonMistakes: [
        'Omitting the verb be.',
      ],
      tips: [
        'Use going to when the plan is already decided.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I _____ study tonight.', options: ['am going to', 'will', 'go', 'going'], correctAnswerIndex: 0, explanation: '“Am going to” expresses a plan.'),
        GrammarQuizQuestion(question: 'She _____ visit her aunt tomorrow.', options: ['is going to', 'goes', 'will', 'going'], correctAnswerIndex: 0, explanation: '“Is going to” shows a planned action.'),
        GrammarQuizQuestion(question: 'They _____ move to a new house.', options: ['are going to', 'will', 'going', 'go'], correctAnswerIndex: 0, explanation: '“Are going to” fits a planned future action.'),
        GrammarQuizQuestion(question: 'We _____ have dinner at 8.', options: ['are going to', 'will', 'goes', 'going'], correctAnswerIndex: 0, explanation: 'Use “are going to” for a plan.'),
        GrammarQuizQuestion(question: 'He _____ start a new job next month.', options: ['is going to', 'will', 'go', 'going'], correctAnswerIndex: 0, explanation: '“Is going to” expresses a future plan.'),
      ],
    ),
    GrammarTopic(
      id: 'will_vs_going_to',
      level: 'A1',
      title: 'Will vs Going To',
      shortDescription: 'Choose between will and going to.',
      introduction: 'Will and going to both express the future, but they are used differently.',
      whenToUse: [
        'Predictions',
        'Plans',
        'Decisions',
      ],
      rules: [
        'Use will for spontaneous decisions and predictions.',
        'Use going to for plans and intentions.',
      ],
      structures: [
        'I will call you.',
        'I am going to call you.',
      ],
      examples: [
        'I will help you.',
        'I am going to help you tonight.',
      ],
      negativeExamples: [
        'I am will help you.',
      ],
      questionExamples: [
        'Will you come to dinner?',
      ],
      commonMistakes: [
        'Choosing the wrong form for a plan or a sudden decision.',
      ],
      tips: [
        'Ask yourself if it is a plan or a decision made at that moment.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I forgot my wallet. I _____ pay you back tomorrow.', options: ['will', 'am going to', 'go', 'going'], correctAnswerIndex: 0, explanation: 'A spontaneous decision uses “will”.'),
        GrammarQuizQuestion(question: 'We _____ visit our grandparents next weekend.', options: ['will', 'are going to', 'go', 'going'], correctAnswerIndex: 1, explanation: 'A plan uses “going to”.'),
        GrammarQuizQuestion(question: 'Look at those clouds! It _____ rain.', options: ['will', 'is going to', 'go', 'going'], correctAnswerIndex: 1, explanation: 'A prediction based on evidence uses “going to”.'),
        GrammarQuizQuestion(question: 'I think she _____ pass the exam.', options: ['will', 'is going to', 'go', 'going'], correctAnswerIndex: 0, explanation: 'A prediction without clear evidence often uses “will”.'),
        GrammarQuizQuestion(question: 'He _____ start a new course next month.', options: ['will', 'is going to', 'go', 'going'], correctAnswerIndex: 1, explanation: 'A planned future action uses “going to”.'),
      ],
    ),
    GrammarTopic(
      id: 'can_cant',
      level: 'A1',
      title: 'Can and Can’t',
      shortDescription: 'Express ability and permission.',
      introduction: 'Can and can’t are used to talk about ability or permission.',
      whenToUse: [
        'To show ability',
        'To ask for permission',
      ],
      rules: [
        'Use can + base verb for ability or permission.',
        'Use can’t for inability or prohibition.',
      ],
      structures: [
        'Subject + can + verb',
      ],
      examples: [
        'I can swim.',
        'You can sit here.',
      ],
      negativeExamples: [
        'I can’t swims.',
      ],
      questionExamples: [
        'Can you help me?',
      ],
      commonMistakes: [
        'Using “to” after can.',
      ],
      tips: [
        'The main verb stays in the base form after can.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I _____ swim very well.', options: ['can', 'can’t', 'cannot', 'cans'], correctAnswerIndex: 0, explanation: 'Use “can” for ability.'),
        GrammarQuizQuestion(question: 'She _____ speak English fluently.', options: ['can', 'can’t', 'cans', 'could'], correctAnswerIndex: 0, explanation: '“Can” is used for present ability.'),
        GrammarQuizQuestion(question: 'We _____ come today because we are busy.', options: ['can', 'can’t', 'could', 'cans'], correctAnswerIndex: 1, explanation: '“Can’t” shows inability.'),
        GrammarQuizQuestion(question: '_____ you help me?', options: ['Can', 'Can’t', 'Could', 'Cans'], correctAnswerIndex: 0, explanation: 'Use “can” in a question about ability.'),
        GrammarQuizQuestion(question: 'He _____ drive yet because he is very young.', options: ['can', 'can’t', 'could', 'cans'], correctAnswerIndex: 1, explanation: '“Can’t” shows lack of ability.'),
      ],
    ),
    GrammarTopic(
      id: 'should_shouldnt',
      level: 'A1',
      title: 'Should and Shouldn’t',
      shortDescription: 'Give advice and suggestions.',
      introduction: 'Use should and shouldn’t to give advice.',
      whenToUse: [
        'Advice',
        'Suggestions',
      ],
      rules: [
        'Use should + base verb for advice.',
        'Use shouldn’t + base verb for advice against something.',
      ],
      structures: [
        'You should + verb',
      ],
      examples: [
        'You should study more.',
        'You shouldn’t smoke.',
      ],
      negativeExamples: [
        'You should not to smoke.',
      ],
      questionExamples: [
        'Should I call her?',
      ],
      commonMistakes: [
        'Using “to” after should.',
      ],
      tips: [
        'If you want to give advice, should is a useful choice.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'You _____ drink more water.', options: ['should', 'shouldn’t', 'can', 'must'], correctAnswerIndex: 0, explanation: 'Use “should” to give advice.'),
        GrammarQuizQuestion(question: 'You _____ smoke.', options: ['should', 'shouldn’t', 'can', 'must'], correctAnswerIndex: 1, explanation: 'Use “shouldn’t” for advice against smoking.'),
        GrammarQuizQuestion(question: 'I think you _____ call your doctor.', options: ['should', 'shouldn’t', 'can', 'must'], correctAnswerIndex: 0, explanation: '“Should” gives advice.'),
        GrammarQuizQuestion(question: 'You _____ eat so quickly.', options: ['should', 'shouldn’t', 'can', 'must'], correctAnswerIndex: 1, explanation: '“Shouldn’t” suggests something is not a good idea.'),
        GrammarQuizQuestion(question: 'We _____ practice every day.', options: ['should', 'shouldn’t', 'can', 'must'], correctAnswerIndex: 0, explanation: '“Should” gives useful advice.'),
      ],
    ),
    GrammarTopic(
      id: 'must_mustnt',
      level: 'A1',
      title: 'Must and Mustn’t',
      shortDescription: 'Show obligation and prohibition.',
      introduction: 'Must and mustn’t are used to talk about obligation and rules.',
      whenToUse: [
        'Rules',
        'Strong advice',
      ],
      rules: [
        'Use must + base verb for necessity.',
        'Use mustn’t + base verb for prohibition.',
      ],
      structures: [
        'You must + verb',
      ],
      examples: [
        'You must wear a seat belt.',
        'You mustn’t park here.',
      ],
      negativeExamples: [
        'You must not to park here.',
      ],
      questionExamples: [
        'Must I leave now?',
      ],
      commonMistakes: [
        'Using the wrong form after must.',
      ],
      tips: [
        'Must is stronger than should.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'You _____ wear a helmet.', options: ['must', 'mustn’t', 'should', 'can'], correctAnswerIndex: 0, explanation: '“Must” shows obligation.'),
        GrammarQuizQuestion(question: 'You _____ smoke in the hospital.', options: ['must', 'mustn’t', 'should', 'can'], correctAnswerIndex: 1, explanation: '“Mustn’t” shows prohibition.'),
        GrammarQuizQuestion(question: 'We _____ be on time.', options: ['must', 'mustn’t', 'should', 'can'], correctAnswerIndex: 0, explanation: '“Must” shows a rule.'),
        GrammarQuizQuestion(question: 'You _____ talk during the exam.', options: ['must', 'mustn’t', 'should', 'can'], correctAnswerIndex: 1, explanation: '“Mustn’t” shows the prohibition.'),
        GrammarQuizQuestion(question: 'I _____ finish this today.', options: ['must', 'mustn’t', 'should', 'can'], correctAnswerIndex: 0, explanation: '“Must” shows necessity.'),
      ],
    ),
    GrammarTopic(
      id: 'have_to',
      level: 'A1',
      title: 'Have To',
      shortDescription: 'Talk about obligation and necessity.',
      introduction: 'Have to is used for rules and obligations.',
      whenToUse: [
        'Rules',
        'Daily obligations',
      ],
      rules: [
        'Use have to for external obligations.',
        'Use don’t have to for lack of obligation.',
      ],
      structures: [
        'Subject + have to + verb',
      ],
      examples: [
        'I have to work tomorrow.',
        'We don’t have to leave now.',
      ],
      negativeExamples: [
        'I has to work tomorrow.',
      ],
      questionExamples: [
        'Do you have to leave?',
      ],
      commonMistakes: [
        'Using the wrong form of have.',
      ],
      tips: [
        'Use “do/does” for questions and negatives.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I _____ get up early tomorrow.', options: ['have to', 'has to', 'had to', 'having to'], correctAnswerIndex: 0, explanation: 'Use “have to” with “I”.'),
        GrammarQuizQuestion(question: 'She _____ wear a uniform at school.', options: ['have to', 'has to', 'had to', 'having to'], correctAnswerIndex: 1, explanation: 'Use “has to” with “she”.'),
        GrammarQuizQuestion(question: 'We _____ leave now.', options: ['have to', 'has to', 'had to', 'having to'], correctAnswerIndex: 0, explanation: 'Use “have to” with “we”.'),
        GrammarQuizQuestion(question: 'They _____ pay the bill.', options: ['have to', 'has to', 'had to', 'having to'], correctAnswerIndex: 0, explanation: 'Use “have to” with “they”.'),
        GrammarQuizQuestion(question: 'He _____ take the bus.', options: ['have to', 'has to', 'had to', 'having to'], correctAnswerIndex: 1, explanation: 'Use “has to” with “he”.'),
      ],
    ),
    GrammarTopic(
      id: 'adjectives',
      level: 'A1',
      title: 'Adjectives',
      shortDescription: 'Describe nouns with adjectives.',
      introduction: 'Adjectives describe people, places, and things.',
      whenToUse: [
        'To describe nouns',
        'To add detail',
      ],
      rules: [
        'Adjectives often come before a noun.',
        'They can also come after the verb be.',
      ],
      structures: [
        'Adjective + noun',
        'Subject + be + adjective',
      ],
      examples: [
        'A big house.',
        'The house is big.',
      ],
      negativeExamples: [
        'A house big.',
      ],
      questionExamples: [
        'She is kind.',
      ],
      commonMistakes: [
        'Placing adjectives in the wrong position.',
      ],
      tips: [
        'Use an adjective to make your sentence more descriptive.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'She has a _____ dog.', options: ['small', 'smaller', 'smallest', 'smallness'], correctAnswerIndex: 0, explanation: '“Small” is a basic adjective used before the noun.'),
        GrammarQuizQuestion(question: 'The room is _____', options: ['clean', 'cleanly', 'cleaner', 'cleanest'], correctAnswerIndex: 0, explanation: 'The adjective comes after “is”.'),
        GrammarQuizQuestion(question: 'He bought a _____ shirt.', options: ['blue', 'bluer', 'bluest', 'blueing'], correctAnswerIndex: 0, explanation: '“Blue” describes the noun “shirt”.'),
        GrammarQuizQuestion(question: 'The weather is _____ today.', options: ['nice', 'nicely', 'nicer', 'nicest'], correctAnswerIndex: 0, explanation: 'The adjective “nice” describes the weather.'),
        GrammarQuizQuestion(question: 'We saw a _____ bird.', options: ['beautiful', 'beauty', 'beautifully', 'beautify'], correctAnswerIndex: 0, explanation: '“Beautiful” is an adjective describing the noun.'),
      ],
    ),
    GrammarTopic(
      id: 'comparative_adjectives',
      level: 'A1',
      title: 'Comparative Adjectives',
      shortDescription: 'Compare two things with adjectives.',
      introduction: 'Comparative adjectives compare two people, things, or ideas.',
      whenToUse: [
        'To compare two items',
        'To show difference',
      ],
      rules: [
        'Add -er to short adjectives or use more before longer adjectives.',
      ],
      structures: [
        'Subject + be + adjective-er than + noun',
      ],
      examples: [
        'My car is faster than yours.',
        'This book is more interesting than that one.',
      ],
      negativeExamples: [
        'My car is more fast than yours.',
      ],
      questionExamples: [
        'She is taller than me.',
      ],
      commonMistakes: [
        'Using the wrong comparative form.',
      ],
      tips: [
        'Learn common irregular comparatives such as good → better.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'This book is _____ than that one.', options: ['interesting', 'more interesting', 'most interesting', 'interest'], correctAnswerIndex: 1, explanation: 'Long adjectives often use “more” before them.'),
        GrammarQuizQuestion(question: 'My brother is _____ than me.', options: ['tall', 'taller', 'tallest', 'more tall'], correctAnswerIndex: 1, explanation: 'Short adjectives add -er.'),
        GrammarQuizQuestion(question: 'This test is _____ than the last one.', options: ['easy', 'easier', 'easiest', 'more easy'], correctAnswerIndex: 1, explanation: 'Short adjectives add -er.'),
        GrammarQuizQuestion(question: 'The weather today is _____ than yesterday.', options: ['bad', 'worse', 'baddest', 'more bad'], correctAnswerIndex: 1, explanation: '“Worse” is the irregular comparative form.'),
        GrammarQuizQuestion(question: 'This restaurant is _____ than the other one.', options: ['expensive', 'more expensive', 'most expensive', 'expensiver'], correctAnswerIndex: 1, explanation: 'Long adjectives use “more”.'),
      ],
    ),
    GrammarTopic(
      id: 'superlative_adjectives',
      level: 'A1',
      title: 'Superlative Adjectives',
      shortDescription: 'Compare three or more things with superlatives.',
      introduction: 'Superlative adjectives describe the highest degree among three or more things.',
      whenToUse: [
        'To compare three or more items',
        'To show the best or worst',
      ],
      rules: [
        'Add -est to short adjectives or use most before longer adjectives.',
      ],
      structures: [
        'Subject + be + adjective-est',
      ],
      examples: [
        'She is the tallest student in the class.',
        'This is the most interesting book.',
      ],
      negativeExamples: [
        'She is the most tall student.',
      ],
      questionExamples: [
        'It is the biggest house.',
      ],
      commonMistakes: [
        'Choosing the wrong form for superlatives.',
      ],
      tips: [
        'A superlative often uses “the” before the adjective.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'This is the _____ building in the city.', options: ['tall', 'taller', 'tallest', 'more tall'], correctAnswerIndex: 2, explanation: 'Use the superlative form “tallest” for one among many.'),
        GrammarQuizQuestion(question: 'She is the _____ student in the class.', options: ['smart', 'smarter', 'smartest', 'more smart'], correctAnswerIndex: 2, explanation: '“Smartest” is the correct superlative form.'),
        GrammarQuizQuestion(question: 'This is the _____ movie I have ever seen.', options: ['interesting', 'more interesting', 'most interesting', 'interestinger'], correctAnswerIndex: 2, explanation: 'Long adjectives take “most”.'),
        GrammarQuizQuestion(question: 'He is the _____ runner on the team.', options: ['fast', 'faster', 'fastest', 'more fast'], correctAnswerIndex: 2, explanation: 'The superlative of “fast” is “fastest”.'),
        GrammarQuizQuestion(question: 'That was the _____ day of my life.', options: ['bad', 'worse', 'worst', 'more bad'], correctAnswerIndex: 2, explanation: '“Worst” is the irregular superlative form.'),
      ],
    ),
    GrammarTopic(
      id: 'adverbs_of_frequency',
      level: 'A1',
      title: 'Adverbs of Frequency',
      shortDescription: 'Say how often actions happen.',
      introduction: 'Adverbs of frequency show how often something happens.',
      whenToUse: [
        'To describe habits',
        'To describe routine',
      ],
      rules: [
        'Common adverbs include always, usually, often, sometimes, never.',
      ],
      structures: [
        'Subject + adverb + main verb',
      ],
      examples: [
        'I always wake up early.',
        'She usually walks to work.',
      ],
      negativeExamples: [
        'I wake up always early.',
      ],
      questionExamples: [
        'Do you often go out?',
      ],
      commonMistakes: [
        'Placing the adverb in the wrong position.',
      ],
      tips: [
        'Place the adverb before the main verb in simple present sentences.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I _____ go to the gym on weekdays.', options: ['always', 'never', 'often', 'sometimes'], correctAnswerIndex: 0, explanation: '“Always” means every time.'),
        GrammarQuizQuestion(question: 'She _____ eats breakfast before work.', options: ['usually', 'never', 'rarely', 'hardly'], correctAnswerIndex: 0, explanation: '“Usually” is a common adverb of frequency.'),
        GrammarQuizQuestion(question: 'We _____ watch TV in the evening.', options: ['often', 'always', 'seldom', 'rarely'], correctAnswerIndex: 0, explanation: '“Often” expresses a regular frequency.'),
        GrammarQuizQuestion(question: 'He _____ arrives late.', options: ['sometimes', 'always', 'often', 'usually'], correctAnswerIndex: 0, explanation: '“Sometimes” means not every time.'),
        GrammarQuizQuestion(question: 'They _____ go out on Sundays.', options: ['usually', 'always', 'often', 'sometimes'], correctAnswerIndex: 0, explanation: '“Usually” is suitable for a regular habit.'),
      ],
    ),
    GrammarTopic(
      id: 'prepositions_of_time',
      level: 'A1',
      title: 'Prepositions of Time',
      shortDescription: 'Use in, on, and at correctly for time.',
      introduction: 'Prepositions of time help us describe when something happens.',
      whenToUse: [
        'When talking about dates and times',
      ],
      rules: [
        'Use in for months, years, and parts of the day.',
        'Use on for days and dates.',
        'Use at for exact times.',
      ],
      structures: [
        'in January',
        'on Monday',
        'at 7 o’clock',
      ],
      examples: [
        'I study in the evening.',
        'We meet on Friday.',
      ],
      negativeExamples: [
        'I study at the evening.',
      ],
      questionExamples: [
        'We leave at 8:00.',
      ],
      commonMistakes: [
        'Choosing the wrong preposition for time.',
      ],
      tips: [
        'Think about whether you mean a period, a day, or a point in time.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'We meet _____ Monday.', options: ['in', 'on', 'at', 'for'], correctAnswerIndex: 1, explanation: 'Use “on” for days.'),
        GrammarQuizQuestion(question: 'I wake up _____ 7 o’clock.', options: ['in', 'on', 'at', 'for'], correctAnswerIndex: 2, explanation: 'Use “at” for exact times.'),
        GrammarQuizQuestion(question: 'She was born _____ 2005.', options: ['in', 'on', 'at', 'for'], correctAnswerIndex: 0, explanation: 'Use “in” for years.'),
        GrammarQuizQuestion(question: 'The party is _____ Saturday.', options: ['in', 'on', 'at', 'for'], correctAnswerIndex: 1, explanation: 'Use “on” for days.'),
        GrammarQuizQuestion(question: 'We have class _____ the morning.', options: ['in', 'on', 'at', 'for'], correctAnswerIndex: 0, explanation: 'Use “in” for parts of the day.'),
      ],
    ),
    GrammarTopic(
      id: 'prepositions_of_place',
      level: 'A1',
      title: 'Prepositions of Place',
      shortDescription: 'Describe where things are.',
      introduction: 'Prepositions of place show location.',
      whenToUse: [
        'When describing location',
        'When giving directions',
      ],
      rules: [
        'Use in, on, at, under, behind, between, next to, and in front of depending on the position.',
      ],
      structures: [
        'The book is on the table.',
      ],
      examples: [
        'The keys are in the bag.',
        'The cat is under the chair.',
      ],
      negativeExamples: [
        'The keys are at the bag.',
      ],
      questionExamples: [
        'Where is the museum?',
      ],
      commonMistakes: [
        'Choosing the wrong preposition for a location.',
      ],
      tips: [
        'Picture the location in your mind.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'The book is _____ the table.', options: ['in', 'on', 'at', 'between'], correctAnswerIndex: 1, explanation: 'Use “on” when something is resting on a surface.'),
        GrammarQuizQuestion(question: 'The cat is _____ the chair.', options: ['under', 'on', 'in', 'next to'], correctAnswerIndex: 0, explanation: '“Under” shows something beneath the chair.'),
        GrammarQuizQuestion(question: 'The keys are _____ the bag.', options: ['in', 'on', 'under', 'behind'], correctAnswerIndex: 0, explanation: 'Use “in” for inside something.'),
        GrammarQuizQuestion(question: 'The school is _____ the bank.', options: ['next to', 'under', 'in', 'on'], correctAnswerIndex: 0, explanation: '“Next to” shows adjacency.'),
        GrammarQuizQuestion(question: 'The dog is _____ the car.', options: ['behind', 'on', 'in', 'under'], correctAnswerIndex: 0, explanation: '“Behind” shows the dog is at the back of the car.'),
      ],
    ),
    GrammarTopic(
      id: 'prepositions_of_movement',
      level: 'A1',
      title: 'Prepositions of Movement',
      shortDescription: 'Describe movement with prepositions like into, onto, out of, and across.',
      introduction: 'Prepositions of movement describe how someone or something moves.',
      whenToUse: [
        'When giving directions',
        'When describing motion',
      ],
      rules: [
        'Use into, onto, out of, across, along, and towards for movement.',
      ],
      structures: [
        'Go into the room',
        'Walk across the street',
      ],
      examples: [
        'She walked into the room.',
        'We drove across the bridge.',
      ],
      negativeExamples: [
        'She walked in the room.',
      ],
      questionExamples: [
        'He ran across the road.',
      ],
      commonMistakes: [
        'Using place prepositions for movement.',
      ],
      tips: [
        'Think about direction and movement.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'She walked _____ the room.', options: ['into', 'in', 'on', 'under'], correctAnswerIndex: 0, explanation: '“Into” shows movement to the inside of a place.'),
        GrammarQuizQuestion(question: 'We drove _____ the bridge.', options: ['across', 'over', 'in', 'at'], correctAnswerIndex: 0, explanation: '“Across” shows movement from one side to the other.'),
        GrammarQuizQuestion(question: 'He jumped _____ the river.', options: ['across', 'into', 'on', 'between'], correctAnswerIndex: 0, explanation: '“Across” describes movement to the other side.'),
        GrammarQuizQuestion(question: 'They came _____ the house.', options: ['out of', 'into', 'onto', 'under'], correctAnswerIndex: 0, explanation: '“Out of” shows movement from inside to outside.'),
        GrammarQuizQuestion(question: 'The cat jumped _____ the table.', options: ['onto', 'under', 'between', 'in'], correctAnswerIndex: 0, explanation: '“Onto” shows movement to a surface.'),
      ],
    ),
    GrammarTopic(
      id: 'some_any',
      level: 'A1',
      title: 'Some and Any',
      shortDescription: 'Use some and any for indefinite quantities.',
      introduction: 'Some and any refer to an unspecified amount of something.',
      whenToUse: [
        'When talking about quantities',
        'In positive and negative sentences',
      ],
      rules: [
        'Use some in positive statements.',
        'Use any in questions and negatives.',
      ],
      structures: [
        'Some + noun',
        'Any + noun',
      ],
      examples: [
        'I have some friends.',
        'Do you have any bread?',
      ],
      negativeExamples: [
        'I have any friends.',
      ],
      questionExamples: [
        'Do you need any help?',
      ],
      commonMistakes: [
        'Using some in questions or negatives.',
      ],
      tips: [
        'Think about whether the sentence is positive, negative, or a question.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I have _____ money.', options: ['some', 'any', 'many', 'much'], correctAnswerIndex: 0, explanation: 'Use “some” in a positive statement.'),
        GrammarQuizQuestion(question: 'Do you have _____ water?', options: ['some', 'any', 'many', 'much'], correctAnswerIndex: 1, explanation: 'Use “any” in questions.'),
        GrammarQuizQuestion(question: 'There isn’t _____ milk left.', options: ['some', 'any', 'many', 'much'], correctAnswerIndex: 1, explanation: 'Use “any” in a negative sentence.'),
        GrammarQuizQuestion(question: 'She bought _____ apples.', options: ['some', 'any', 'many', 'much'], correctAnswerIndex: 0, explanation: '“Some” is used in a positive statement.'),
        GrammarQuizQuestion(question: 'Do they need _____ help?', options: ['some', 'any', 'many', 'much'], correctAnswerIndex: 1, explanation: 'Use “any” in questions.'),
      ],
    ),
    GrammarTopic(
      id: 'much_many',
      level: 'A1',
      title: 'Much and Many',
      shortDescription: 'Ask about large quantities.',
      introduction: 'Much and many are used for large quantities.',
      whenToUse: [
        'With uncountable and countable nouns',
      ],
      rules: [
        'Use much with uncountable nouns.',
        'Use many with countable nouns.',
      ],
      structures: [
        'How much + uncountable noun',
        'How many + countable noun',
      ],
      examples: [
        'How much water do you need?',
        'How many apples do you want?',
      ],
      negativeExamples: [
        'How many water do you need?',
      ],
      questionExamples: [
        'How many students are there?',
      ],
      commonMistakes: [
        'Mixing up countable and uncountable nouns.',
      ],
      tips: [
        'If you can count it, use many.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'How _____ money do you need?', options: ['much', 'many', 'few', 'little'], correctAnswerIndex: 0, explanation: 'Money is uncountable, so we use “much”.'),
        GrammarQuizQuestion(question: 'How _____ apples are there?', options: ['much', 'many', 'few', 'little'], correctAnswerIndex: 1, explanation: 'Apples are countable, so we use “many”.'),
        GrammarQuizQuestion(question: 'How _____ rice do you want?', options: ['much', 'many', 'few', 'little'], correctAnswerIndex: 0, explanation: 'Rice is uncountable, so we use “much”.'),
        GrammarQuizQuestion(question: 'How _____ books do you have?', options: ['much', 'many', 'few', 'little'], correctAnswerIndex: 1, explanation: 'Books are countable, so we use “many”.'),
        GrammarQuizQuestion(question: 'How _____ information do you need?', options: ['much', 'many', 'few', 'little'], correctAnswerIndex: 0, explanation: 'Information is uncountable, so we use “much”.'),
      ],
    ),
    GrammarTopic(
      id: 'a_lot_of',
      level: 'A1',
      title: 'A Lot Of',
      shortDescription: 'Describe large quantities.',
      introduction: 'A lot of is used for large amounts.',
      whenToUse: [
        'With countable and uncountable nouns',
      ],
      rules: [
        'Use a lot of with both countable and uncountable nouns.',
      ],
      structures: [
        'a lot of + noun',
      ],
      examples: [
        'I have a lot of books.',
        'She drinks a lot of water.',
      ],
      negativeExamples: [
        'I have a lot of waters.',
      ],
      questionExamples: [
        'Do you have a lot of homework?',
      ],
      commonMistakes: [
        'Using the wrong quantifier after a lot of.',
      ],
      tips: [
        'Use “a lot of” for big amounts.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I have _____ friends.', options: ['a lot of', 'many', 'much', 'few'], correctAnswerIndex: 0, explanation: '“A lot of” works with countable nouns like “friends”.'),
        GrammarQuizQuestion(question: 'She drinks _____ water.', options: ['a lot of', 'many', 'much', 'few'], correctAnswerIndex: 0, explanation: '“A lot of” works well with uncountable nouns like “water”.'),
        GrammarQuizQuestion(question: 'There are _____ people here.', options: ['a lot of', 'many', 'much', 'few'], correctAnswerIndex: 0, explanation: '“A lot of” can also be used with plural countable nouns.'),
        GrammarQuizQuestion(question: 'We need _____ time.', options: ['a lot of', 'many', 'much', 'few'], correctAnswerIndex: 0, explanation: 'Time is uncountable, so “a lot of” is correct.'),
        GrammarQuizQuestion(question: 'He has _____ homework.', options: ['a lot of', 'many', 'much', 'few'], correctAnswerIndex: 0, explanation: '“Homework” is uncountable, so “a lot of” is a good choice.'),
      ],
    ),
    GrammarTopic(
      id: 'a_few_a_little',
      level: 'A1',
      title: 'A Few and A Little',
      shortDescription: 'Talk about small quantities.',
      introduction: 'A few and a little describe small amounts.',
      whenToUse: [
        'When the amount is small',
      ],
      rules: [
        'Use a few with countable nouns.',
        'Use a little with uncountable nouns.',
      ],
      structures: [
        'a few + plural noun',
        'a little + uncountable noun',
      ],
      examples: [
        'I have a few friends.',
        'I need a little help.',
      ],
      negativeExamples: [
        'I have a little friends.',
      ],
      questionExamples: [
        'Can I have a little sugar?',
      ],
      commonMistakes: [
        'Choosing the wrong quantifier for countable or uncountable nouns.',
      ],
      tips: [
        'Countable? Use a few. Uncountable? Use a little.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I have _____ friends in this city.', options: ['a few', 'a little', 'many', 'much'], correctAnswerIndex: 0, explanation: 'Friends are countable, so “a few” is correct.'),
        GrammarQuizQuestion(question: 'Can I have _____ sugar?', options: ['a few', 'a little', 'many', 'much'], correctAnswerIndex: 1, explanation: 'Sugar is uncountable, so “a little” is correct.'),
        GrammarQuizQuestion(question: 'She has _____ books on the shelf.', options: ['a few', 'a little', 'many', 'much'], correctAnswerIndex: 0, explanation: 'Books are countable, so use “a few”.'),
        GrammarQuizQuestion(question: 'We need _____ time before the class starts.', options: ['a few', 'a little', 'many', 'much'], correctAnswerIndex: 1, explanation: 'Time is uncountable, so use “a little”.'),
        GrammarQuizQuestion(question: 'There are _____ chairs in the room.', options: ['a few', 'a little', 'many', 'much'], correctAnswerIndex: 0, explanation: 'Chairs are countable, so “a few” is correct.'),
      ],
    ),
    GrammarTopic(
      id: 'question_words',
      level: 'A1',
      title: 'Question Words',
      shortDescription: 'Ask questions with who, what, where, when, why, and how.',
      introduction: 'Question words help us ask for information.',
      whenToUse: [
        'When asking for information',
      ],
      rules: [
        'Use who for people, what for things, where for places, when for time, why for reasons, and how for manner.',
      ],
      structures: [
        'What + be/verb?',
        'Where + do/does?',
      ],
      examples: [
        'What is your name?',
        'Where do you live?',
      ],
      negativeExamples: [
        'Why your name?',
      ],
      questionExamples: [
        'When is your birthday?',
      ],
      commonMistakes: [
        'Choosing the wrong question word.',
      ],
      tips: [
        'Match the word to the kind of information you want.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: '_____ is your name?', options: ['What', 'Where', 'When', 'Why'], correctAnswerIndex: 0, explanation: 'Use “What” for asking a name.'),
        GrammarQuizQuestion(question: '_____ do you live?', options: ['What', 'Where', 'When', 'Who'], correctAnswerIndex: 1, explanation: 'Use “Where” for places.'),
        GrammarQuizQuestion(question: '_____ is your birthday?', options: ['What', 'Where', 'When', 'Why'], correctAnswerIndex: 2, explanation: 'Use “When” for time.'),
        GrammarQuizQuestion(question: '_____ are you sad?', options: ['What', 'Where', 'When', 'Why'], correctAnswerIndex: 3, explanation: 'Use “Why” to ask for a reason.'),
        GrammarQuizQuestion(question: '_____ is she?', options: ['Who', 'What', 'Where', 'When'], correctAnswerIndex: 0, explanation: 'Use “Who” for people.'),
      ],
    ),
    GrammarTopic(
      id: 'how_much_how_many',
      level: 'A1',
      title: 'How Much / How Many',
      shortDescription: 'Ask about quantity.',
      introduction: 'How much and how many ask about quantity.',
      whenToUse: [
        'To ask about amount',
      ],
      rules: [
        'Use how much with uncountable nouns.',
        'Use how many with countable nouns.',
      ],
      structures: [
        'How much + uncountable noun',
        'How many + countable noun',
      ],
      examples: [
        'How much water do you drink?',
        'How many apples do you want?',
      ],
      negativeExamples: [
        'How much apples do you want?',
      ],
      questionExamples: [
        'How many students are there?',
      ],
      commonMistakes: [
        'Using too much or too many incorrectly.',
      ],
      tips: [
        'Check whether the noun is countable or uncountable.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'How _____ sugar do you want?', options: ['many', 'much', 'few', 'a little'], correctAnswerIndex: 1, explanation: 'Sugar is uncountable, so use “much”.'),
        GrammarQuizQuestion(question: 'How _____ pens do you need?', options: ['many', 'much', 'few', 'a little'], correctAnswerIndex: 0, explanation: 'Pens are countable, so use “many”.'),
        GrammarQuizQuestion(question: 'How _____ money do you have?', options: ['many', 'much', 'few', 'a little'], correctAnswerIndex: 1, explanation: 'Money is uncountable, so use “much”.'),
        GrammarQuizQuestion(question: 'How _____ books are on the table?', options: ['many', 'much', 'few', 'a little'], correctAnswerIndex: 0, explanation: 'Books are countable, so use “many”.'),
        GrammarQuizQuestion(question: 'How _____ time do we have?', options: ['many', 'much', 'few', 'a little'], correctAnswerIndex: 1, explanation: 'Time is uncountable, so use “much”.'),
      ],
    ),
    GrammarTopic(
      id: 'imperatives',
      level: 'A1',
      title: 'Imperatives',
      shortDescription: 'Give commands and instructions.',
      introduction: 'Imperatives are used to give instructions or commands.',
      whenToUse: [
        'When giving instructions',
        'When telling someone to do something',
      ],
      rules: [
        'Use the base verb without a subject.',
      ],
      structures: [
        'Verb + object',
      ],
      examples: [
        'Open the door.',
        'Please sit down.',
      ],
      negativeExamples: [
        'You open the door.',
      ],
      questionExamples: [
        'Please wait here.',
      ],
      commonMistakes: [
        'Adding a subject to an imperative.',
      ],
      tips: [
        'Imperatives sound direct and clear.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: '_____ the door.', options: ['Open', 'Opens', 'Opening', 'Opened'], correctAnswerIndex: 0, explanation: 'Imperatives use the base verb without a subject.'),
        GrammarQuizQuestion(question: '_____ your homework.', options: ['Do', 'Does', 'Doing', 'Done'], correctAnswerIndex: 0, explanation: 'The imperative uses the base form of the verb.'),
        GrammarQuizQuestion(question: '_____ quiet!', options: ['Be', 'Is', 'Are', 'Being'], correctAnswerIndex: 0, explanation: '“Be” is the correct imperative for a command.'),
        GrammarQuizQuestion(question: '_____ me a hand.', options: ['Give', 'Gives', 'Giving', 'Given'], correctAnswerIndex: 0, explanation: 'The imperative uses the base verb.'),
        GrammarQuizQuestion(question: '_____ here, please.', options: ['Wait', 'Waits', 'Waiting', 'Waited'], correctAnswerIndex: 0, explanation: 'The command uses the base verb.'),
      ],
    ),
    GrammarTopic(
      id: 'and_but_or',
      level: 'A1',
      title: 'And / But / Or',
      shortDescription: 'Connect ideas with conjunctions.',
      introduction: 'And, but, and or help us connect words and clauses.',
      whenToUse: [
        'To combine ideas',
        'To show contrast',
        'To offer choices',
      ],
      rules: [
        'Use and to add ideas.',
        'Use but to show contrast.',
        'Use or to show choices.',
      ],
      structures: [
        'noun and noun',
        'sentence but sentence',
      ],
      examples: [
        'I like tea and coffee.',
        'She is tired but happy.',
      ],
      negativeExamples: [
        'I like tea but coffee.',
      ],
      questionExamples: [
        'Do you want tea or coffee?',
      ],
      commonMistakes: [
        'Choosing the wrong conjunction for the meaning.',
      ],
      tips: [
        'Think about whether you are adding, contrasting, or choosing.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I like tea _____ coffee.', options: ['and', 'but', 'or', 'because'], correctAnswerIndex: 0, explanation: 'Use “and” to add ideas.'),
        GrammarQuizQuestion(question: 'She is tired _____ happy.', options: ['and', 'but', 'or', 'because'], correctAnswerIndex: 1, explanation: 'Use “but” to show contrast.'),
        GrammarQuizQuestion(question: 'Would you like tea _____ coffee?', options: ['and', 'but', 'or', 'because'], correctAnswerIndex: 2, explanation: 'Use “or” to offer a choice.'),
        GrammarQuizQuestion(question: 'I like music _____ movies.', options: ['and', 'but', 'or', 'because'], correctAnswerIndex: 0, explanation: '“And” adds two things.'),
        GrammarQuizQuestion(question: 'He is rich _____ unhappy.', options: ['and', 'but', 'or', 'because'], correctAnswerIndex: 1, explanation: '“But” shows a contrast.'),
      ],
    ),
    GrammarTopic(
      id: 'because_so',
      level: 'A1',
      title: 'Because / So',
      shortDescription: 'Explain reasons and results.',
      introduction: 'Because and so connect reasons with results.',
      whenToUse: [
        'To explain reasons',
        'To show results',
      ],
      rules: [
        'Use because to give a reason.',
        'Use so to show the result.',
      ],
      structures: [
        'because + clause',
        'so + clause',
      ],
      examples: [
        'I stayed home because it was raining.',
        'It was raining, so I stayed home.',
      ],
      negativeExamples: [
        'I stayed home so it was raining.',
      ],
      questionExamples: [
        'He was tired, so he slept.',
      ],
      commonMistakes: [
        'Mixing up cause and effect.',
      ],
      tips: [
        'Ask whether you need the reason or the result.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I stayed home _____ it was raining.', options: ['because', 'so', 'and', 'but'], correctAnswerIndex: 0, explanation: 'Use “because” for the reason.'),
        GrammarQuizQuestion(question: 'It was late, _____ I went to bed.', options: ['because', 'so', 'and', 'but'], correctAnswerIndex: 1, explanation: 'Use “so” to show the result.'),
        GrammarQuizQuestion(question: 'She was hungry _____ she ate something.', options: ['because', 'so', 'and', 'but'], correctAnswerIndex: 1, explanation: '“So” introduces the result.'),
        GrammarQuizQuestion(question: 'We cancelled the trip _____ the weather was bad.', options: ['because', 'so', 'and', 'but'], correctAnswerIndex: 0, explanation: 'Use “because” to give the reason.'),
        GrammarQuizQuestion(question: 'The road was closed, _____ we took another route.', options: ['because', 'so', 'and', 'but'], correctAnswerIndex: 1, explanation: '“So” introduces the result.'),
      ],
    ),
    GrammarTopic(
      id: 'like_ing',
      level: 'A1',
      title: 'Like + -ing',
      shortDescription: 'Say what you enjoy doing.',
      introduction: 'We use like + verb-ing to talk about hobbies and preferences.',
      whenToUse: [
        'When talking about likes and dislikes',
      ],
      rules: [
        'Use like/love/enjoy + verb-ing.',
      ],
      structures: [
        'I like + verb-ing',
      ],
      examples: [
        'I like reading.',
        'She loves swimming.',
      ],
      negativeExamples: [
        'I like to read.',
      ],
      questionExamples: [
        'Do you enjoy cooking?',
      ],
      commonMistakes: [
        'Using the infinitive where the -ing form is expected.',
      ],
      tips: [
        'Use the -ing form after like and enjoy.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I like _____ books.', options: ['read', 'reading', 'to read', 'reads'], correctAnswerIndex: 1, explanation: 'After “like”, we often use the -ing form.'),
        GrammarQuizQuestion(question: 'She loves _____ in the garden.', options: ['work', 'working', 'to work', 'works'], correctAnswerIndex: 1, explanation: 'Use the -ing form after “love”.'),
        GrammarQuizQuestion(question: 'We enjoy _____ music.', options: ['listen', 'listening', 'to listen', 'listens'], correctAnswerIndex: 1, explanation: 'The -ing form follows “enjoy”.'),
        GrammarQuizQuestion(question: 'They like _____ football.', options: ['play', 'playing', 'to play', 'plays'], correctAnswerIndex: 1, explanation: 'Use the -ing form after “like”.'),
        GrammarQuizQuestion(question: 'He hates _____ early.', options: ['get up', 'getting up', 'to get up', 'gets up'], correctAnswerIndex: 1, explanation: 'After “hate”, we often use the -ing form.'),
      ],
    ),
    GrammarTopic(
      id: 'want_to',
      level: 'A1',
      title: 'Want + To',
      shortDescription: 'Express desires and intentions.',
      introduction: 'Want to is used to express wishes or intentions.',
      whenToUse: [
        'To express desire',
        'To express plans',
      ],
      rules: [
        'Use want + to + base verb.',
      ],
      structures: [
        'Subject + want + to + base verb',
      ],
      examples: [
        'I want to learn English.',
        'She wants to travel.',
      ],
      negativeExamples: [
        'I want learning English.',
      ],
      questionExamples: [
        'Do you want to go?',
      ],
      commonMistakes: [
        'Forgetting the infinitive after want.',
      ],
      tips: [
        'If you want to state a desire, use “want to”.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I _____ to learn English.', options: ['want', 'wants', 'wanted', 'wanting'], correctAnswerIndex: 0, explanation: 'Use “want” with “I”.'),
        GrammarQuizQuestion(question: 'She _____ to visit Paris.', options: ['want', 'wants', 'wanted', 'wanting'], correctAnswerIndex: 1, explanation: 'Use “wants” with “she”.'),
        GrammarQuizQuestion(question: 'They _____ to watch a movie.', options: ['want', 'wants', 'wanted', 'wanting'], correctAnswerIndex: 0, explanation: 'Use “want” with “they”.'),
        GrammarQuizQuestion(question: 'He _____ to play football.', options: ['want', 'wants', 'wanted', 'wanting'], correctAnswerIndex: 1, explanation: 'Use “wants” with “he”.'),
        GrammarQuizQuestion(question: 'We _____ to go home.', options: ['want', 'wants', 'wanted', 'wanting'], correctAnswerIndex: 0, explanation: 'Use “want” with “we”.'),
      ],
    ),
    GrammarTopic(
      id: 'need_to',
      level: 'A1',
      title: 'Need + To',
      shortDescription: 'Express necessity.',
      introduction: 'Need to expresses necessity or obligation.',
      whenToUse: [
        'To show necessity',
      ],
      rules: [
        'Use need + to + base verb.',
      ],
      structures: [
        'Subject + need + to + base verb',
      ],
      examples: [
        'I need to study.',
        'She needs to rest.',
      ],
      negativeExamples: [
        'I need studying.',
      ],
      questionExamples: [
        'Do you need to go?',
      ],
      commonMistakes: [
        'Forgetting the infinitive after need.',
      ],
      tips: [
        'Use “need to” when something is necessary.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'I _____ to finish this work.', options: ['need', 'needs', 'needing', 'needed'], correctAnswerIndex: 0, explanation: 'Use “need” with “I”.'),
        GrammarQuizQuestion(question: 'She _____ to call her mother.', options: ['need', 'needs', 'needing', 'needed'], correctAnswerIndex: 1, explanation: 'Use “needs” with “she”.'),
        GrammarQuizQuestion(question: 'We _____ to leave now.', options: ['need', 'needs', 'needing', 'needed'], correctAnswerIndex: 0, explanation: 'Use “need” with “we”.'),
        GrammarQuizQuestion(question: 'He _____ to buy some bread.', options: ['need', 'needs', 'needing', 'needed'], correctAnswerIndex: 1, explanation: 'Use “needs” with “he”.'),
        GrammarQuizQuestion(question: 'They _____ to arrive early.', options: ['need', 'needs', 'needing', 'needed'], correctAnswerIndex: 0, explanation: 'Use “need” with “they”.'),
      ],
    ),
    GrammarTopic(
      id: 'zero_conditional',
      level: 'A1',
      title: 'Basic Zero Conditional',
      shortDescription: 'Describe general truths and facts.',
      introduction: 'The zero conditional is used for facts and situations that are always true.',
      whenToUse: [
        'General truths',
        'Scientific facts',
      ],
      rules: [
        'Use if + present simple, present simple.',
      ],
      structures: [
        'If + present simple, present simple',
      ],
      examples: [
        'If you heat ice, it melts.',
        'If it rains, the grass gets wet.',
      ],
      negativeExamples: [
        'If you heated ice, it melts.',
      ],
      questionExamples: [
        'If you mix blue and yellow, you get green.',
      ],
      commonMistakes: [
        'Using the future tense in zero conditional.',
      ],
      tips: [
        'Zero conditional describes facts that are true.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'If you heat ice, it _____', options: ['melts', 'melted', 'will melt', 'melting'], correctAnswerIndex: 0, explanation: 'Zero conditional uses the present simple in both clauses.'),
        GrammarQuizQuestion(question: 'If it rains, the ground _____ wet.', options: ['gets', 'got', 'will get', 'getting'], correctAnswerIndex: 0, explanation: 'Use present simple for a general truth.'),
        GrammarQuizQuestion(question: 'If you mix blue and yellow, you _____ green.', options: ['get', 'gets', 'will get', 'got'], correctAnswerIndex: 0, explanation: 'Use the present simple for a general fact.'),
        GrammarQuizQuestion(question: 'If I don’t sleep enough, I _____ tired.', options: ['get', 'gets', 'will get', 'got'], correctAnswerIndex: 0, explanation: 'The present simple describes a general result.'),
        GrammarQuizQuestion(question: 'If water boils, it _____', options: ['evaporates', 'evaporated', 'will evaporate', 'evaporating'], correctAnswerIndex: 0, explanation: 'Zero conditional describes a scientific fact.'),
      ],
    ),
    GrammarTopic(
      id: 'who_which_that',
      level: 'A1',
      title: 'Who / Which / That',
      shortDescription: 'Use relative pronouns to add information.',
      introduction: 'Relative pronouns connect extra information to a noun.',
      whenToUse: [
        'When adding extra information',
      ],
      rules: [
        'Use who for people, which for things, and that for both people and things.',
      ],
      structures: [
        'The person who...',
        'The thing which/that...',
      ],
      examples: [
        'The man who lives next door is kind.',
        'The book that I bought is interesting.',
      ],
      negativeExamples: [
        'The man which lives next door is kind.',
      ],
      questionExamples: [
        'Do you know the girl who works here?',
      ],
      commonMistakes: [
        'Using the wrong relative pronoun.',
      ],
      tips: [
        'Use who for people and which/that for things.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: 'The woman _____ lives next door is friendly.', options: ['who', 'which', 'that', 'where'], correctAnswerIndex: 0, explanation: '“Who” is used for people.'),
        GrammarQuizQuestion(question: 'The book _____ I bought is expensive.', options: ['who', 'which', 'that', 'where'], correctAnswerIndex: 1, explanation: '“Which” or “that” is used for things.'),
        GrammarQuizQuestion(question: 'The people _____ came yesterday were nice.', options: ['who', 'which', 'that', 'where'], correctAnswerIndex: 0, explanation: '“Who” is correct for people.'),
        GrammarQuizQuestion(question: 'The car _____ he bought is blue.', options: ['who', 'which', 'that', 'where'], correctAnswerIndex: 1, explanation: '“Which” is correct for a thing.'),
        GrammarQuizQuestion(question: 'The man _____ works here is my uncle.', options: ['who', 'which', 'that', 'where'], correctAnswerIndex: 0, explanation: '“Who” is used for a person.'),
      ],
    ),
    GrammarTopic(
      id: 'sentence_connectors',
      level: 'A1',
      title: 'Basic Sentence Connectors',
      shortDescription: 'Link ideas smoothly in sentences.',
      introduction: 'Sentence connectors make writing and speaking easier to follow.',
      whenToUse: [
        'When linking ideas',
        'When making longer sentences',
      ],
      rules: [
        'Use connectors like first, next, then, finally, and however.',
      ],
      structures: [
        'First..., then..., finally...',
      ],
      examples: [
        'First, I woke up. Then, I had breakfast.',
        'We were tired; however, we continued.',
      ],
      negativeExamples: [
        'First, I woke up. However, had breakfast.',
      ],
      questionExamples: [
        'Then, we went home.',
      ],
      commonMistakes: [
        'Using connectors without a clear connection to the idea.',
      ],
      tips: [
        'Choose the connector that matches the relationship between the ideas.',
      ],
      quizQuestions: [
        GrammarQuizQuestion(question: '_____ we arrived, we sat down.', options: ['First', 'Next', 'Then', 'Finally'], correctAnswerIndex: 0, explanation: '“First” introduces the first step.'),
        GrammarQuizQuestion(question: 'We ate dinner. _____, we watched a movie.', options: ['First', 'Next', 'Then', 'Finally'], correctAnswerIndex: 2, explanation: '“Then” shows the next step.'),
        GrammarQuizQuestion(question: 'We were tired. _____, we kept working.', options: ['However', 'And', 'Because', 'So'], correctAnswerIndex: 0, explanation: '“However” shows contrast.'),
        GrammarQuizQuestion(question: 'We finished the task. _____, we went home.', options: ['Finally', 'Next', 'Then', 'First'], correctAnswerIndex: 0, explanation: '“Finally” shows the end of the sequence.'),
        GrammarQuizQuestion(question: 'We started early. _____, we finished on time.', options: ['So', 'However', 'Because', 'And'], correctAnswerIndex: 0, explanation: '“So” shows the result of the first statement.'),
      ],
    ),
  ];
}
