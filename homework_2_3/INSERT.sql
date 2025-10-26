INSERT INTO artist(artist_name)
VALUES 
    ('Control Denied'),  	--1
    ('Children Of Bodom'),	--2
    ('Dream Theater'),		--3
    ('Helloween'),			--4
    ('Tool')				--5
;

INSERT INTO genre(genre_name)
VALUES 
    ('Alternative Rock'),	--1
    ('Power Metal'),		--2
    ('Heavy Metal'),		--3
    ('Melodic Death Metal'),--4
    ('Progressive Metal')	--5
;

INSERT INTO album(album_name, release_date)
VALUES 
    ('The Fragile Art Of Existence', '1999-10-19'), --1
    ('Hatebreeder', '1999-03-26'), 					--2  
    ('Train Of Thought', '2003-11-11'),				--3
    ('Master Of The Rings', '1994-05-31'),   		--4
    ('AEnima', '1996-06-12')						--5
;

INSERT INTO track(track_name, track_length, album_id)
VALUES 
    ('Consumed', 445, 1),  						--1
    ('Breaking the Broken', 340, 1), 			--2
    ('Expect the Unexpected', 436, 1), 			--3
    ('What If...', 269, 1),						--4
    ('When the Link Becomes Missin', 315, 1),  	--5
    ('Believe', 369, 1), 						--6
    ('Cut Down', 290, 1), 						--7
    ('The Fragile Art of Existence', 578, 1), 	--8
    ('Warheart', 247, 2), 						--9
    ('Silent night, Bodom night', 192, 2), 		--10
    ('Hatebreeder', 260, 2), 					--11
    ('Bed of Razor', 246, 2), 					--12
    ('Towards dead end', 293, 2), 				--13
    ('Black widow', 238, 2), 					--14
    ('Wrath within', 213, 2), 					--15
    ('Children of Bodom', 314, 2), 				--16
    ('Downfall', 293, 2),  						--17
    ('As I Am', 467, 3), 						--18
    ('This Dying Soul', 684, 3), 				--19
    ('Endless Sacrifice', 683, 3), 				--20
    ('Honor Thy Father', 611, 3), 				--21
    ('Vacant', 177, 3), 						--22
    ('Stream of Consciousness', 676, 3), 		--23
    ('In the Name of God', 854, 3), 			--24
    ('Take Away My Pain', 363, 3), 				--25
    ('Grapowski Malmsuite', 394, 4), 			--26
    ('Cold Sweat', 228, 4), 					--27
    ('Can not Fight Your Desire', 225, 4), 		--28
    ('Closer To Home', 493, 4),					--29
    ('Silicon Dreams', 250, 4), 				--30
    ('Star Invasion', 289, 4), 					--31
    ('I Stoole Your Love', 200, 4),				--32
    ('Stinkfist', 311, 5),						--33
    ('Eulogy', 508, 5),							--34
    ('H.', 367, 5),								--35
    ('Useful Idiot', 38, 5),					--36
    ('Forty Six & 2', 364, 5),					--37
    ('Message To Harry Manback', 113, 5),		--38
    ('Hooker With A Penis', 273, 5),			--39
    ('Intermission', 56, 5),					--40
    ('Jimmy', 324, 5),							--41
    ('Die Eier Von Satan', 197, 5),				--42
    ('Pushit', 595, 5),							--43
    ('Cesaro Summability', 86, 5),				--44
    ('Aenema', 399, 5),							--45
    ('-Ions', 240, 5),							--46
    ('Third Eye', 827, 5)						--47
;

INSERT INTO genre_artist(genre_id, artist_id)
VALUES 
    (4, 1),
    (5, 1),   
    (3, 2),
    (4, 2), 
    (3, 3),
    (5, 3),
    (2, 4),
    (1, 5),
    (5, 5)
;

INSERT INTO artist_album(artist_id, album_id)
VALUES 
    (1, 1),
    (2, 2),   
    (3, 3),
    (4, 4), 
    (5, 5)
;

INSERT INTO collection(collection_name, collection_date)
VALUES 
    ('Best Of Progressive', '2015-06-05'),	--1
    ('My Collection', '2005-04-16'), 		--2  
    ('Listen In Car', '2006-07-11'),		--3
    ('Listen evrytime', '1994-05-31')  		--4
;

INSERT INTO track_collection(track_id, collection_id)
VALUES 
    (1, 1),
    (7, 1),   
    (15, 1),
    (16, 1), 
    (20, 1),
    (21, 1),
    (27, 1),
    (28, 1),
    (35, 1),
    (37, 1),
    (42, 1),
    (46, 1),
    (2, 2),
    (10, 2),   
    (11, 2),
    (12, 2), 
    (32, 2),
    (35, 2),
    (37, 2),
    (12, 3),
    (16, 3),   
    (18, 3),
    (22, 3), 
    (24, 3),
    (38, 3),
    (1, 4),
    (3, 4),   
    (5, 4),
    (6, 4), 
    (9, 4),
    (10, 4),
    (12, 4),
    (16, 4),   
    (18, 4),
    (22, 4), 
    (24, 4),
    (32, 4),
    (35, 4),  
    (37, 4),
    (40, 4), 
    (41, 4),
    (42, 4)
;