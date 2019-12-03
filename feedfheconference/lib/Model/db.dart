// classes auxiliares
class Date{

  int day;
  int month;
  int year;

  Date();
  Date.string(String date){
    var splitDate = date.split("-");
    year = int.parse(splitDate[0]);
    month = int.parse(splitDate[1]);
    day = int.parse(splitDate[2]);
  }

  Date.integers(this.day,  this.month, this.year);

  String dateToString(){
    return '$year-$month-$day';
  }

  String dateToInvertedString(){
    return '$day-$month-$year';
  }
}

class Time{
  int hour;
  int minute;

  Time([this.hour = 0 , this.minute = 0]) {
    //assert(this.hour >= 0 && this.hour < 24);
    //assert(this.minute >= 0 && this.minute < 60);
  }

  Time.string(String time){
    var splitTime = time.split(":");
    hour = int.parse(splitTime[0]);
    minute = int.parse(splitTime[1]);
  }

  String timeToString(){
    return '$hour:$minute';
  }

}
  List<String> options = ['1','2','3','4','5'];

String dateToString(DateTime d){
    
  int year = d.year;
  int month = d.month;
  int day = d.day;

  return '$year-$month-$day';

}

String dateToInvertedString(DateTime d){
    
  int year = d.year;
  int month = d.month;
  int day = d.day;

  return '$day-$month-$year';

}

String timeToString(DateTime d){

  int hour = d.hour;
  int minutes = d.minute;

  return '$hour:$minutes';

}

String dateAndTimeToString(DateTime d){

  int year = d.year;
  int month = d.month;
  int day = d.day;
  int hour = d.hour;
  int minutes = d.minute;

  return '$day-$month-$year $hour:$minutes';
}

class DateAndTime{

  Date date;
  Time time;

  DateAndTime();
  DateAndTime.string(String dateAndTime){
    List<String> aux = dateAndTime.split(" ");

    date = new Date.string(aux[0]);
    time = new Time.string(aux[1]);
  }
}

// classes da database

class User{
  int id;
  String name;
  String userName;
  int age;
  int cellPhoneNumber;
  String email;
  String password;
  User(this.id, this.name, this.userName, this.age, this.cellPhoneNumber, this.email, this.password);
}

class Speaker extends User{
  String degree;
  String fieldOfExpertize;
  Speaker(int id, String name, String userName, int age, int cellPhoneNumber, String email, String password, this.degree, this.fieldOfExpertize) : super( id,name, userName, age, cellPhoneNumber, email, password);
}

class Organizer extends User{
  Organizer(int id, String name, String userName, int age, int cellPhoneNumber, String email, String password,) : super(id, name, userName, age, cellPhoneNumber, email, password);
}

class Attendee extends User{
  Attendee(int id, String name, String userName,  int age, int cellPhoneNumber, String email, String password,) : super(id, name, userName, age, cellPhoneNumber, email, password);
}

enum QuestionType { radioButton, checkBox, textBox }

class FormQuestion{
  int id;
  String questionText;

  QuestionType type;
  List questionSubText;

  FormQuestion(this.id, this.type, this.questionText, this.questionSubText);

}

class FormTalk{

  int id;
  DateTime begin;
  DateTime end;
  List<int> listIdFormQuestions;

  FormTalk(this.id, String begin, String end, this.listIdFormQuestions){
    this.begin = DateTime.parse(begin);
    this.end = DateTime.parse(end);
  }
}


class Talk{

  int id;
  String title;
  String description;
  List<int> speakersId;
  int formId;
  bool isFavorite = false;
  DateTime beginTime;
  DateTime endTime;

  Talk(this.id, this.formId, this.title, this.description, this.speakersId, String beginTime, String endTime){
    this.beginTime= DateTime.parse(beginTime);
    this.endTime = DateTime.parse(endTime);
  }
}

class Session{
  int id;
  String title;
  String chairMan;
  String room;
  DateTime beginTime;
  DateTime endTime;
  List<int> talkIdList;

  Session(this.id, this.title, this.chairMan, this.room, this.talkIdList, String begin, String end){
    this.beginTime= DateTime.parse(begin);
    this.endTime = DateTime.parse(end);
  }
}

class Conference{

  int id;
  String name;
  DateTime beginDate;
  DateTime endDate;
  String place;
  List<int> eventIdList;

  Conference(this.id, this.name, this.place, this.eventIdList,  String beginDate, String endDate)
  {

    this.beginDate = DateTime.parse(beginDate);
    this.endDate = DateTime.parse(endDate);
  
  }

}

class Event{
  int id;
  String acronym;
  String title;
  String description;
  List<int> sessionIdList;
  Event(this.id, this.acronym, this.title, this.description, this.sessionIdList);
}

