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

  List<String> options = ['1','2','3','4','5'];
  
  //This was from testing branch:
  
  //class Database {
  //List<Question> questions = [
    //Question(QuestionType.textBox, 'What did you like the most in the session?', null),
    //Question(QuestionType.textBox, 'What did you like the least in the session?', null),
    //Question(QuestionType.textBox, 'In your opinion, did the session met its objectives?', null),
    //Question(QuestionType.textBox, 'Was there enough time for discussion?', null),
    //Question(QuestionType.textBox,'Tell us some suggestions you may have for future events.', null),
    //Question(QuestionType.textBox, 'Any final comments?', null),
    //Question(QuestionType.radioButton, 'Rate your experience.', options),
    //Question(QuestionType.checkBox, 'Choose numbers.', options)
  //];

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
  String UserName;
  int age;
  int cellPhoneNumber;
  String email;
  String password;
  User(this.id, this.name, this.UserName, this.age, this.cellPhoneNumber, this.email, this.password);
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
  DateAndTime begin;
  DateAndTime end;
  List<int> listIdFormQuestions;

  FormTalk(int id, String begin, String end, this.listIdFormQuestions){
    this.begin = DateAndTime.string(begin);
    this.end = DateAndTime.string(end);

  }
}


class Talk{
  int id;
  String title;
  String description;
  List<int> speakersId;
  int formId;
  Time beginTime;
  Time endTime;

  Talk(this.id, this.formId, this.title, this.description, this.speakersId, String beginTime, String endTime){
    this.beginTime= Time.string(beginTime);
    this.endTime = Time.string(endTime);
  }
}

class Session{
  int id;
  String title;
  String chairMan;
  String room;
  DateAndTime beginTime;
  DateAndTime endTime;
  List<int> talkIdList;

  Session(this.id, this.title, this.chairMan, this.room, this.talkIdList, String begin, String end){
    this.beginTime= DateAndTime.string(begin);
    this.endTime = DateAndTime.string(end);
  }
}

class Conference{
  int id;
  String name;
  Date beginDate;
  Date endDate;
  String place;
  List<int> eventIdList;

  Conference(this.id, this.name, this.place, this.eventIdList,  String beginDate, String endDate){
    this.beginDate = Date.string(beginDate);
    this.endDate = Date.string(endDate);
  }
}

class Event{
  int id;
  String title;
  String description;
  List<int> sessionIdList;
  Event(this.id, this.title, this.description, this.sessionIdList);
}

Attendee attendee = new Attendee(1, 'jose guerra', 'lockdown', 19,  930474148, 'comander23@live.com.pt', 'password');
Organizer organizer = new Organizer(2, 'Luis Silve', 'lockdown1', 35, 913333222, 'qualquercoisanaosei@treta.com', '1234');
Speaker speaker1 = new Speaker(3, 'Stefan Monnier', 'lockdown2', 34, 912211221, 'lollololololl@live.com', 'qwerd',  'Master of rings', 'videogames');
Speaker speaker2 = new Speaker(4 , 'Martim Carvalho', 'lockdown3', 34, 912211221, 'lollololololdeddl@live.com', '123456',  'Master of rings', 'videogames');

List<String> radioButtonoptions = ['1','2','3','4','5'];
List<String> checkBoxOptions = ['1','2','3','4','5'];

FormQuestion question1 = new FormQuestion(1, QuestionType.textBox, 'What did you like the most in the session?', null);
FormQuestion question2 = new FormQuestion(2, QuestionType.textBox, 'What did you like the least in the session?', null);
FormQuestion question3 = new FormQuestion(3, QuestionType.textBox, 'In your opinion, did the session met its objectives?', null);
FormQuestion question4 = new FormQuestion(4, QuestionType.textBox, 'Was there enough time for discussion?', null);
FormQuestion question5 = new FormQuestion(5, QuestionType.textBox,'Tell us some suggestions you may have for future events.', null);
FormQuestion question6 = new FormQuestion(6, QuestionType.textBox, 'Any final comments?', null);
FormQuestion question7 = new FormQuestion(7, QuestionType.radioButton, 'Rate your experience.', radioButtonoptions);
FormQuestion question8 = new FormQuestion(8, QuestionType.checkBox , 'What did you like the most in the session?', checkBoxOptions);

FormTalk form1 = new FormTalk(1, '2019-11-15 9:00' , '2019-11-20 10:30', [1, 2, 3, 4, 5, 6, 7, 8]);

Talk talk1 = new Talk(1, 1, 'The Lisp of the prophet for the one true editor', 'While the editor war is long gone and '
    'Emacs’s marketshare has undoubtedly shrunk, it has established itself as an important branch in the Lisp family of languages. In this talk, I will look at what gave Emacs Lisp its shape, including what it '
    'took from its siblings and ancestors and what makes it different.',[3, 4], '09:30', '10:30');
Talk talk2 = new Talk(2, 1, 'The NEXT NEXT Lisp of the prophet for the one true editor', 'While the editor war is long gone and '
    'Emacs’s marketshare has undoubtedly shrunk, it has established itself as an important branch in the Lisp family of languages. In this talk, I will look at what gave Emacs Lisp its shape, including what it '
    'took from its siblings and ancestors and what makes it different.',[3], '10:30', '11:30');

Session session1 = new Session(1, 'session 1', null, 'Paganini', [1, 1, 1, 2], '2019-11-15 9:30', '2019-11-15 11:30');
Session session2 = new Session(2 ,'session 2', null, 'Michelangelo', [2], '2019-11-15 9:30', '2019-11-15 11:30');

Event event1 = new Event(1 ,'ELS 2019 ', 'The purpose of the European '
    'Lisp Symposium is to provide a forum for the discussion and dissemination of '
    'all aspects of design, implementation and application of any of the Lisp and '
    'Lisp-inspired dialects, including Common Lisp, Scheme, Emacs Lisp, AutoLisp, '
    'ISLISP, Dylan, Clojure, ACL2, ECMAScript, Racket, SKILL, Hop and so on. We '
    'encourage everyone interested in Lisp to participate.', [1, 2]);

Event event2 = new Event(2 ,'LOL 2019 ', 'The purpose of the European '
    'Lisp Symposium is to provide a forum for the discussion and dissemination of '
    'all aspects of design, implementation and application of any of the Lisp and '
    'Lisp-inspired dialects, including Common Lisp, Scheme, Emacs Lisp, AutoLisp, '
    'ISLISP, Dylan, Clojure, ACL2, ECMAScript, Racket, SKILL, Hop and so on. We '
    'encourage everyone interested in Lisp to participate.', [1, 2]);

Conference programming2019 = new Conference(1, 'Programming 2019', 'Genoa, Italy', [1,2], '2019-05-1', '2019-06-1');
Conference sinf2019 = new Conference(2, 'Sinf 2019', 'Genoa, Italy', [1], '2019-07-1', '2019-08-1');
Conference webSummit2019 = new Conference(3, 'webSummit 2019', 'Genoa, Italy', [1], '2019-01-1', '2019-03-1');


class Database {

  List<Conference> conferenceList = [
    programming2019,
    sinf2019,
    webSummit2019
  ];

  List<Event> eventList = [
    event1,
    event2
  ];

  List<Session> sessionList = [
    session1,
    session2
  ];

  List<Talk> talkList = [
    talk1,
    talk2
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
