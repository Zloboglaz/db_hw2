CREATE TABLE IF NOT EXISTS genre (
    genre_id   SERIAL      PRIMARY KEY,
    genre_name VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS artist (
    artist_id   SERIAL      PRIMARY KEY,
    artist_name VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS album (
    album_id     SERIAL      PRIMARY KEY,
    album_name   VARCHAR(30) NOT NULL,
    release_date DATE        NOT NULL,
                 CONSTRAINT check_release_date
                 CHECK (release_date >= '1900-01-01' AND
                        release_date <= CURRENT_DATE
                 )
);

CREATE TABLE IF NOT EXISTS genre_artist (
    genre_id  INTEGER NOT NULL REFERENCES genre(genre_id),
    artist_id INTEGER NOT NULL REFERENCES artist(artist_id),
	          CONSTRAINT genre_artist_pk
	          PRIMARY KEY (genre_id, artist_id)
);

CREATE TABLE IF NOT EXISTS artist_album (
    artist_id INTEGER NOT NULL REFERENCES artist(artist_id),
    album_id  INTEGER NOT NULL REFERENCES album(album_id),
	          CONSTRAINT artist_album_pk
	          PRIMARY KEY (artist_id, album_id)
);

CREATE TABLE IF NOT EXISTS track (
    track_id    SERIAL      PRIMARY KEY,
    track_name  VARCHAR(30) NOT NULL,
    track_lenth INTEGER     NOT NULL,
    album_id    INTEGER     NOT NULL REFERENCES album(album_id)
);

CREATE TABLE IF NOT EXISTS collection (
    collection_id   SERIAL      PRIMARY KEY,
    collection_name VARCHAR(30) NOT NULL,
    collection_date DATE        NOT NULL,
                    CONSTRAINT collection_date
                    CHECK (collection_date >= '1900-01-01' AND
                        collection_date <= CURRENT_DATE
                    )
);

CREATE TABLE IF NOT EXISTS track_collection (
    track_id        INTEGER NOT NULL REFERENCES track(track_id),
    collection_id   INTEGER NOT NULL REFERENCES collection(collection_id),
             CONSTRAINT track_collection_pk 
             PRIMARY KEY (track_id, collection_id)
);