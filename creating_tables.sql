-- CREATE DATABASE project_4;
use project_4;

-- creating genre table and populate it 
CREATE TABLE project_4.genre (genre_id INT auto_increment primary KEY,
								catagory VARCHAR(80));
INSERT INTO genre (catagory)
SELECT DISTINCT genre FROM raw_movies;

-- creating raings table and populate it 
CREATE TABLE project_4.ratings (
	imdb_id VARCHAR(20) PRIMARY KEY,
    rated VARCHAR(20),
    imdb_rating DOUBLE,
    imdb_votes DOUBLE,
    meta_score DOUBLE,
    awards TEXT
    );

INSERT INTO project_4.ratings (imdb_id, rated, imdb_rating, imdb_votes, meta_score, awards)
SELECT DISTINCT imdb_id, rated, imdb_rating, imdb_votes, meta_score, awards
FROM project_4.raw_movies;

-- actors 
CREATE TABLE project_4.actors (
    actor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(250) NOT NULL UNIQUE
);
INSERT INTO project_4.actors (name)
SELECT DISTINCT actors
FROM project_4.raw_movies
WHERE actors IS NOT NULL AND actors <> '';

-- directors
CREATE TABLE project_4.directors (
    director_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(250) NOT NULL UNIQUE
);
-- Insert directors
INSERT INTO project_4.directors (name)
SELECT DISTINCT director
FROM project_4.raw_movies
WHERE director IS NOT NULL AND director <> '';

-- writers
CREATE TABLE project_4.writers (
    writer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(250) NOT NULL UNIQUE
);

-- Insert writers
INSERT INTO project_4.writers (name)
SELECT DISTINCT writer
FROM project_4.raw_movies
WHERE writer IS NOT NULL AND writer <> '';
    

    -- movies

CREATE TABLE project_4.movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(250) NOT NULL,
    release_date TEXT,
    country VARCHAR(250),
    language VARCHAR(100),
    runtime DOUBLE,
    box_office DOUBLE,
    domestic_gross INT,
    worldwide_gross BIGINT,
    production_budget INT,
    profit BIGINT,
    actor_id INT,
    director_id INT,
    writer_id INT,
    genre_id INT,
    imdb_id VARCHAR(20) UNIQUE,
    FOREIGN KEY (actor_id) REFERENCES project_4.actors(actor_id),
    FOREIGN KEY (director_id) REFERENCES project_4.directors(director_id),
    FOREIGN KEY (writer_id) REFERENCES project_4.writers(writer_id),
    FOREIGN KEY (genre_id) REFERENCES project_4.genre(genre_id),
    FOREIGN KEY (imdb_id) REFERENCES project_4.ratings(imdb_id)
);

INSERT INTO project_4.movies (
    imdb_id, title, release_date, country, language, runtime,
    box_office, domestic_gross, worldwide_gross, production_budget, profit,
    actor_id, director_id, writer_id, genre_id
)
SELECT 
    r.imdb_id,
    r.title,
    r.release_date,
    r.country,
    r.language,
    r.runtime,
    r.box_office,
    r.domestic_gross,
    r.worldwide_gross,
    r.production_budget,
    r.profit,
    a.actor_id,
    d.director_id,
    w.writer_id,
    g.genre_id
FROM project_4.raw_movies r
LEFT JOIN project_4.actors a 
    ON TRIM(r.actors) = a.name
LEFT JOIN project_4.directors d 
    ON TRIM(r.director) = d.name
LEFT JOIN project_4.writers w 
    ON TRIM(r.writer) = w.name
LEFT JOIN project_4.genre g
    ON TRIM(r.genre) = g.catagory;
    
    --
    
    
    
    
    
    
