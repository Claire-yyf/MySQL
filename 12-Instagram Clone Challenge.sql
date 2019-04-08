-- 12-Instagram Clone Challenge


/*
Find the 5 oldest users
We want to reward our users who have been around the longest
*/
SELECT * FROM users
ORDER BY created_at LIMIT 5; 

/*
Find the most popular registration day
What day of the week do most users register on? We need to figure out when to schedule an ad campgain
*/
SELECT DAYNAME(created_at) AS day,
        COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC;

/*
Identify inactive users (users with no photos)
We want to target the users who have never posted a photo with an email campaign
*/
SELECT username
FROM users LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.id IS NULL;

/*
Identify the most popular photo (and user who created it)
We're running a new contest to see who can get the most likes on a single photo. WHO WON??!!
*/
SELECT username, photos.image_url, COUNT(*) AS total
FROM photos INNER JOIN likes ON photos.id = likes.photo_id
            INNER JOIN users ON users.id = photos.user_id
GROUP BY photos.id 
ORDER BY total DESC
LIMIT 1;

/*
Calculate average number of photos per user (total number of photos / total number of user)
Our Investors want to know how many times does the average user post?
*/
SELECT ((SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users)) AS average;

/*
Find the five most popular hashtags
A brand wants to know which hashtags to use in a post. What are the top 5 most commonly used hashtags?
*/
SELECT tags.tag_name, 
       COUNT(*) AS total 
FROM tags INNER JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY total DESC
LIMIT 5;

/*
Find the bots - the users who have liked every single photo on the site
We have a small problem with bots on our site...
*/
SELECT username, COUNT(*) AS num_likes 
FROM users INNER JOIN likes ON users.id = likes.user_id 
GROUP BY users.id
HAVING num_likes = (SELECT COUNT(*) FROM photos); 

/*
Find users who have never commented on a photo
We also have a problem with celebrities
*/
SELECT * FROM users WHERE id NOT IN (SELECT user_id FROM comments);

/*
Find the percentage of our users who have either never commented on a photo or have commented on every photo
Are we overrun with bots and celebrity accounts?
*/

SELECT CONCAT((
    (SELECT COUNT(*) FROM
        (SELECT username, COUNT(*) AS num_likes
        FROM users INNER JOIN likes ON users.id = likes.user_id 
        GROUP BY users.id
        HAVING num_likes = 
            (SELECT COUNT(*) FROM photos)) AS num_bots)
    +
    (SELECT COUNT(*) FROM 
        (SELECT * FROM users WHERE id NOT IN 
            (SELECT user_id FROM comments)) AS num_celebrities)) 
    / 
    (SELECT COUNT(*) FROM users) * 100, '%') AS percentage;
