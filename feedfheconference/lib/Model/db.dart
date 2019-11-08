enum QuestionType { multipleChoice, textBox }

class Database {
  List<Question> questions = [
    Question(QuestionType.textBox, 'What did you like the most in the session?'),
    Question(QuestionType.textBox, 'What did you like the least in the session?'),
    Question(QuestionType.textBox, 'In your opinion, did the session met its objectives?'),
    Question(QuestionType.textBox, 'Was there enough time for discussion?'),
    Question(QuestionType.textBox,'Tell us some suggestions you may have for future events.'),
    Question(QuestionType.textBox, 'Any final comments?'),
  ];

  List<Session> sessions = [
    Session(
        'Reception',
        'On Monday (April 1st), we hold the welcome reception at the Aula Magna of the University of Genova.',
        'Oleks Shturmov',
        'Verdi',
        '11:15 - 11:35'),
    Session(
        'Reception',
        'On Monday (April 1st), we hold the welcome reception at the Aula Magna of the University of Genova.',
        'Oleks Shturmov',
        'Verdi',
        '11:15 - 11:35'),
    Session(
        'Reception',
        'On Monday (April 1st), we hold the welcome reception at the Aula Magna of the University of Genova.',
        'Oleks Shturmov',
        'Verdi',
        '11:15 - 11:35'),
    Session(
        'Reception',
        'On Monday (April 1st), we hold the welcome reception at the Aula Magna of the University of Genova.',
        'Oleks Shturmov',
        'Verdi',
        '11:15 - 11:35'),
    Session(
        'Reception',
        'On Monday (April 1st), we hold the welcome reception at the Aula Magna of the University of Genova.',
        'Oleks Shturmov',
        'Verdi',
        '11:15 - 11:35'),
  ];
}

class Question {
  String questionText;
  var questionSubText;
  QuestionType type;
  Question(this.type, this.questionText, {this.questionSubText = 0.0}) {
    // Controlo do erro , caso a pergunta seja do tipo multiple choice this.questionSubText
    if (this.type == QuestionType.multipleChoice) {}
  }
}

class Session {
  String title;
  String description;
  String speaker;
  String room;
  String time;
  Session(this.title, this.description, this.speaker, this.room, this.time);
}
