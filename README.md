# FinalProject201

for the music server I setup a subsonic server. Here is the url for the server and login details below:
jmoseaol.subsonic.org
username: admin
password: GOLF1234@
http://www.subsonic.org/pages/api.jsp
Github for the iSub app which has the all the iOS Music Streaming
https://github.com/einsteinx2/isub3

Readme

Song analysis:
Our project at its current state is divided into the front and back end parts working but not connected yet. In order to run the code you must unzip the entire music library and run the SongAnalyzer.analyze() method on the entire library in order to populate the database of the MFC coefficients. The runtime of this function on the whole library which is necessary will take approximately 2 hours but after that it will never need to be run again. Song analysis is very time consuming and complex so this 2 hours is not surprising. Then also please run the Playlist builder method to build all the necessary playlists and populate the Look up table.
	The front end app works well and the backend song analysis works. the last thing needed is to connect these two portions over a server like heroku and have a full functioning app.
	
Database:
db.java contains a DatabaseConnector object which abstracts much of the database away from the rest of the backend so that a POJO can be used to read, write and update data in our database. There are 5 tables; Users, Songs, Playlists, Ratings and the Frames table. Frames is explained in the paragraph above, and the rest of the tables are self explanatory. There is a Constants class which is used to store the hard-coded SQL queries and driver information in an organized manner. Lastly, there is a DatabaseObjects class which essentially implements all the tables as Java Objects with each column representing a member variable in the class. The DatabaseConnector object uses the queries to generate prepared statements and convert the results into Java Objects using the DatabaseObjects classes.
In order to run this code, change the driver and authentication string in the Constants.java file to match your schema, username, and password for your DB on your local machine. Running db.sql will generate the entire schema which can then be populated with the analyze function and by having users interact with the app. 
The only bug right now is that the authentication is working, and I've tried a variety of ways to essentially "login" but none of them are working yet. The code just returns no results.

Servlets:
The servlets in our code mainly act as an intermediary between the database and the user. The main role of the servlets are to manage authentication and non-authenticated requests and to parse user requests and send them to the database abstraction. The servlets will receive JSON request bodies and respond with JSON. The authentication is done by checking the password associated with the username that was submitted with the password from the front end as middleware for autheticated endpoints, otherwise no checks are done.

Front-End:
For the front end the provided LoginViewController is completed. The rest of the main views are Explore, Search, and Profile. The general layout code is complete and awaiting the integration with the backend. Once the ExploreViewController is complete and the multithreading works, it can be dropped into the main Xcode project. SearchViewController is also mostly finished, SearchResultsViewController needs the most work as it relies primarily on the connection to the backend. Music streaming via MusicStreamViewController is in progress.

Multi-threading:
The multi-threading idea in out project is implemented by a feed page in the app. The feed will update and send the music playing activity of all registered users to the feed page of all users. Therefore server have to storing in the music playing behaviors of users and send it to the feed page simultaneously, which is done by multi-threading.
