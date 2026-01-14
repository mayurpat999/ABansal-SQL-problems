-- Create table
CREATE TABLE icc_world_cup (
    Team_1 VARCHAR(20),
    Team_2 VARCHAR(20),
    Winner VARCHAR(20)
);

-- Insert records
INSERT INTO icc_world_cup (Team_1, Team_2, Winner) VALUES ('India','SL','India');
INSERT INTO icc_world_cup (Team_1, Team_2, Winner) VALUES ('SL','Aus','Aus');
INSERT INTO icc_world_cup (Team_1, Team_2, Winner) VALUES ('SA','Eng','Eng');
INSERT INTO icc_world_cup (Team_1, Team_2, Winner) VALUES ('Eng','NZ','NZ');
INSERT INTO icc_world_cup (Team_1, Team_2, Winner) VALUES ('Aus','India','India');

-- Select all records
SELECT * FROM icc_world_cup;

-- question give the table of total matches played,total wins,total loss against each country
select Team, count(*) as total_matches_played, sum(win_flag) as matches_won , count(*) - sum(win_flag) as matches_lost from  
(select Team_1 as Team, case when Team_1 = Winner then 1 else 0 end as win_flag from icc_world_cup
union all
select Team_2 as Team, case when Team_2 = Winner then 1 else 0 end as win_flag from icc_world_cup) a 
group by Team
order by Team;

