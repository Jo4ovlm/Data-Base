-- ----------------------------------------------------------------------------------------------------------------------------------------
-- EXERCÍCIO 4
-- ----------------------------------------------------------------------------------------------------------------------------------------

SELECT Track.track_name, Track.tempo
FROM trabalho_m1.Artist
INNER JOIN trabalho_m1.Album ON Album.artist_id = Artist.artist_id
INNER JOIN trabalho_m1.Track ON Track.album_id= Album.album_id
INNER JOIN trabalho_m1.Played ON Played.track_id = Track.track_id

WHERE Track.tempo > 180;