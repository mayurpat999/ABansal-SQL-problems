-- Create table in MySQL
CREATE TABLE entries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(100),
    email VARCHAR(100),
    floor INT,
    resources VARCHAR(50)
);

-- Insert values
INSERT INTO entries (name, address, email, floor, resources)
VALUES 
('A','Bangalore','A@gmail.com',1,'CPU'),
('A','Bangalore','A1@gmail.com',1,'CPU'),
('A','Bangalore','A2@gmail.com',2,'DESKTOP'),
('B','Bangalore','B@gmail.com',2,'DESKTOP'),
('B','Bangalore','B1@gmail.com',2,'DESKTOP'),
('B','Bangalore','B2@gmail.com',1,'MONITOR');

select * from entries;
with resources as (
select name,count(*) as total_visits, group_concat(distinct(resources)) as resources_used from entries
group by name),
most_visit_floor as (
select name, floor,count(*) as Floor_visit_count, rank() over (partition by name order by count(*) desc) as rn
from entries group by name,floor)
select vf.name, vf.floor as most_visited_floor, rs.total_visits, rs.resources_used from most_visit_floor vf
inner join resources rs on vf.name = rs.name
where vf.rn =1
;
