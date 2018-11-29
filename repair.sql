use songsDB;

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