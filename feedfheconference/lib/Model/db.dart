enum QuestionType { radioButton, checkBox, textBox }

List<String> options = ['1','2','3','4','5'];

class Database {
  List<Question> questions = [
    Question(QuestionType.textBox, 'What did you like the most in the session?', null),
    Question(QuestionType.textBox, 'What did you like the least in the session?', null),
    Question(QuestionType.textBox, 'In your opinion, did the session met its objectives?', null),
    Question(QuestionType.textBox, 'Was there enough time for discussion?', null),
    Question(QuestionType.textBox,'Tell us some suggestions you may have for future events.', null),
    Question(QuestionType.textBox, 'Any final comments?', null),
    Question(QuestionType.radioButton, 'Rate your experience.', options),
    Question(QuestionType.checkBox, 'Choose numbers.', options)
  ];

  List<Session> sessions = [
    Session(
        'Reception. This is not just a reception, but a Reception.',
        'On Monday (April 1st), we hold the welcome reception at the Aula Magna of the University of Genova.',
        'Oleks Shturmov',
        'Verdi',
        '11:15 - 11:35'),
    Session(
        'Reception',
        'On Monday (April 1st), we hold the welcome reception at the Aula Magna of the University of Genova.',
        'Oleks Shturmov',
        'Verdi',
        '11:40 - 11:50'),
    Session(
        'Reception',
        'On Monday (April 1st), we hold the welcome reception at the Aula Magna of the University of Genova.',
        'Oleks Shturmov',
        'Verdi',
        '12:10 - 12:35'),
    Session(
        'Reception',
        'On Monday (April 1st), we hold the welcome reception at the Aula Magna of the University of Genova.',
        'Oleks Shturmov',
        'Verdi',
        '12:45 - 13:10'),
    Session(
        'Reception',
        'On Monday (April 1st), we hold the welcome reception at the Aula Magna of the University of Genova.',
        'Oleks Shturmov',
        'Verdi',
        '13:00 - 13:20'),
  ];
}

class Question {
  String questionText;
  List questionSubText;
  QuestionType type;
  Question(this.type, this.questionText, this.questionSubText) {
    // Controlo do erro , caso a pergunta seja do tipo multiple choice this.questionSubText
    if (this.type == QuestionType.radioButton) {}
  }
}

class Session {
  String title;
  String description;
  String speaker;
  String room;
  String time;
  //DateTime day;
  Session(this.title, this.description, this.speaker, this.room, this.time);
}

class Conference {
  DateTime startDate;
  DateTime endDate;
  List<Session> sessions;
}
