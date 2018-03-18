SELECT pl.name, count(*) AS "CertCount"
FROM bsg_planets pl
INNER JOIN bsg_people p ON pl.id = p.homeworld
INNER JOIN bsg_cert_people cp ON cp.pid = p.id
GROUP BY pl.id


SELECT fname, lname
FROM bsg_people p
INNER JOIN bsg_ship_assignment sa ON sa.pid = p.id
INNER JOIN bsg_ship_instance si ON si.class = sa.cid
INNER JOIN bsg_ship_class sc ON sc.id = si.class
WHERE sc.name = "Viper"


SELECT p.fname, p.lname, si.id
FROM bsg_people p
INNER JOIN bsg_ship_assignment sa ON sa.pid = p.id
INNER JOIN bsg_ship_instance si ON sa.sid = si.id
INNER JOIN bsg_ship_class sc ON sc.id = si.class
WHERE p.id NOT IN
(
SELECT cp.pid FROM bsg_cert_people cp
INNER JOIN bsg_cert c ON cp.cid = c.id
WHERE c.title = 'Viper'
)
AND sc.name = 'Viper'

SELECT bsg_people.fname, bsg_people.lname, bsg_ship_instance.id 
FROM bsg_people
INNER JOIN bsg_ship_assignment ON bsg_ship_assignment.pid = bsg_people.id
INNER JOIN bsg_ship_instance ON bsg_ship_assignment.sid = bsg_ship_instance.id
INNER JOIN bsg_ship_class ON bsg_ship_class.id = bsg_ship_instance.class
WHERE bsg_people.id NOT IN
(
SELECT bsg_cert_people.pid FROM bsg_cert_people
INNER JOIN bsg_cert ON bsg_cert_people.cid = bsg_cert.id
WHERE bsg_cert.title = 'Viper'
)
AND bsg_ship_class.name = 'Viper'


