-- ----------------------------------------------------------------------------------------------------------------------------------------
-- EXERCÍCIO 3
-- ----------------------------------------------------------------------------------------------------------------------------------------
use trabalho_m1;

-- drop table if exists Artist, Album, Track, Played -- (para mais de uma tabela, a sintaxe padrao é drop table <tabela>

create table Artist(
    artist_id int primary key,
    artist_name varchar(30)
);

create table Album(
    album_id int primary key,
    album_name varchar(30),
    artist_id int, 
    foreign key (artist_id) references Artist(artist_id)  -- Complies
);

create table Track(
    track_id int primary key,
    track_name varchar(30),
    tempo int, -- seria o ''time'', mas nao da pra usar
    album_id int,
    foreign key (album_id) references Album(album_id) -- Contains
);

create table Played(
    played int primary key auto_increment,
    track_id int,
    foreign key (track_id) references Track(track_id) -- WasPlayedAt
);

-- Criação de dados ----------------------------------------------------------------------------------------------------------------------
insert into Artist (artist_id, artist_name)
values(12345, "joao poggers"),
	  (54321, "oaoj sreggop");

insert into Album(album_id, album_name, artist_id)
values(1234567890, "album legal", 12345),
	  (0123456789, "mubla  lagel", 54321);

insert into Track (track_id, track_name, tempo, album_id)
values(1,"musica curta", 90, 1234567890),
	  (2,"musica media", 181, 1234567890),
      (3,"musica linga", 360, 1234567890),
      (4,"musica na risca", 180, 1234567890),
      (5,"musica massa", 200, 0123456789),
	  (6,"musica rapida", 30, 0123456789),
      (7,"musica lenta", 500, 0123456789),
      (8,"musica speedrun", 1 ,0123456789);

insert into Played (track_id)
values(1),
	  (2),
      (3),
      (4),
      (5),
      (6),
      (7),
      (8);