
---------- first witness
select id
from person p inner join facebook_event_checkin f
on p.id = f.person_id
where f.date = 20180115 and p.address_street_name like '%Northwestern Dr%'

--person_id = 14887

------------ second witness
select id from person where address_street_name like '%Franklin%' and name like '%Annabel%'

-- person_id = 16371


------people at gym on that night
select *
from person p inner join (select *
from get_fit_now_check_in g inner join get_fit_now_member gf
on g.membership_id = gf.id
where g.check_in_date = 20180115 ) gym
on p.id = gym.person_id


------ people at facebook event on that night
select *
from person p inner join facebook_event_checkin f
on p.id = f.person_id
where f.date = 20180115


------ interview of first witness
select * from interview where person_id = (select id
from person p inner join facebook_event_checkin f
on p.id = f.person_id
where f.date = 20180115 and p.address_street_name like '%Northwestern Dr%')

--said: I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man -got into a car with a plate that included "H42W".


----- interview of second witness


select * from interview where person_id = (select id from person where address_street_name like '%Franklin%' and name like '%Annabel%')

--said : I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.


---- murderer
select * from drivers_license d inner join (select p.id, p.name, p.license_id
from person p inner join (select *
from get_fit_now_check_in g inner join get_fit_now_member gf
on g.membership_id = gf.id
where g.check_in_date = 20180109 and gf.membership_status = 'gold' and g.membership_id like '48Z%') gym
on p.id = gym.person_id) f
on d.id = f.license_id


--person_id = 67318

---said: I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.



---- possible 3 ladies
select p.id, p.name from person p inner join (select id
from drivers_license
where gender = 'female' and
car_make = 'Tesla' and
car_model = 'Model S' and
hair_color = 'red' and
height between 65 and 67) d
on p.license_id = d.id


----- master brain
select *
from facebook_event_checkin f
inner join
(select p.id, p.name from person p inner join (select id
from drivers_license
where gender = 'female' and
car_make = 'Tesla' and
car_model = 'Model S' and
hair_color = 'red' and
height between 65 and 67) d
on p.license_id = d.id) p
on f.person_id = p.id
where f.date between 20171130 and 20180101
