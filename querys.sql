


USE project_4;
#which films earned the most at the box office
SELECT 
    g.catagory AS genre,
    ROUND(AVG(m.profit), 2) AS avg_profit,
    RANK() OVER (ORDER BY AVG(m.profit) DESC) AS genre_rank,
    ROUND(AVG(AVG(m.profit)) OVER (), 2) AS overall_avg_profit,
    CASE 
        WHEN AVG(m.profit) > AVG(AVG(m.profit)) OVER () THEN 'Above Average'
        WHEN AVG(m.profit) < AVG(AVG(m.profit)) OVER () THEN 'Below Average'
        ELSE 'Average'
    END AS performance_category
FROM project_4.movies m
JOIN project_4.genre g 
    ON m.genre_id = g.genre_id
GROUP BY g.catagory
ORDER BY avg_profit DESC;


#-Which genres  win the most awards
SELECT 
    g.catagory AS genre,
    COUNT(r.imdb_id) AS num_movies,
    SUM(
        CASE 
            WHEN r.awards LIKE '%Won%' OR r.awards LIKE '%win%' THEN 1
            ELSE 0
        END
    ) AS movies_with_awards
FROM project_4.movies m
JOIN project_4.genre g ON m.genre_id = g.genre_id
JOIN project_4.ratings r ON m.imdb_id = r.imdb_id
GROUP BY g.catagory
ORDER BY movies_with_awards DESC;

#Which films have won awards
SELECT 
    m.title,
    r.awards
FROM project_4.movies m
JOIN project_4.ratings r 
    ON m.imdb_id = r.imdb_id
WHERE r.awards LIKE '%oscar%' 
ORDER BY m.title;
#which countries produce the most films
SELECT 
    country,
    COUNT(*) AS total_films
FROM project_4.movies
WHERE country IS NOT NULL AND country <> ''
GROUP BY country
ORDER BY total_films DESC;

