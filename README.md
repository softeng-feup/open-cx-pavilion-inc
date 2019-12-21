# openCX-pavilion-inc 

## **Business modeling**
  
* **[Product Vision]()**

    **What are we doing?**

    We are developing a multiplatform mobile app that allows users to easily give feedback about a conference or event by using their smartphone. The feedback will be given to the speaker, allowing him to get real time statistics about the atendees' opinion, attendance and rating of the event. Furthermore, atendees will be able to leave questions for the speaker to answer later. 


    **Why are we doing it?**

    We are developing this project in the context of ESOF.


    **What's it gonna bring of good to the world?**

    We intend to give atendees an easy and practical way of giving their opinion and asking questions about an event. This allows them to have a meaningful impact on the event.
    For the speakers, we want to allow them to receive reviews about their presentation(s) which can be helpful to improve. Besides that, the speakers will also be able to easily get statistics about attendance rates, and reply to questions that the atendees leave for him about the conference.


*   **[Elevator Pitch]()**


    FeedTheConference is an innovative way of getting feedback from participants in conferences, be it directed towards other attendees, speakers or the organization itself.
Unlike other forms of getting feedback, this app allows the organization to get the feedback in real time and automates its processing, making it easy to analyze.

## **Requirements**
 * **[Use Case Diagram]()**

 
    ![](https://i.imgur.com/lHo0d49.jpg)


    There are three types of users in our app the attendes, the speakers and the organizers. The attendees are people who intend to go to the conference to watch and hear different talks and attend workshops. The speakers are persons who are at least presenting one talk from one session of the conference. Finaly the organizers are the ones responsible for assebling and managing the conference.
* As a **attendee** the main feature is to give feedback either through a form that was created by the speakers of a talk or by giving a general rating to the talk.
* As a **speaker** the main feature for our app is that we let them create and edit a form that people are able to submit as way of feedback.
* As a **organizer** the principal feature is to let them see all the answers that were given by the attendees on the forms, so that he may have a better understanding how the conference is going and how they would need to improve.

* **Obtain general information about previous and future information about events, sessions and talks:** give to the atendees the possibility to see informations about the events, sessions and talks like description, speakers, start time, end time and room where the talks take place.
* **Give feedback for previous talks:** give the atendees the possibility to give feedback about talks that they saw, by answering a form about the respective talk and give a genreal rate from 1 to 5 stars. 
* **See the conference in a organized fashion, divided into events each themselves divided into sessions and this ones into talks:** the users can see the diferent sessions and events that will happen by chronological order and divided by days. They can also see the talks of the respectives sessions by chronological order.
* **See all the feedback that was given for the conference in an organized way:** give the organizer the possibility to see all the answers of the forms about the talks and the ratings of the talks.
* **Create and edit the main component of feedback for the talk (form):** speakers can create and edit a form with different questions about the talks they presented so atendees could answer.



 * **[User stories]()**

    Our user stories are all described and represented in trello (our task management tool), they all have the tag "User story" to identify them and they are all under three seperate collumns with the name: to do(user stories), in progress(user stories) and done(user stories). Also associated with each user story we have the person/persons who contributed to the making and the implementation of that particular user story.

    Link to trello: 
    https://trello.com/b/ueaVMHB0/esof-project
    
    ![](https://i.imgur.com/7y2Yjt4.png)




 *  **[Domain model]()**
   ![](https://i.imgur.com/kCcY4YB.png)



 * **[UI mockups]()**
    
    The ui mockups were a very important way for us to imagine how the app would look and what features would make more sense to implement in a real app, without having to implement any real line of code.

    The ui mockups are represented in association with some user stories in https://trello.com/b/ueaVMHB0/esof-project .
    
    ![](https://i.imgur.com/UtwnuAG.png)


    All the ui mockups were done using figma and can be found there aswell: https://www.figma.com/file/QZcdD0hwdQL0yfPZDL7evU/Untitled .

 * **[Acceptance tests]()**

    Acceptance testing is very usefull to determine if the requirements of our specification were met or not. That being said we would like to write acceptance tests to the main features of our app. The main features of our app are all arround giving feedback since that's the main objective. We plan on using gherkin to test each main feature of our app. Gherkin is  is a domain specific language which helps you to describe business behavior without the need to go into detail of implementation. This text acts as documentation and skeleton of your automated tests. Gherkin uses, mainly, the folling syntax:

        Feature: Title of the Scenario
        Given [Preconditions or Initial Context]
        When [Event or Trigger]
        Then [Expected output]
  
    **Some tags used in gherkin**

    **Feature** -
    The file should have extension .feature and each feature file should have only one feature. The feature keyword being with the Feature: and after that add, a space and name of the feature will be written.

    **Given** -
    The use of Given keyword is to put the system in a familiar state before the user starts interacting with the system. However, you can omit writing user interactions in Given steps if Given in the "Precondition" step.

    **When** -
    When the step is to define action performed by the user.

    **Then** - 
    The use of 'then' keyword is to see the outcome after the action in when step. However, you can only verify noticeable changes.




## **Architecture and Design**


Our app follows the MVC (Model-View-Controller) architectural pattern, because of that, in our application you will find these three fundamental parts:

* Data (Model)
* An interface to view and modify the data (View)
* Operations that can be performed on the data         (Controller)
 
The MVC pattern, in a nutshell, is this:

The **model** represents the data, and does nothing else. The model does NOT depend on the controller or the view.

The **view** displays the model data, and sends user actions (e.g. button clicks) to the controller. The view is independent of both the model and the controller.
 

The **controller** provides model data to the view, and interprets user actions such as button clicks. The controller depends on the view and the model.
    
In our app we use the model to store the information that is necessary, information about the conference and it's events, sessions and talks. In order to save this information in a organized way we create classes also present in the model package.
    The view component is where all the screens of the app are, all of the visual part of the app is represent there.
    The controller is home to a number of functions that help connect the model to the view component. If the view component needs information then it rellies on the controller to be able to get that information from the model component.
    
  * **[Logical architecture]()**
    
    Like we said previous, our development of the app followed the MVC model so a lot of the logical architecture of our work is centered around that, as this next package diagram demostrates:
    
    ![](https://i.imgur.com/QvBGErg.jpg)





  * **[Physical architecture]()**
    
    The main components in the physical architecture of our app where the devices we use to open the app and interact with it and the database.
    
    We used flutter as a framework because it seemed like a good option considering what we were planning on doing and because we weren't that experienced progamming mobile apps. Besides that there are aspects in which flutter seemed better than Reactnative (the other option that was presented to us), such as:
    1.    Flutter overcomes the traditional limitations of cross-platform approaches.
        
    2.    Frontend & Backend with a single code
        
    3.    There is an extensive catalog of open source packages.
    4.    It’s a powerful design experience out of the box.
    5.    Flutter has support for a variety of IDEs.
    6.    Continuous Support from the Flutter team & Flutter Community. And many other.
    
    ![](https://i.imgur.com/unLCh8G.jpg)

  
  

  * **[Prototype]()**

    The prototype was mostly a way for us to test technologies we were unfamiliar with, namely flutter.
    
    Although the design of the application is very far from its final state, we were able to effectively demonstrate the first and main user story: as a participant, being able to answer a form as a way to give their opinion.
    
    The form is still in its early stages, as the user can only answer questions in the form of text.
    
    We also experimented different widgets on the  homepage and we were able to show two lists on two different tabs and switch between them by swiping to the side.

    ![](https://i.imgur.com/gtSZYjZ.png)


## **Test**

 * **[Test plan]()**
    
    The tool to test the features is **gherkin** as was described previously in the **Acceptance tests** category in the **Requirements** section of this report. To use gherkin in flutter we used the package flutter_gherkin.  
    
    The main list of features to be tested and gherkin text: 
    
    **1. As a speaker of the conference create/modify the form for your talk**
    
        Feature : As a speaker of the conference create/modify the form for your talk
        Scenario: looking at the talk page
        Given that iam the speaker of that talk, the talk page has button to access the create/modify form page 
        When I press the button 
        Then it should lead me into the create/modify form page
    
    **2. As a attendee of the conference fill out the form of a talk**
    
        Feature : As a speaker of the conference create/modify the form for your talk
        Scenario: looking at the talk page
        Given that iam the speaker of that talk, the talk page has button to access the create/modify form page 
        When I press the button
        Then it should lead me into the create/modify form page
    
    **3. As a attendee of the conference give a rating  to a talk**
    
        Feature : As a speaker of the conference create/modify the form for your talk
        Scenario: looking at the talk page
        Given that iam the speaker of that talk, the talk page has button to access the create/modify form page 
        When I press the button
        Then it should lead me into the create/modify form page
    
    **4. As a user of the app see the conference page divided into days**
Scenario: checking the daily schedules
Given the conference has 4 days
When I go into the main menu
Then it should be presented to me 4 different schedules


        Feature : As a speaker of the conference create/modify the form for your talk
        Scenario: checking the conference page 
        Given the conference has "X" number of days
        When i go into the conference page
        Then it should be presented to me with X number of tabs, each tab representing a specific day for that conference
    
    
    **5. As a user of the app see a day of a conference divided into 
    sessions**
              
        Feature : As a speaker of the conference create/modify the form for your talk
        Scenario: looking at the talk page
        Given that iam the speaker of that talk, the talk page has button to access the create/modify form page 
        When I press the button
        Then it should lead me into the create/modify form page
    
    **6. As a user of the app see a session divided into talks**
    
        Feature : As a speaker of the conference create/modify the form for your talk
        Scenario: looking at the talk page
        Given that iam the speaker of that talk, the talk page has button to access the create/modify form page 
        When I press the button
        Then it should lead me into the create/modify form page
    
    **7. As a user of the app add a talk to the favourites page**
    
        Feature : As a speaker of the conference create/modify the form for your talk
        Scenario: looking at the talk page
        Given that iam the speaker of that talk, the talk page has button to access the create/modify form page 
        When I press the button
        Then it should lead me into the create/modify form page
 



  * **[Test cases specifications automated]()**: 


      
    

## **Project management**
    
* **[Configuration and change management]()**
     
     
     Our team, throughout the development of the project, used github as our software development version control tool, because of that we adopted the use of features and aspects from the Github Flow that were very usefull to us:

    * Use of branches to implement different features of our app simultaneously
    * Controlled merge of branches to the master branch to unite all of the features we were doing separately
 
  
* **[Tasks management tool]()**
   
   The management of the project was done mainly using trello. Trello is a **free** collaboration tool that organizes your projects into boards. In one glance, Trello tells you what's being worked on, who's working on what, and where something is in a process.  Our trello page can be found at: https://trello.com/b/ueaVMHB0/esof-project.
      
    Here's an image of our trello:
    
   ![](https://i.imgur.com/inTEvDO.jpg)

   

 
   We have three collumns dedicated to user stories, three collumns dedicated to the report and one collumn with usefull link related to flutter and other topics. We have for the user stories and report one collumn "to do", one collum "in progress" and one collum "done". The names of each collum are pretty representative of the purpose they are meant to have. 
   
   
  
## **Team members names**

César Nogueira up201706828

João Pedro Lírio up201705254

José Guerra up201706421

José Pedro Baptista up201705255



