-- 16-Database Triggers - SQL statements that are AUTOMATICALLY RUN when a specific table is changed


-- Syntax
CREATE TRIGGER trigger_name 
    trigger_time trigger_event ON table_name FOR EACH ROW
    BEGIN
    ...
    END;
-- trigger_time - BEFORE, AFTER
-- trigger_event - INSERT, UPDATE, DELETE
-- table_name e.g. users, photos

-- Listing Triggers
SHOW TRIGGERS;
-- Removing Triggers
DROP TRIGGER trigger_name;
-- Warning: Triggers can make debugging hard!


-- 1. Simple Validation

DELIMITER $$ -- change the delimiter from ; to $$
CREATE TRIGGER must_be_adult
    BEFORE INSERT ON users FOR EACH ROW
    BEGIN
        IF NEW.age < 18 -- NEW refers to data that is about to be inserted
        THEN
            SIGNAL SQLSTATE '45000' -- 45000 means a generic state representing "unhandled user-defined exception"
                SET MESSAGE_TEXT = 'Must be an adult!';
        END IF;
    END;
$$
DELIMITER ; -- change the delimiter back to ;

/* MySQL Errors
A numeric error code (1146)- this number is MySQL-specific
A five-character SQLSTATE value ('42S02')- the values are taken from ANSI SQL and ODBC and are more standardized
A message string - textual description of the error
*/


-- 2. Prevent Self-Follows

DELIMITER $$
CREATE TRIGGER example_cannot_follow_self
    BEFORE INSERT ON follows FOR EACH ROW
    BEGIN
        IF NEW.follower_id = NEW.following_id
        THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Cannot follow yourself!';
        END IF;
    END;
$$
DELIMITER ;


-- 3. Logging Unfollows

DELIMITER $$
CREATE TRIGGER capture_unfollow
    AFTER DELETE ON follows FOR EACH ROW 
    BEGIN
        INSERT INTO unfollows
        SET follower_id = OLD.follower_id,
            followee_id = OLD.followee_id;
        -- OR INSERT INTO unfollows (follower_id, followee_id) VALUES (OLD.follower_id, OLD.followee_id);
    END;
$$
DELIMITER ;
