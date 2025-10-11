/* ЗАДАНИЕ 2 */

/* 1. Название и продолжительность самого длительного трека */
SELECT track_name, track_length AS track_length_in_second
  FROM track
 WHERE track_length = (SELECT MAX(track_length)
 						FROM track);
 						
/* 2. Название треков, продолжительность которых не менее 3,5 минут */
SELECT track_name, ROUND(track_length::DECIMAL/60, 1) AS track_length_in_min
  FROM track
 WHERE track_length >= 3.5 * 60;
 
 /* 3. Названия сборников, вышедших в период с 2006 по 2015 год включительно */
SELECT collection_name
  FROM collection
 WHERE collection_date BETWEEN '2006-01-01' AND '2015-12-31';
 
 /* 4. Исполнители, чьё имя состоит из одного слова */
SELECT artist_name
  FROM artist
 WHERE LENGTH(artist_name) - LENGTH(REPLACE(artist_name, ' ', '')) + 1 = 1;

 
 /* 5. Название треков, которые содержат слово «мой» или «my» */
SELECT track_name
  FROM track
 WHERE track_name ~* '\y(my)\y';
 

/* ЗАДАНИЕ 3 */

/* 1. Количество исполнителей в каждом жанре */
SELECT g.genre_name,
    COUNT(ga.artist_id) AS artist_count
  FROM genre AS g
  LEFT JOIN genre_artist AS ga ON g.genre_id = ga.genre_id
 GROUP BY g.genre_name
 ORDER BY artist_count DESC;

 
/* 2. Количество треков, вошедших в альбомы 1996–2000 годов */
SELECT a.album_name, 
	COUNT(t.album_id) AS track_count
  FROM album AS a 
  LEFT JOIN track AS t ON a.album_id = t.album_id
 WHERE a.release_date BETWEEN '1996-01-01' AND '2000-12-31'
 GROUP BY a.album_name
 ORDER BY track_count DESC;


/* 3. Средняя продолжительность треков по каждому альбому */
SELECT a.album_name,
	ROUND(AVG(t.track_length)::DECIMAL/60, 1) AS average_track_length_in_min
  FROM album AS a
  LEFT JOIN track AS t ON a.album_id = t.album_id
 GROUP BY a.album_name 
 ORDER BY average_track_length_in_min DESC;


/* 4. Все исполнители, которые не выпустили альбомы в 1999 году */
SELECT a.artist_name
  FROM artist AS a
 WHERE a.artist_id NOT IN (
    SELECT aa.artist_id
      FROM artist_album AS aa
      JOIN album AS al ON aa.album_id = al.album_id
     WHERE al.release_date BETWEEN '1999-01-01' AND '1999-12-31'
);

 
/* 5. Названия сборников, в которых присутствует исполнитель Control Denied (выберите его сами) */ 
SELECT DISTINCT c.collection_name
  FROM collection AS c
  JOIN track_collection tc ON c.collection_id = tc.collection_id
  JOIN track t ON tc.track_id = t.track_id
  JOIN artist_album aa ON t.album_id = aa.album_id
  JOIN artist a ON aa.artist_id = a.artist_id
 WHERE a.artist_name = 'Control Denied';


/* ЗАДАНИЕ 4 */

/* 1. Названия альбомов, в которых присутствуют исполнители более чем одного жанра */ 
SELECT a.album_name
  FROM album AS a 
  JOIN artist_album AS aa ON a.album_id = aa.album_id
  JOIN genre_artist AS ga ON aa.artist_id = ga.artist_id
 GROUP BY a.album_name
HAVING COUNT(ga.genre_id) > 1;
  

/* 2. Наименования треков, которые не входят в сборники */ 
SELECT t.track_name
  FROM track AS t
 WHERE t.track_id NOT IN (
  	SELECT track_id
  	  FROM track_collection
  );


/* 3. Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько */ 
SELECT a.artist_name, t.track_length AS min_track_tength_in_sec
  FROM artist AS a
  JOIN artist_album AS aa ON a.artist_id = aa.artist_id
  JOIN track AS t ON aa.album_id = t.album_id
 WHERE t.track_length = (
    SELECT MIN(track_length) 
      FROM track
    );


/* 4. Названия альбомов, содержащих наименьшее количество треков */ 
SELECT a.album_name, COUNT(t.album_id) AS track_count
  FROM album AS a
  JOIN track AS t ON a.album_id = t.album_id
 GROUP BY a.album_name
HAVING COUNT(t.album_id) = (
  	SELECT MIN(track_count)
  	  FROM (
  		  SELECT COUNT(album_id) as track_count
	  	    FROM track
	 	     GROUP BY album_id
  		)
  	)
 ORDER BY a.album_name;