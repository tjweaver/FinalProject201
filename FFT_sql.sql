DROP DATABASE IF EXISTS project;
CREATE DATABASE project;
USE project;

CREATE TABLE song_details(
	songID int(10) primary key not null auto_increment,
    title varchar(40) not null,
    artist varchar(40) not null,
    album varchar(40) not null
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
	foreign key fk1(songID) references song_details(songID)    
);