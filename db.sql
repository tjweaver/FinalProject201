DROP DATABASE IF EXISTS songsDB;
CREATE DATABASE songsDB;

USE songsDB;
CREATE TABLE Songs (
	songID INT(11) PRIMARY KEY AUTO_INCREMENT,
	filePath VARCHAR(50) NOT NULL,
    imageFilePath VARCHAR(50) NOT NULL,
    artist VARCHAR(20) NOT NULL,
    album VARCHAR(20) NOT NULL,
    songName VARCHAR(20) NOT NULL,
    yearofRelease INT(4) NOT NULL,
    genre VARCHAR(20) NOT NULL
);

Create table LUT(
	playlistID int(10) primary key not null auto_increment,
    playlistName varchar(100) not null,
    songName varchar(100) not null
);

CREATE TABLE Users (
	userID INT(11) PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(20) NOT NULL,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    passhash VARCHAR(20) NOT NULL,
    salt VARCHAR(20) NOT NULL
);

CREATE TABLE Playlists (
	playlistID INT(11) PRIMARY KEY AUTO_INCREMENT,
	userID INT(11) NOT NULL,
    songID INT(11) NOT NULL,
    playlistName VARCHAR(30) NOT NULL,
    FOREIGN KEY fk1(userID) REFERENCES Users(userID),
    FOREIGN KEY fk2(songID) REFERENCES Songs(songID)
);


CREATE TABLE Ratings (
	ratingID INT(11) PRIMARY KEY AUTO_INCREMENT,
    userID INT(11) NOT NULL,
    songID INT(11) NOT NULL,
    rating   INT(2) NOT NULL,
    FOREIGN KEY fk3(userID) REFERENCES Users(userID),
    FOREIGN KEY fk4(songID) REFERENCES Songs(songID)
);

CREATE TABLE NewPlaylists(
	playlistID INT(11) NOT NULL,
	userID INT(11) NOT NULL,
    songID INT(11) NOT NULL,
    playlistName VARCHAR(30) NOT NULL,
    FOREIGN KEY fk9(userID) REFERENCES Users(userID),
    FOREIGN KEY fk10(songID) REFERENCES Songs(songID)
);

CREATE TABLE Lookup(
	songID INT(11),
    playlistID INT(11),
    FOREIGN KEY fk5(songID) REFERENCES Songs(songID)
);

CREATE TABLE frames(
	frame_ID double primary key not null auto_increment,
    songID int(10) not null,
    co1 double not null,
    co2 double not null,
    co3 double not null,
    co4 double not null,
    co5 double not null,
    co6 double not null,
    co7 double not null,
    co8 double not null,
    co9 double not null,
    co10 double not null,
    co11 double not null,
    co12 double not null,
	foreign key fk5(songID) references Songs(songID)    
);