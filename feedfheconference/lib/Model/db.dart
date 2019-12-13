// classes auxiliares
import 'package:flutter/cupertino.dart';
import 'dart:math';

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

  if(day < 10 && month < 10)
    return '0$day-0$month-$year';
  else if(day < 10)
    return '0$day-$month-$year';
  else if(month < 10)
    return '$day-0$month-$year';
  else
    return '$day-$month-$year';

}

String timeToString(DateTime d){

  int hour = d.hour;
  int minutes = d.minute;
  if(hour < 10 && minutes < 10){
    return '0$hour:0$minutes';
  }
  else if(hour < 10){
    return '0$hour:$minutes'; 
  }
  else if(minutes < 10){
    return '$hour:0$minutes';
  }
  else
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
enum user_type {Attendee, Speaker, Organizer}

class User{
  int id; //Fixo
  String name; //Fixo
  String userName;
  String email;
  String password;
  user_type userType; //Fixo
  User(this.id, this.name, this.userName,this.email, this.password, this.userType);
}

class Speaker extends User{
  String degree;
  String fieldOfExpertize;
  Speaker(int id, String name, String userName, String email, String password, this.degree, this.fieldOfExpertize) : super(id, name, userName, email, password, user_type.Speaker);
}

class Organizer extends User{
  Organizer(int id, String name, String userName, String email, String password) : super(id, name, userName, email, password, user_type.Organizer);
}

class Attendee extends User{
  Attendee(int id, String name, String userName, String email, String password) : super(id, name, userName, email, password, user_type.Attendee);
}

enum QuestionType { radioButton, checkBox, textBox }

class FormQuestion{
  int id;
  String questionText;

  QuestionType type;
  List questionSubText;

  FormQuestion(this.id, this.type, this.questionText, this.questionSubText);

}

class Response{
  
  int id;
  int questionId;
  int userId;
  QuestionType type;
  var response;

  Response(this.id, this.type, this.response, this.questionId, this.userId);
  
}

class Rate {
  int id;
  double rate;
  int talkId;

  Rate(this.id, this.rate, this.talkId);
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

Attendee attendee = new Attendee(1, 'jose guerra', 'lockdown', 'comander23@live.com.pt', 'password');
Organizer organizer = new Organizer(2, 'Luis Silve', 'lockdown1', 'qualquercoisanaosei@treta.com', '1234');
Speaker speaker1 = new Speaker(3, 'Stefan Monnier', 'lockdown2', 'lollololololl@live.com', 'qwerd',  'Master of rings', 'videogames');
Speaker speaker2 = new Speaker(4 , 'Martim Carvalho', 'lockdown3','lollololololdeddl@live.com', '123456',  'Master of rings', 'videogames');


Response response = new Response(1, QuestionType.textBox, "The speaker was well informed in the matter he was discussing", 1, 2);
Response response1 = new Response(2, QuestionType.textBox, "It was a bit longer than i expected and it started to bore me at the end", 2, 2);
Response response2 = new Response(3, QuestionType.textBox, "I think so", 3, 2);
Response response3 = new Response(4, QuestionType.textBox, "No there wasn't", 4, 2);
Response response4 = new Response(5, QuestionType.textBox, "Try to engage with the public a little more, maybe ask more questions", 5, 2);
Response response5 = new Response(6, QuestionType.textBox, "Yes change the speaker", 6, 2);
Response response6 = new Response(7, QuestionType.radioButton, '5', 7, 2);
Response response7 = new Response(8, QuestionType.checkBox, ['The speaker', 'The content'], 8, 2);

Response response8 = new Response(9, QuestionType.textBox, "", 1, 3);
Response response9 = new Response(10, QuestionType.textBox, "It was a bit longer than i expected and it started to bore me at the end", 2, 3);
Response response10 = new Response(11, QuestionType.textBox, "I think so", 3, 3);
Response response11 = new Response(12, QuestionType.textBox, "No there wasn't", 4, 3);
Response response12 = new Response(13, QuestionType.textBox, "Try to engage with the public a little more, maybe ask more questions", 5, 3);
Response response13 = new Response(14, QuestionType.textBox, "not really", 6, 3);
Response response14 = new Response(15, QuestionType.radioButton, '4', 7, 3);
Response response15 = new Response(16, QuestionType.checkBox, ['The speaker', 'The content'], 8, 3);

Response response16 = new Response(17, QuestionType.textBox, "The speaker was well informed in the matter he was discussing", 1, 1);
Response response17 = new Response(18, QuestionType.textBox, "It was a bit longer than i expected and it started to bore me at the end", 2, 1);
Response response18 = new Response(19, QuestionType.textBox, "I think so", 3, 1);
Response response19 = new Response(20, QuestionType.textBox, "No there wasn't", 4, 1);
Response response20 = new Response(21, QuestionType.textBox, "Try to engage with the public a little more, maybe ask more questions", 5, 1);
Response response21 = new Response(22, QuestionType.textBox, "Notreally", 6, 1);
Response response22 = new Response(23, QuestionType.radioButton, '3', 7, 1);
Response response23 = new Response(24, QuestionType.checkBox, ['The speaker', 'The content'], 8, 1);

Rate rate1 = new Rate(1, 3, 1);
Rate rate2 = new Rate(2, 5, 1);
Rate rate3 = new Rate(3, 4, 1);
Rate rate4 = new Rate(4, 3.5, 1);
Rate rate5 = new Rate(5, 4.5, 1);


List<String> radioButtonoptions = ['1','2','3','4','5'];
List<String> checkBoxOptions = ['The speaker','The content','The space','The ambient','The interaction'];

FormQuestion question1 = new FormQuestion(1, QuestionType.textBox, 'What did you like the most in the session?', List());
//FormQuestion question2 = new FormQuestion(2, QuestionType.textBox, 'What did you like the least in the session?', List());
//FormQuestion question3 = new FormQuestion(3, QuestionType.textBox, 'In your opinion, did the session met its objectives?', List());
//FormQuestion question4 = new FormQuestion(4, QuestionType.textBox, 'Was there enough time for discussion?', List());
//FormQuestion question5 = new FormQuestion(5, QuestionType.textBox,'Tell us some suggestions you may have for future events.', List());
//FormQuestion question6 = new FormQuestion(6, QuestionType.textBox, 'Any final comments?', List());
//FormQuestion question7 = new FormQuestion(7, QuestionType.radioButton, 'Rate your experience.', radioButtonoptions);
//FormQuestion question8 = new FormQuestion(8, QuestionType.checkBox , 'What did you like the most in the session?', checkBoxOptions);

FormTalk form1 = new FormTalk(1, '1974-03-20 00:00:00' , '1974-03-20 00:00:00', [1]);

Talk talk1 = new Talk(1, 1, 'The Lisp of the prophet for the one true editor', 'While the editor war is long gone and '
    'Emacs’s marketshare has undoubtedly shrunk, it has established itself as an important branch in the Lisp family of languages. In this talk, I will look at what gave Emacs Lisp its shape, including what it '
    'took from its siblings and ancestors and what makes it different.',[3, 4], '0000-00-00 09:30:00', '0000-00-00 10:30:00');
Talk talk2 = new Talk(2, 1, 'The NEXT NEXT Lisp of the prophet for the one true editor', 'While the editor war is long gone and '
    'Emacs’s marketshare has undoubtedly shrunk, it has established itself as an important branch in the Lisp family of languages. In this talk, I will look at what gave Emacs Lisp its shape, including what it '
    'took from its siblings and ancestors and what makes it different.',[3], '0000-00-00 10:30:00', '0000-00-00 11:30:00');

Talk talk3 = new Talk(3, 1, 'IDVE: an Integrated Development and Verification Environment for JavaScript',
    '',
    [3, 4], '2019-04-01 09:00:00', '2019-04-01 09:30:00');

Talk talk4 = new Talk(4, 1, 'Draw This Object: A Study of Debugging Representations',
    'Domain-specific debugging visualizations try to provide a view of a runtime object tailored to a specific domain and highlighting its important properties. The research in this area has focused mainly on the technical aspects of the creation of such views so far. However, we still lack answers to questions such as what properties of objects are considered important for these visualizations, whether all objects have an appropriate domain-specific view, or what clues could help us to construct these views fully automatically. In this paper, we describe an exploratory study where the participants were asked to inspect runtime states of objects displayed in a traditional debugger and draw ideal domain-specific views of these objects on paper. We describe interesting observations and findings obtained during this study and a preliminary taxonomy of these visualizations.',
    [3, 4], '2019-04-01 09:30:00', '2019-04-01 10:00:00');

Talk talk5 = new Talk(5, 1, 'Faster Feedback through Lexical Test Prioritization',
    '',
    [3, 4], '2019-04-01 10:00:00', '2019-04-01 10:30:00');

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
    question1
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

   List<Response> responseList = [
    response,
    response1,
    response2,
    response3,
    response4,
    response5,
    response6,
    response7,
    response8,
    response9,
    response10,
    response11,
    response12,
    response13,
    response14,
    response15,
    response16,
    response17,
    response18,
    response19,
    response20,
    response21,
    response22,
    response23,
  ];

   List<Rate> rateList = [
     rate1,
     rate2,
     rate3,
     rate4,
     rate5
   ];
}
Database db = new Database();


// FUNCTIONS TO CHANGE THE DATABASE
int numberDaysOfConference(int conferenceId){

  DateTime begin;
  DateTime end;

   for(int i = 0; i < db.conferenceList.length; i++){
    if(conferenceId == db.conferenceList[i].id){
      begin = db.conferenceList[i].beginDate;
      end = db.conferenceList[i].endDate;
      break;
    }
  }

  Duration difference = end.difference(begin);
  return  (difference.inDays + 1);
}


List<Talk> talkListForASession(int sessionId){

  List<Talk> talkList = new List();
  for(int i = 0; i < db.sessionList.length; i++){
    if(db.sessionList[i].id == sessionId){
      for(int j = 0; j < db.sessionList[i].talkIdList.length; j++){ 
        for(int h = 0; h < db.talkList.length; h++){
          if(db.sessionList[i].talkIdList[j] == db.talkList[h].id){
            talkList.add(db.talkList[h]);
          }
        }
      }
      break;
    }
  }

  talkList.sort((a, b) =>
       (a.beginTime.toString().compareTo(b.beginTime.toString())));

  return talkList;
} 

List<Session> sessionListForAEvent(int eventId){

  List<Session> sessionList = new List();
  Event event = getEventFromId(eventId);

  for(int j = 0; j < event.sessionIdList.length; j++){ 
    for(int h = 0; h < db.sessionList.length; h++){
      if(event.sessionIdList[j] == db.sessionList[h].id){
        sessionList.add(db.sessionList[h]);
      }
    }
  }
  sessionList.sort((a, b) =>
      (a.beginTime.toString().compareTo(b.beginTime.toString())));
    
  printSessionList(sessionList);

  return sessionList;
}

void printSessionList(List <Session> s){

  for(int i = 0; i < s.length; i++){
    print(s[i].beginTime.toString());
  } 

}

Event getEventFromId(int eventId){

  Event event;

  for(int i = 0; i < db.eventList.length; i++){
    if(db.eventList[i].id == eventId){
      event = db.eventList[i];
      break;
    }
  }
  return event;
}


List<String> getSubQuestionText(var questionId) {
  for (int i = 0; i < db.formQuestionList.length; i++) {
    if (db.formQuestionList[i].id == questionId) {
      return db.formQuestionList[i].questionSubText;
    }
  }
}

String getQuestionText(var questionId) {
  for (int i = 0; i < db.formQuestionList.length; i++) {
    if (db.formQuestionList[i].id == questionId) {
      return db.formQuestionList[i].questionText;
    }
  }
}

QuestionType getQuestionType(var questionId) {
  for (int i = 0; i < db.formQuestionList.length; i++) {
    if (db.formQuestionList[i].id == questionId) {
      return db.formQuestionList[i].type;
    }
  }
}

String getUsernameFromId(int personId) {
  String name;

  for (int i = 0; i < db.userList.length; i++) {
    if (db.userList[i].id == personId) {
      name = db.userList[i].userName;
      break;
    }
  }
  return name;
}

String getAnswerPercentageTextBox(int questionId) {
  int numberOfR = numberOfResponses(questionId);
  int numberOfBlankR = numberOfBlankResponses(questionId);
  double percentageTextBox = (numberOfR - numberOfBlankR) / numberOfR;
  percentageTextBox = percentageTextBox * 100;

  return percentageTextBox.toStringAsFixed(2).toString();
}

int numberOfResponses(int questionId) {
  int counter = 0;

  for (int i = 0; i < db.responseList.length; i++) {
    if (db.responseList[i].questionId == questionId) {
      counter++;
    }
  }

  return counter;
}

int numberOfBlankResponses(int questionId) {
  int counter = 0;

  for (int i = 0; i < db.responseList.length; i++) {
    if (db.responseList[i].questionId == questionId) {
      if (db.responseList[i].response == null ||
          db.responseList[i].response == "") counter++;
    }
  }

  return counter;
}

int numberOfFavorableResponses(int questionId, String response) {
  QuestionType type = getQuestionType(questionId);
  int counter = 0;

  if (type == QuestionType.checkBox) {
    for (int i = 0; i < db.responseList.length; i++) {
      for (int j = 0; j < db.responseList[i].response.length; j++) {
        if (db.responseList[i].response[j] == response) {
          counter++;
        }
      }
    }
  } else if (type == QuestionType.radioButton) {
    for (int i = 0; i < db.responseList.length; i++) {
      if (db.responseList[i].response == response) {
        counter++;
      }
    }
  }
  return counter;
}

String questionAnswerPercentage(int questionId, var response) {
  int numberOfResponsesForQuestion = numberOfResponses(questionId);
  int numberOfFavorableResponsesForQuestion =
      numberOfFavorableResponses(questionId, response);
  double percentage =
      numberOfFavorableResponsesForQuestion / numberOfResponsesForQuestion;
  percentage = percentage * 100;
  return percentage.toStringAsFixed(2).toString();
}

int numberOfNotBlankquestionResponses(int questionId) {
  @override
  
  int counter = 0;

  for (int j = 0; j < db.responseList.length; j++) {
    if(db.responseList[j].questionId == questionId) {
      if(db.responseList[j].response != ""){
        counter++;
      }
    }
  }
  return counter;
}

List<Response> questionResponses(int questionId) {
  @override
  List<Response> responsesList = new List();

  for (int j = 0; j < db.responseList.length; j++) {
    if(db.responseList[j].questionId == questionId) {
      responsesList.add(db.responseList[j]);
    }
  }
  return responsesList;
}



int numberOfPeopleSubmittedForm(int formId){

  int counter = 0;

  for(int i = 0; i < db.formList.length; i++){
    if(formId == db.formList[i].id){
      for(int j = 0; j < db.responseList.length; j++){
        if(db.responseList[j].questionId == db.formList[i].listIdFormQuestions[0])
          counter++;
      }
      break;
    }
  }
  return counter;
}


List <String> mostAnsweredQuestions(int formId){

    List<int> numberOFResponsesPerQuestion = new List();
    FormTalk form;
    List<String> mostAnswered = new List();

    for(int i = 0; i < db.formList.length; i++) {
      if(formId == db.formList[i].id) {
        form = db.formList[i];
        for(int j = 0; j < form.listIdFormQuestions.length; j++) {
          numberOFResponsesPerQuestion.add(numberOfNotBlankquestionResponses(form.listIdFormQuestions[j]));
        }
      }
    }

    // print('\n [');
    // for(int i= 0; i < numberOFResponsesPerQuestion.length; i++){
    //   print(numberOFResponsesPerQuestion[i].toString() + ', ');
    // }

    // print(']\n');

    int minNumberOfReponses = numberOFResponsesPerQuestion.reduce(max);
    int questionId;

    for(int i = 0; i < numberOFResponsesPerQuestion.length; i++){
      if(numberOFResponsesPerQuestion[i] == minNumberOfReponses){
        questionId = form.listIdFormQuestions[i];
        mostAnswered.add(getQuestionText(questionId));
      }
    }
    
    return mostAnswered;

}

List <String> leastAnsweredQuestions(int formId){

    List<int> numberOFResponsesPerQuestion = new List();
    FormTalk form;
    List<String> leastAnswered = new List();

    for(int i = 0; i < db.formList.length; i++) {
      if(formId == db.formList[i].id) {
        form = db.formList[i];
        for(int j = 0; j < form.listIdFormQuestions.length; j++) {
          numberOFResponsesPerQuestion.add(numberOfNotBlankquestionResponses(form.listIdFormQuestions[j]));
        }
      }
    }
    // print('Number of question = '+ numberOFResponsesPerQuestion.length.toString());
    //     print('\n [');
    // for(int i= 0; i < numberOFResponsesPerQuestion.length; i++){
    //   print(numberOFResponsesPerQuestion[i].toString() + ', ');
    // }

    // print(']\n');


    int minNumberOfReponses = numberOFResponsesPerQuestion.reduce(min);
    int questionId;
    for(int i = 0; i < numberOFResponsesPerQuestion.length; i++){
      if(numberOFResponsesPerQuestion[i] == minNumberOfReponses){
        questionId = form.listIdFormQuestions[i];
        leastAnswered.add(getQuestionText(questionId));
      }
    }

    return leastAnswered;
}