Attendee attendee = new Attendee(1, 'jose guerra', 'lockdown', 19,  930474148, 'comander23@live.com.pt', 'password');
Organizer organizer = new Organizer(2, 'Luis Silve', 'lockdown1', 35, 913333222, 'qualquercoisanaosei@treta.com', '1234');
Speaker speaker1 = new Speaker(3, 'Stefan Monnier', 'lockdown2', 34, 912211221, 'lollololololl@live.com', 'qwerd',  'Master of rings', 'videogames');
Speaker speaker2 = new Speaker(4 , 'Martim Carvalho', 'lockdown3', 34, 912211221, 'lollololololdeddl@live.com', '123456',  'Master of rings', 'videogames');

Speaker speaker3 = new Speaker(5, 'Christopher Schuster', 'ChristopherSchuster', 40, 912211223, '', '', 'PhD', 'Software Engineering');
Speaker speaker4 = new Speaker(6, 'Cormac Flanagan', 'CormacFlanagan', 41, 912211223, '', '', 'PhD', 'Security');

List<String> radioButtonoptions = ['1','2','3','4','5'];
List<String> checkBoxOptions = ['1','2','3','4','5'];

FormQuestion question1 = new FormQuestion(1, QuestionType.textBox, 'What did you like the most in the session?', List());
FormQuestion question2 = new FormQuestion(2, QuestionType.textBox, 'What did you like the least in the session?', List());
FormQuestion question3 = new FormQuestion(3, QuestionType.textBox, 'In your opinion, did the session met its objectives?', List());
FormQuestion question4 = new FormQuestion(4, QuestionType.textBox, 'Was there enough time for discussion?', List());
FormQuestion question5 = new FormQuestion(5, QuestionType.textBox,'Tell us some suggestions you may have for future events.', List());
FormQuestion question6 = new FormQuestion(6, QuestionType.textBox, 'Any final comments?', List());
FormQuestion question7 = new FormQuestion(7, QuestionType.radioButton, 'Rate your experience.', radioButtonoptions);
FormQuestion question8 = new FormQuestion(8, QuestionType.checkBox , 'What did you like the most in the session?', checkBoxOptions);

FormTalk form1 = new FormTalk(1, '1974-03-20 00:00:00' , '1974-03-20 00:00:00', [2,1, 3, 4, 5, 6, 7, 8]);

Talk talk1 = new Talk(1, 1, 'The Lisp of the prophet for the one true editor', 'While the editor war is long gone and '
    'Emacs’s marketshare has undoubtedly shrunk, it has established itself as an important branch in the Lisp family of languages. In this talk, I will look at what gave Emacs Lisp its shape, including what it '
    'took from its siblings and ancestors and what makes it different.',[3, 4], '0000-00-00 09:30:00', '0000-00-00 10:30:00');
Talk talk2 = new Talk(2, 1, 'The NEXT NEXT Lisp of the prophet for the one true editor', 'While the editor war is long gone and '
    'Emacs’s marketshare has undoubtedly shrunk, it has established itself as an important branch in the Lisp family of languages. In this talk, I will look at what gave Emacs Lisp its shape, including what it '
    'took from its siblings and ancestors and what makes it different.',[3], '0000-00-00 10:30:00', '0000-00-00 11:30:00');

Talk talk3 = new Talk(3, 1, 'IDVE: an Integrated Development and Verification Environment for JavaScript',
    '',
    [5, 6], '2019-04-01 09:00:00', '2019-04-01 09:30:00');

Talk talk4 = new Talk(4, 1, 'Draw This Object: A Study of Debugging Representations',
    'Domain-specific debugging visualizations try to provide a view of a runtime object tailored to a specific domain and highlighting its important properties. The research in this area has focused mainly on the technical aspects of the creation of such views so far. However, we still lack answers to questions such as what properties of objects are considered important for these visualizations, whether all objects have an appropriate domain-specific view, or what clues could help us to construct these views fully automatically. In this paper, we describe an exploratory study where the participants were asked to inspect runtime states of objects displayed in a traditional debugger and draw ideal domain-specific views of these objects on paper. We describe interesting observations and findings obtained during this study and a preliminary taxonomy of these visualizations.',
    [5, 6], '2019-04-01 09:30:00', '2019-04-01 10:00:00');

Talk talk5 = new Talk(5, 1, 'Faster Feedback through Lexical Test Prioritization',
    '',
    [5, 6], '2019-04-01 10:00:00', '2019-04-01 10:30:00');

Session session1 = new Session(1, 'session 1', null, 'Paganini', [1, 2, 1, 2], '2019-01-02 09:30:00', '2019-01-02 11:30:00');
Session session2 = new Session(2 ,'session 2', null, 'Michelangelo', [2], '2019-01-03 09:30:00', '2019-01-03 11:30:00');

Session session3 = new Session(3, 'session 3', null, 'Paganini', [1, 2, 1, 2], '2019-01-02 10:30:00', '2019-01-02 11:30:00');
Session session4 = new Session(4 ,'session 4', null, 'Michelangelo', [2], '2019-11-15 09:30:00', '2019-11-15 11:30:00');


Session session5 = new Session(5, 'session 5', null, 'Paganini', [1, 1, 1, 2], '2019-11-15 09:30:00', '2019-11-15 11:30:00');
Session session6 = new Session(6 ,'session 6', null, 'Michelangelo', [2], '2019-11-15 09:30:00', '2019-11-15 11:30:00');

Session session7 = new Session(7, 'PX/19 #1', 'Jens Lincke' ,'Michelangelo', [3, 4, 5], '2019-04-01 09:00:00', '2019-04-01 10:30:00');
Session session8 = new Session(8, 'PX/19 #2', 'Tobias Pape' ,'Michelangelo', [3], '2019-04-01 11:00:00', '2019-04-01 12:30:00');
Session session9 = new Session(9, 'PX/19 #3', 'Ademar Aguiar' ,'Michelangelo', [3], '2019-04-01 14:00:00', '2019-04-01 15:30:00');

Event event1 = new Event(1 ,'ELS 2019 ', 'European Lisp Symposium', 'The purpose of the European '
    'Lisp Symposium is to provide a forum for the discussion and dissemination of '
    'all aspects of design, implementation and application of any of the Lisp and '
    'Lisp-inspired dialects, including Common Lisp, Scheme, Emacs Lisp, AutoLisp, '
    'ISLISP, Dylan, Clojure, ACL2, ECMAScript, Racket, SKILL, Hop and so on. We '
    'encourage everyone interested in Lisp to participate.', [1, 3, 2]);

Event event2 = new Event(2 ,'LOL 2019', 'Loletas', 'The purpose of the European '
    'Lisp Symposium is to provide a forum for the discussion and dissemination of '
    'all aspects of design, implementation and application of any of the Lisp and '
    'Lisp-inspired dialects, including Common Lisp, Scheme, Emacs Lisp, AutoLisp, '
    'ISLISP, Dylan, Clojure, ACL2, ECMAScript, Racket, SKILL, Hop and so on. We '
    'encourage everyone interested in Lisp to participate.', [1, 2]);

Event event3 = new Event(3 , 'ICW 2019', 'Interconnecting Code Workshop' , 'The purpose of the European '
    'Lisp Symposium is to provide a forum for the discussion and dissemination of '
    'all aspects of design, implementation and application of any of the Lisp and '
    'Lisp-inspired dialects, including Common Lisp, Scheme, Emacs Lisp, AutoLisp, '
    'ISLISP, Dylan, Clojure, ACL2, ECMAScript, Racket, SKILL, Hop and so on. We '
    'encourage everyone interested in Lisp to participate.', [1, 2]);


Event event4 = new Event(4, 'PX/19', 'Programming Experience Workshop',
    'Imagine a software development task: some sort of requirements and perhaps a platform and programming language. A group of developers head into a vast workroom. As they design, debate and program they discover they need learn more about the domain and the nature of potential solutions–they are exploring via programming.\nThe Programming Experience (PX) Workshop is about what happens in that room when programmers sit down in front of computers and produce code, especially in an exploratory way. Do they create text that is transformed into running behavior (the old way), or do they operate on behavior directly (“liveness”); are they exploring the live domain to understand the true nature of the requirements; are they like authors creating new worlds; does visualization matter; is the experience immediate, immersive, vivid and continuous; do fluency, literacy, and learning matter; do they build tools, meta-tools; are they creating languages to express new concepts quickly and easily; and curiously, is joy relevant to the experience?',
    [7, 8, 9]);

Conference programming2019 = new Conference(1, 'Programming 2019', 'Genoa, Italy', [4], '2019-04-01 00:00:00', '2019-04-04 00:00:00');
Conference programming2020 = new Conference(4, 'Programming 2020', 'Porto, Portugal', [4], '2020-05-23 00:00:00', '2020-05-26 00:00:00');
Conference sinf2019 = new Conference(2, 'Sinf 2019', 'Porto, Portugal', [1], '2019-07-01 00:00:00', '2019-07-04 00:00:00');
Conference webSummit2019 = new Conference(3, 'webSummit 2019', 'Lisboa, Portugal', [1], '2019-01-01 00:00:00', '2019-01-03 00:00:00');

class Database {

  List<Conference> conferenceList = [
    programming2019,
    sinf2019,
    webSummit2019,
    programming2020
  ];

  List<Event> eventList = [
    event1,
    event2,
    event3,
    event4
  ];

  List<Session> sessionList = [
    session1,
    session2,
    session3,
    session4,
    session5, 
    session6,
    session7,
    session8,
    session9
  ];

  List<Talk> talkList = [
    talk1,
    talk2,
    talk3,
    talk4,
    talk5
  ];

  List<FormTalk> formList = [
    form1
  ];

  List<FormQuestion> formQuestionList = [
    question1,
    question2,
    question3,
    question4,
    question5,
    question6,
    question7,
    question8
  ];

  List<User> userList = [
    attendee,
    organizer,
    speaker1,
    speaker2
  ];
  List<Attendee> attendeeList = [
    attendee
  ];
  List<Organizer> organizerList = [
    organizer
  ];
  List<Speaker> speakerList = [
    speaker1,
    speaker2
  ];
}
Database db = new Database();
