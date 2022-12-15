-- CS4400: Introduction to Database Systems (Fall 2022)
-- Project Phase III: Stored Procedures SHELL [v2] Wednesday, November 30, 2022
set global transaction isolation level serializable;
set global SQL_MODE = 'ANSI,TRADITIONAL';
set names utf8mb4;
set SQL_SAFE_UPDATES = 0;

use restaurant_supply_express;
-- -----------------------------------------------------------------------------
-- stored procedures and views
-- -----------------------------------------------------------------------------
/* Standard Procedure: If one or more of the necessary conditions for a procedure to
be executed is false, then simply have the procedure halt execution without changing
the database state. Do NOT display any error messages, etc. */

-- [1] add_owner()
-- -----------------------------------------------------------------------------
/* This stored procedure creates a new owner.  A new owner must have a unique
username.  Also, the new owner is not allowed to be an employee. */
-- -----------------------------------------------------------------------------
drop procedure if exists add_owner;
delimiter //
create procedure add_owner (in ip_username varchar(40), in ip_first_name varchar(100),
	in ip_last_name varchar(100), in ip_address varchar(500), in ip_birthdate date)
sp_main: begin
    if ip_username is null then leave sp_main; end if;
    if ip_first_name is null then leave sp_main; end if;
    if ip_last_name is null then leave sp_main; end if;
    if ip_address is null then leave sp_main; end if;
    if ip_birthdate is null then leave sp_main; end if;
    -- ensure new owner has a unique username
    if ((select count(*) from users where username = ip_username) = 0)
		then
		insert into users values (ip_username, ip_first_name, ip_last_name, ip_address, ip_birthdate);
		insert into restaurant_owners values (ip_username);
        END IF;
end //
delimiter ;

-- [2] add_employee()
-- -----------------------------------------------------------------------------
/* This stored procedure creates a new employee without any designated pilot or
worker roles.  A new employee must have a unique username unique tax identifier. */
-- -----------------------------------------------------------------------------
drop procedure if exists add_employee;
delimiter //
create procedure add_employee (in ip_username varchar(40), in ip_first_name varchar(100),
	in ip_last_name varchar(100), in ip_address varchar(500), in ip_birthdate date,
    in ip_taxID varchar(40), in ip_hired date, in ip_employee_experience integer,
    in ip_salary integer)
sp_main: begin
    if ip_username is null then leave sp_main; end if;
	if ip_first_name is null then leave sp_main; end if;
	if ip_last_name is null then leave sp_main; end if;
	if ip_address is null then leave sp_main; end if;
	if ip_birthdate is null then leave sp_main; end if;
    if ip_taxID is null then leave sp_main; end if;
    if ip_hired is null then leave sp_main; end if;
    if ip_employee_experience is null then leave sp_main; end if;
    if ip_salary is null then leave sp_main; end if;

    -- ensure new owner has a unique username
    -- ensure new employee has a unique tax identifier
    if ((select count(*) from users where username = ip_username) = 0)
		then
		insert into users values (ip_username, ip_first_name, ip_last_name, ip_address, ip_birthdate);
        END IF;
    if ((select count(*) from employees where taxID = ip_taxID) = 0)
		then
		insert into employees values (ip_username, ip_taxID, ip_hired, ip_employee_experience, ip_salary);
        END IF;
end //
delimiter ;

-- [3] add_pilot_role()
-- -----------------------------------------------------------------------------
/* This stored procedure adds the pilot role to an existing employee.  The
employee/new pilot must have a unique license identifier. */
-- -----------------------------------------------------------------------------
drop procedure if exists add_pilot_role;
delimiter //
create procedure add_pilot_role (in ip_username varchar(40), in ip_licenseID varchar(40),
	in ip_pilot_experience integer)
sp_main: begin
    if ip_username is null then leave sp_main; end if;
    if ip_licenseID is null then leave sp_main; end if;
    if ip_pilot_experience is null then leave sp_main; end if;
	
    -- ensure new employee exists
    if ((select count(*) from employees where username = ip_username) != 0)
		then
        if ((select count(*) from pilots where licenseID = ip_licenseID) = 0)
			then
            insert into pilots values (ip_username, ip_licenseID, ip_pilot_experience);
            end if;
		end if;
end //
delimiter ;

-- [4] add_worker_role()
-- -----------------------------------------------------------------------------
/* This stored procedure adds the worker role to an existing employee. */
-- -----------------------------------------------------------------------------
drop procedure if exists add_worker_role;
delimiter //
create procedure add_worker_role (in ip_username varchar(40))
sp_main: begin
    if ip_username is null then leave sp_main; end if;
    -- ensure new employee exists
    if ((select count(*) from employees where username = ip_username) != 0)
		then
		insert into workers values (ip_username);
		end if;
end //
delimiter ;

-- [5] add_ingredient()
-- -----------------------------------------------------------------------------
/* This stored procedure creates a new ingredient.  A new ingredient must have a
unique barcode. */
-- -----------------------------------------------------------------------------
drop procedure if exists add_ingredient;
delimiter //
create procedure add_ingredient (in ip_barcode varchar(40), in ip_iname varchar(100),
	in ip_weight integer)
sp_main: begin
	if ip_barcode is null then leave sp_main; end if;
    if ip_iname is null then leave sp_main; end if;
    if ip_weight is null then leave sp_main; end if;
	-- ensure new ingredient doesn't already exist
    if ((select count(*) from ingredients where barcode = ip_barcode) = 0)
		then
        insert into ingredients values (ip_barcode, ip_iname, ip_weight);
        end if;
end //
delimiter ;

-- [6] add_drone()
-- -----------------------------------------------------------------------------
/* This stored procedure creates a new drone.  A new drone must be assigned 
to a valid delivery service and must have a unique tag.  Also, it must be flown
by a valid pilot initially (i.e., pilot works for the same service), but the pilot
can switch the drone to working as part of a swarm later. And the drone's starting
location will always be the delivery service's home base by default. */
-- -----------------------------------------------------------------------------
drop procedure if exists add_drone;
delimiter //
create procedure add_drone (in ip_id varchar(40), in ip_tag integer, in ip_fuel integer,
	in ip_capacity integer, in ip_sales integer, in ip_flown_by varchar(40))
sp_main: begin
	if ip_id is null then leave sp_main; end if;
	if ip_tag is null then leave sp_main; end if;
    if ip_fuel is null then leave sp_main; end if;
    if ip_capacity is null then leave sp_main; end if;
    if ip_sales is null then leave sp_main; end if;
	-- ensure new drone doesn't already exist
    if not exists (select * from drones where id = ip_id and tag = ip_tag)
		then
		-- ensure that the delivery service exists
		if exists (select home_base from delivery_services where id = ip_id)
			then
            set @hover = (select home_base from delivery_services where id = ip_id);
			-- ensure that a valid pilot will control the drone
            if exists (select * from work_for where username in (select username from pilots where username = ip_flown_by))
				then
                insert into drones values (ip_id, ip_tag, ip_fuel, ip_capacity, ip_sales, ip_flown_by, null, null, @hover);
                end if;
			end if;
        end if;    
end //
delimiter ;

-- [7] add_restaurant()
-- -----------------------------------------------------------------------------
/* This stored procedure creates a new restaurant.  A new restaurant must have a
unique (long) name and must exist at a valid location, and have a valid rating.
And a resturant is initially "independent" (i.e., no owner), but will be assigned
an owner later for funding purposes. */
-- -----------------------------------------------------------------------------
drop procedure if exists add_restaurant;
delimiter //
create procedure add_restaurant (in ip_long_name varchar(40), in ip_rating integer,
	in ip_spent integer, in ip_location varchar(40))
sp_main: begin
	if ip_long_name is null then leave sp_main; end if;
    if ip_rating is null then leave sp_main; end if;
    if ip_spent is null then leave sp_main; end if;
    if ip_location is null then leave sp_main; end if;
	-- ensure new restaurant doesn't already exist
    if ((select count(*) from restaurants where long_name = ip_long_name) = 0)
		then
    -- ensure that the location is valid
		if exists (select * from locations where label = ip_location)
			then
    -- ensure that the rating is valid (i.e., between 1 and 5 inclusively)
			if ip_rating between 1 and 5
				then
                insert into restaurants values (ip_long_name, ip_rating, ip_spent, ip_location, null);
			end if;
		end if;
	end if;
end //
delimiter ;

-- [8] add_service()
-- -----------------------------------------------------------------------------
/* This stored procedure creates a new delivery service.  A new service must have
a unique identifier, along with a valid home base and manager. */
-- -----------------------------------------------------------------------------
drop procedure if exists add_service;
delimiter //
create procedure add_service (in ip_id varchar(40), in ip_long_name varchar(100),
	in ip_home_base varchar(40), in ip_manager varchar(40))
sp_main: begin
	if ip_id is null then leave sp_main; end if;
	if ip_long_name is null then leave sp_main; end if;
	if ip_home_base is null then leave sp_main; end if;
	if ip_manager is null then leave sp_main; end if;
	-- ensure new delivery service doesn't already exist
	if not exists (select * from delivery_services where id = ip_id)
		then
    -- ensure that the home base location is valid
		if exists (select * from locations where label = ip_home_base)
			then
    -- ensure that the manager is valid
			if exists (select * from workers where username = ip_manager)
				then
				insert into delivery_services values(ip_id, ip_long_name, ip_home_base, ip_manager);
            end if;
		end if;
	end if;
end //
delimiter ;

-- [9] add_location()
-- -----------------------------------------------------------------------------
/* This stored procedure creates a new location that becomes a new valid drone
destination.  A new location must have a unique combination of coordinates.  We
could allow for "aliased locations", but this might cause more confusion that
it's worth for our relatively simple system. */
-- -----------------------------------------------------------------------------
drop procedure if exists add_location;
delimiter //
create procedure add_location (in ip_label varchar(40), in ip_x_coord integer,
	in ip_y_coord integer, in ip_space integer)
sp_main: begin
	if ip_label is null then leave sp_main; end if;
    if ip_x_coord is null then leave sp_main; end if;
    if ip_y_coord is null then leave sp_main; end if;
    if ip_space is null then leave sp_main; end if;
	-- ensure new location doesn't already exist
    if not exists (select * from locations where label = ip_label)
		then
    -- ensure that the coordinate combination is distinct
		if not exists (select * from locations where x_coord = ip_x_coord and y_coord = ip_y_coord)
			then
            insert into locations values(ip_label, ip_x_coord, ip_y_coord, ip_space);
		end if;
	end if;
end //
delimiter ;

-- [10] start_funding()
-- -----------------------------------------------------------------------------
/* This stored procedure opens a channel for a restaurant owner to provide funds
to a restaurant. If a different owner is already providing funds, then the current
owner is replaced with the new owner.  The owner and restaurant must be valid. */
-- -----------------------------------------------------------------------------
drop procedure if exists start_funding;
delimiter //
create procedure start_funding (in ip_owner varchar(40), in ip_long_name varchar(40))
sp_main: begin
	if ip_long_name is null then leave sp_main; end if;
	-- ensure the owner and restaurant are valid
    if exists (select * from restaurant_owners where username = ip_owner)
		then
        if exists (select * from restaurants where long_name = ip_long_name)
			then
			UPDATE restaurants SET funded_by = ip_owner WHERE long_name = ip_long_name;
		end if;
	end if;
end //
delimiter ;

-- [11] hire_employee()
-- -----------------------------------------------------------------------------
/* This stored procedure hires an employee to work for a delivery service.
Employees can be combinations of workers and pilots. If an employee is actively
controlling drones or serving as manager for a different service, then they are
not eligible to be hired.  Otherwise, the hiring is permitted. */
-- -----------------------------------------------------------------------------
drop procedure if exists hire_employee;
delimiter //
create procedure hire_employee (in ip_username varchar(40), in ip_id varchar(40))
sp_main: begin
	if ip_username is null then leave sp_main; end if;
    if ip_id is null then leave sp_main; end if;
	-- ensure that the employee hasn't already been hired
	if not exists (select * from work_for where username = ip_username)
		then
	-- ensure that the employee and delivery service are valid
		if exists (select * from employees where username = ip_username)
			then
            if exists (select * from delivery_services where id = ip_id)
				then
    -- ensure that the employee isn't a manager for another service
				if not exists (select * from delivery_services where manager = ip_username)
					then
	-- ensure that the employee isn't actively controlling drones for another service
					if not exists (select * from drones where flown_by = ip_username and id != ip_id)
						then
                        insert into work_for values(ip_username, ip_id);
					end if;
				end if;
			end if;
		end if;
	end if;
end //
delimiter ;

-- [12] fire_employee()
-- -----------------------------------------------------------------------------
/* This stored procedure fires an employee who is currently working for a delivery
service.  The only restrictions are that the employee must not be: [1] actively
controlling one or more drones; or, [2] serving as a manager for the service.
Otherwise, the firing is permitted. */
-- -----------------------------------------------------------------------------
drop procedure if exists fire_employee;
delimiter //
create procedure fire_employee (in ip_username varchar(40), in ip_id varchar(40))
sp_main: begin
	if ip_username is null then leave sp_main; end if;
    if ip_id is null then leave sp_main; end if;
	-- ensure that the employee is currently working for the service
    if exists (select * from work_for where username = ip_username and id = ip_id)
		then
    -- ensure that the employee isn't an active manager
		if not exists (select * from delivery_services where manager = ip_username)
			then
	-- ensure that the employee isn't controlling any drones
			if not exists (select * from drones where flown_by = ip_username)
				then
                DELETE from work_for WHERE username = ip_username and id = ip_id;
			end if;
		end if;
	end if;
end //
delimiter ;

-- [13] manage_service()
-- -----------------------------------------------------------------------------
/* This stored procedure appoints an employee who is currently hired by a delivery
service as the new manager for that service.  The only restrictions are that: [1]
the employee must not be working for any other delivery service; and, [2] the
employee can't be flying drones at the time.  Otherwise, the appointment to manager
is permitted.  The current manager is simply replaced.  And the employee must be
granted the worker role if they don't have it already. */
-- -----------------------------------------------------------------------------
drop procedure if exists manage_service;
delimiter //
create procedure manage_service (in ip_username varchar(40), in ip_id varchar(40))
sp_main: begin
	if ip_username is null then leave sp_main; end if;
    if ip_id is null then leave sp_main; end if;
	-- ensure that the employee is currently working for the service
	if exists (select * from work_for where username = ip_username and id = ip_id)
		then
	-- ensure that the employee is not flying any drones
		if not exists (select * from drones where flown_by = ip_username)
			then
    -- ensure that the employee isn't working for any other services
			if not exists (select * from work_for where username = ip_username and id != ip_id)
				then
                UPDATE delivery_services SET manager = ip_username WHERE id = ip_id;
                -- add the worker role if necessary
                if not exists (select * from workers where username = ip_username)
					then
                    INSERT into workers values(ip_username);
				end if;
			end if;
		end if;
	end if;
end //
delimiter ;

-- [14] takeover_drone()
-- -----------------------------------------------------------------------------
/* This stored procedure allows a valid pilot to take control of a lead drone owned
by the same delivery service, whether it's a "lone drone" or the leader of a swarm.
The current controller of the drone is simply relieved of those duties. And this
should only be executed if a "leader drone" is selected. */
-- -----------------------------------------------------------------------------
drop procedure if exists takeover_drone;
delimiter //
create procedure takeover_drone (in ip_username varchar(40), in ip_id varchar(40),
	in ip_tag integer)
sp_main: begin
	if ip_tag is null then leave sp_main; end if;
    if ip_id is null then leave sp_main; end if;
    if ip_username is null then leave sp_main; end if;
	-- ensure that the employee is currently working for the service
    if exists (select * from work_for where username = ip_username and id = ip_id)
		then
	-- ensure that the selected drone is owned by the same service and is a leader and not follower
		if exists (select * from drones where id = ip_id and tag = ip_tag and swarm_id is null and swarm_tag is null)
			then
	-- ensure that the employee isn't a manager
			if not exists (select * from delivery_services where manager = ip_username)
				then
    -- ensure that the employee is a valid pilot
				if exists (select * from pilots where username = ip_username)
					then
                    UPDATE drones SET flown_by = ip_username WHERE id = ip_id and tag = ip_tag;
				end if;
			end if;
		end if;
	end if;
end //
delimiter ;

-- [15] join_swarm()
-- -----------------------------------------------------------------------------
/* This stored procedure takes a drone that is currently being directly controlled
by a pilot and has it join a swarm (i.e., group of drones) led by a different
directly controlled drone. A drone that is joining a swarm connot be leading a
different swarm at this time.  Also, the drones must be at the same location, but
they can be controlled by different pilots. */
-- -----------------------------------------------------------------------------
drop procedure if exists join_swarm;
delimiter //
create procedure join_swarm (in ip_id varchar(40), in ip_tag integer,
	in ip_swarm_leader_tag integer)
sp_main: begin
	if ip_tag is null then leave sp_main; end if;
    if ip_id is null then leave sp_main; end if;
    if ip_swarm_leader_tag is null then leave sp_main; end if;
	-- ensure that the swarm leader is a different drone
    if ip_tag != ip_swarm_leader_tag
		then
	-- ensure that the drone joining the swarm is valid and owned by the service
		if exists (select * from drones where id = ip_id and tag = ip_tag)
			then
    -- ensure that the drone joining the swarm is not already leading a swarm
			if not exists (select * from drones where swarm_id = ip_id and swarm_tag = ip_tag)
				then
	-- ensure that the swarm leader drone is directly controlled
				if exists (select * from drones where id = ip_id and tag = ip_swarm_leader_tag and swarm_id is null and swarm_tag is null and flown_by in (select username from pilots))
					then
	-- ensure that the drones are at the same location
					if (select hover from drones where id = ip_id and tag = ip_tag) in (select hover from drones where id = ip_id and tag = ip_swarm_leader_tag)
                        then
                        UPDATE drones SET swarm_id = ip_id, swarm_tag = ip_swarm_leader_tag, flown_by = NULL WHERE id = ip_id and tag = ip_tag;
					end if;
				end if;
			end if;
		end if;
	end if;
end //
delimiter ;

-- [16] leave_swarm()
-- -----------------------------------------------------------------------------
/* This stored procedure takes a drone that is currently in a swarm and returns
it to being directly controlled by the same pilot who's controlling the swarm. */
-- -----------------------------------------------------------------------------
drop procedure if exists leave_swarm;
delimiter //
create procedure leave_swarm (in ip_id varchar(40), in ip_swarm_tag integer)
sp_main: begin
	if ip_id is null then leave sp_main; end if;
    if ip_swarm_tag is null then leave sp_main; end if;
	-- ensure that the selected drone is owned by the service and flying in a swarm
    if exists (select * from drones where id = ip_id AND tag = ip_swarm_tag AND swarm_id = ip_id)
		then
        set @pilot = (select flown_by from drones where id = ip_id and tag = (select swarm_tag from drones where id = ip_id and tag = ip_swarm_tag));
        UPDATE drones SET swarm_id = NULL, swarm_tag = NULL, flown_by = @pilot WHERE id = ip_id AND tag = ip_swarm_tag;
	end if;
end //
delimiter ;

-- [17] load_drone()
-- -----------------------------------------------------------------------------
/* This stored procedure allows us to add some quantity of fixed-size packages of
a specific ingredient to a drone's payload so that we can sell them for some
specific price to other restaurants.  The drone can only be loaded if it's located
at its delivery service's home base, and the drone must have enough capacity to
carry the increased number of items.

The change/delta quantity value must be positive, and must be added to the quantity
of the ingredient already loaded onto the drone as applicable.  And if the ingredient
already exists on the drone, then the existing price must not be changed. */
-- -----------------------------------------------------------------------------
drop procedure if exists load_drone;
delimiter //
create procedure load_drone (in ip_id varchar(40), in ip_tag integer, in ip_barcode varchar(40),
	in ip_more_packages integer, in ip_price integer)
sp_main: begin
	if ip_tag is null then leave sp_main; end if;
    if ip_id is null then leave sp_main; end if;
    if ip_barcode is null then leave sp_main; end if;
    if ip_more_packages is null then leave sp_main; end if;
    if ip_price is null then leave sp_main; end if;
	-- ensure that the drone being loaded is owned by the service
    if exists (select * from drones where id = ip_id and tag = ip_tag)
		then
	-- ensure that the ingredient is valid
		if exists (select * from ingredients where barcode = ip_barcode)
			then
    -- ensure that the drone is located at the service home base
			if exists (select * from drones where id = ip_id and tag = ip_tag and hover in (select home_base from delivery_services where id = ip_id))
				then
	-- ensure that the quantity of new packages is greater than zero
	-- ensure that the drone has sufficient capacity to carry the new packages
				if (ip_more_packages > 0 and ((select capacity from drones where id = ip_id and tag = ip_tag) - (select sum(quantity) from payload where id = ip_id AND tag = ip_tag)) >= ip_more_packages)
					then
					-- add more of the ingredient to the drone
                    if exists (select * from payload where id = ip_id and tag = ip_tag and barcode = ip_barcode)
						then
                        UPDATE payload set quantity = (quantity + ip_more_packages) where id = ip_id and tag = ip_tag and barcode = ip_barcode;
					else
                        insert into payload values(ip_id, ip_tag, ip_barcode, ip_more_packages, ip_price);
					end if;
				end if;
			end if;
		end if;
	end if;
end //
delimiter ;

-- [18] refuel_drone()
-- -----------------------------------------------------------------------------
/* This stored procedure allows us to add more fuel to a drone. The drone can only
be refueled if it's located at the delivery service's home base. */
-- -----------------------------------------------------------------------------
drop procedure if exists refuel_drone;
delimiter //
create procedure refuel_drone (in ip_id varchar(40), in ip_tag integer, in ip_more_fuel integer)
sp_main: begin
	if ip_tag is null then leave sp_main; end if;
    if ip_id is null then leave sp_main; end if;
    if ip_more_fuel is null then leave sp_main; end if;
	-- ensure that the drone being switched is valid and owned by the service
    if exists (select * from drones where id = ip_id and tag = ip_tag)
		then
    -- ensure that the drone is located at the service home base
		if exists (select * from drones where hover in (select home_base from delivery_services where id = ip_id))
			then
            UPDATE drones set fuel = (fuel + ip_more_fuel) WHERE id = ip_id and tag = ip_tag;
		end if;
	end if;
end //
delimiter ;

-- [19] fly_drone()
-- -----------------------------------------------------------------------------
/* This stored procedure allows us to move a single or swarm of drones to a new
location (i.e., destination). The main constraints on the drone(s) being able to
move to a new location are fuel and space.  A drone can only move to a destination
if it has enough fuel to reach the destination and still move from the destination
back to home base.  And a drone can only move to a destination if there's enough
space remaining at the destination.  For swarms, the flight directions will always
be given to the lead drone, but the swarm must always stay together. */
-- -----------------------------------------------------------------------------
drop function if exists fuel_required;
delimiter //
create function fuel_required (ip_departure varchar(40), ip_arrival varchar(40))
	returns integer reads sql data
begin
	if (ip_departure = ip_arrival) then return 0;
    else return (select 1 + truncate(sqrt(power(arrival.x_coord - departure.x_coord, 2) + power(arrival.y_coord - departure.y_coord, 2)), 0) as fuel
		from (select x_coord, y_coord from locations where label = ip_departure) as departure,
        (select x_coord, y_coord from locations where label = ip_arrival) as arrival);
	end if;
end //
delimiter ;

drop procedure if exists fly_drone;
delimiter //
create procedure fly_drone (in ip_id varchar(40), in ip_tag integer, in ip_destination varchar(40))
sp_main: begin
	if ip_id is null then leave sp_main; end if;
    if ip_tag is null then leave sp_main; end if;
    if ip_destination is null then leave sp_main; end if;
	-- ensure that the lead drone being flown is directly controlled and owned by the service
	if exists (select * from drones where id = ip_id and tag = ip_tag and swarm_id is null and swarm_tag is null and flown_by in (select username from pilots))
		then
    -- ensure that the destination is a valid location
		if exists (select * from locations where label = ip_destination)
			then
    -- ensure that the drone isn't already at the location
			if not exists (select * from drones where id = ip_id and tag = ip_tag and hover = ip_destination)
				then
    -- ensure that the drone/swarm has enough fuel to reach the destination and (then) home base
				set @fuel = fuel_required((select hover from drones where id = ip_id and tag = ip_tag), ip_destination);
                set @swarm = (select count(*) from drones where swarm_id = ip_id and swarm_tag = ip_tag);
                set @vswarm = (select count(*) from drones where swarm_id = ip_id and swarm_tag = ip_tag and fuel >= @fuel);
				if ((select fuel from drones where id = ip_id and tag = ip_tag) >= @fuel AND @swarm = @vswarm)
					then
    -- ensure that the drone/swarm has enough space at the destination for the flight
					if ((select space from locations where label = ip_destination) >= @swarm)
						then
                        UPDATE drones set fuel = (fuel - @fuel), hover = ip_destination where id = ip_id AND tag = ip_tag;
                        UPDATE drones set fuel = (fuel - @fuel), hover = ip_destination where swarm_id = ip_id AND swarm_tag = ip_tag;
					end if;
				end if;
			end if;
		end if;
	end if;
end //
delimiter ;

-- [20] purchase_ingredient()
-- -----------------------------------------------------------------------------
/* This stored procedure allows a restaurant to purchase ingredients from a drone
at its current location.  The drone must have the desired quantity of the ingredient
being purchased.  And the restaurant must have enough money to purchase the
ingredients.  If the transaction is otherwise valid, then the drone and restaurant
information must be changed appropriately.  Finally, we need to ensure that all
quantities in the payload table (post transaction) are greater than zero. */
-- -----------------------------------------------------------------------------
drop procedure if exists purchase_ingredient;
delimiter //
create procedure purchase_ingredient (in ip_long_name varchar(40), in ip_id varchar(40),
	in ip_tag integer, in ip_barcode varchar(40), in ip_quantity integer)
sp_main: begin
	if ip_long_name is null then leave sp_main; end if;
    if ip_id is null then leave sp_main; end if;
    if ip_tag is null then leave sp_main; end if;
	if ip_barcode is null then leave sp_main; end if;
	if ip_quantity is null then leave sp_main; end if;
	-- ensure that the restaurant is valid
    if exists (select * from restaurants where long_name = ip_long_name)
		then
    -- ensure that the drone is valid and exists at the resturant's location
		if exists (select * from drones where id = ip_id and tag = ip_tag and hover in (select location from restaurants where long_name = ip_long_name))
			then
	-- ensure that the drone has enough of the requested ingredient
			if ((select quantity from payload where id = ip_id and tag = ip_tag and barcode = ip_barcode) >= ip_quantity)
				then
	-- update the drone's payload
				UPDATE payload set quantity = (quantity - ip_quantity) where id = ip_id and tag = ip_tag and barcode = ip_barcode;
    -- update the monies spent and gained for the drone and restaurant
				set @price = (select price from payload where id = ip_id and tag = ip_tag and barcode = ip_barcode);
				UPDATE drones set sales = (sales + (@price * ip_quantity)) where id = ip_id and tag = ip_tag;
                UPDATE restaurants set spent = (spent + (@price * ip_quantity)) where long_name = ip_long_name;
    -- ensure all quantities in the payload table are greater than zero
				if ((select quantity from payload where id = ip_id and tag = ip_tag and barcode = ip_barcode) = 0)
					then
                    DELETE from payload where id = ip_id and tag = ip_tag and barcode = ip_barcode;
                    
				end if;
			end if;
		end if;
	end if;
end //
delimiter ;

-- [21] remove_ingredient()
-- -----------------------------------------------------------------------------
/* This stored procedure removes an ingredient from the system.  The removal can
occur if, and only if, the ingredient is not being carried by any drones. */
-- -----------------------------------------------------------------------------
drop procedure if exists remove_ingredient;
delimiter //
create procedure remove_ingredient (in ip_barcode varchar(40))
sp_main: begin
	if ip_barcode is null then leave sp_main; end if;
	-- ensure that the ingredient exists
    if exists (select * from ingredients where barcode = ip_barcode)
		then
    -- ensure that the ingredient is not being carried by any drones
		if not exists (select * from payload where barcode = ip_barcode)
			then
            DELETE from ingredients where barcode = ip_barcode;
		end if;
	end if;
end //
delimiter ;

-- [22] remove_drone()
-- -----------------------------------------------------------------------------
/* This stored procedure removes a drone from the system.  The removal can
occur if, and only if, the drone is not carrying any ingredients, and if it is
not leading a swarm. */
-- -----------------------------------------------------------------------------
drop procedure if exists remove_drone;
delimiter //
create procedure remove_drone (in ip_id varchar(40), in ip_tag integer)
sp_main: begin
	if ip_id is null then leave sp_main; end if;
	if ip_tag is null then leave sp_main; end if;
	-- ensure that the drone exists
    if exists (select * from drones where id = ip_id and tag = ip_tag)
		then
    -- ensure that the drone is not carrying any ingredients
		if not exists (select * from payload where id = ip_id and tag = ip_tag)
			then
	-- ensure that the drone is not leading a swarm
			if not exists (select * from drones where swarm_id = ip_id and swarm_tag = ip_tag)
				then
                DELETE from drones where id = ip_id and tag = ip_tag;
			end if;
		end if;
	end if;
end //
delimiter ;

-- [23] remove_pilot_role()
-- -----------------------------------------------------------------------------
/* This stored procedure removes a pilot from the system.  The removal can
occur if, and only if, the pilot is not controlling any drones.  Also, if the
pilot also has a worker role, then the worker information must be maintained;
otherwise, the pilot's information must be completely removed from the system. */
-- -----------------------------------------------------------------------------
drop procedure if exists remove_pilot_role;
delimiter //
create procedure remove_pilot_role (in ip_username varchar(40))
sp_main: begin
if ip_username is null then leave sp_main; end if;
	-- ensure that the pilot exists
	if exists (select * from pilots where username = ip_username)
		then
    -- ensure that the pilot is not controlling any drones
		if not exists (select * from drones where flown_by = ip_username)
			then
    -- remove all remaining information unless the pilot is also a worker
			DELETE from pilots where username = ip_username;
			if not exists (select * from workers where username = ip_username)
				then
                DELETE from users where username = ip_username;
			end if;
		end if;
	end if;
end //
delimiter ;

-- [24] display_owner_view()
-- -----------------------------------------------------------------------------
/* This view displays information in the system from the perspective of an owner.
For each owner, it includes the owner's information, along with the number of
restaurants for which they provide funds and the number of different places where
those restaurants are located.  It also includes the highest and lowest ratings
for each of those restaurants, as well as the total amount of debt based on the
monies spent purchasing ingredients by all of those restaurants. And if an owner
doesn't fund any restaurants then display zeros for the highs, lows and debt. */
-- -----------------------------------------------------------------------------
create or replace view display_owner_view as
select username, first_name, last_name, address, count(location) as num_restaurants,
count(distinct location) as num_places, 
ifnull(max(rating), 0) as highs, ifnull(min(rating), 0) as lows, ifnull(sum(spent),0) as debt
from users
Natural Join restaurant_owners
Left Outer Join restaurants
ON username = funded_by
Group BY username;

-- [25] display_employee_view()
-- -----------------------------------------------------------------------------
/* This view displays information in the system from the perspective of an employee.
For each employee, it includes the username, tax identifier, hiring date and
experience level, along with the license identifer and piloting experience (if
applicable), and a 'yes' or 'no' depending on the manager status of the employee. */
-- -----------------------------------------------------------------------------
create or replace view display_employee_view as
Select E.username, E.taxID, E.salary, E.hired, E.experience as employee_experience,
IfNull(P.licenseID, 'n/a') as licenseID, IfNull(P.experience, 'n/a') as piloting_experience,
If(manager IS NOT NULL, 'yes', 'no') as manager_status
From employees as E
Left Outer Join pilots as P
ON E.username = p.username
Left Outer Join delivery_services as D
ON E.username = D.manager;

-- [26] display_pilot_view()
-- -----------------------------------------------------------------------------
/* This view displays information in the system from the perspective of a pilot.
For each pilot, it includes the username, licenseID and piloting experience, along
with the number of drones that they are controlling. */
-- -----------------------------------------------------------------------------
create or replace view full_drones as
select drones.*, leader_drones.flown_by as flb
from
	(select id, tag, flown_by from drones as B where (id, tag) in 
	(Select swarm_id, swarm_tag from drones where swarm_id is not null)) as leader_drones
right outer join drones
on drones.swarm_id = leader_drones.id and drones.swarm_tag = leader_drones.tag;

create or replace view display_pilot_view as
Select username, licenseID, experience, 
count(id) as num_drones,
count(distinct hover) as num_locations
From pilots
left outer join (
	select id, tag, flown_by, hover from full_drones where flown_by is not null
union
select id, tag, flb, hover from full_drones where flown_by is null
order by id, tag
) as temp
ON username = flown_by
Group By username;

-- [27] display_location_view()
-- -----------------------------------------------------------------------------
/* This view displays information in the system from the perspective of a location.
For each location, it includes the label, x- and y- coordinates, along with the
number of restaurants, delivery services and drones at that location. */
-- -----------------------------------------------------------------------------

create or replace view display_location_view2 as
Select label,x_coord,y_coord, count(location) as num_restaurants
From locations
Left Outer Join restaurants
ON label = location
group by label;

create or replace view display_location_view3 as
select label,count(home_base) as num_delivery_services
From locations
Left outer join restaurants
ON label = location
Left outer join delivery_services
ON location = home_base
group by label;

create or replace view display_location_view4 as
select label, count(hover) as num_drones
From locations
Left outer join drones
ON label = hover
group by label;

create or replace view display_location_view as
select display_location_view2.label,
display_location_view2.x_coord, 
display_location_view2.y_coord, num_restaurants, num_delivery_services, display_location_view4.num_drones 
from display_location_view2
INNER JOIN display_location_view3
ON display_location_view2.label = display_location_view3.label
INNER JOIN display_location_view4
ON display_location_view3.label = display_location_view4.label;

-- [28] display_ingredient_view()
-- -----------------------------------------------------------------------------
/* This view displays information in the system from the perspective of the ingredients.
For each ingredient that is being carried by at least one drone, it includes a list of
the various locations where it can be purchased, along with the total number of packages
that can be purchased and the lowest and highest prices at which the ingredient is being
sold at that location. */
-- -----------------------------------------------------------------------------
create or replace view display_ingredient_view as
select ingredients.iname as ingredient_name, hover as location, payload.quantity as amount_available,
MIN(payload.price) as low_price, MAX(payload.price) as high_price
from payload
left outer join ingredients
ON payload.barcode = ingredients.barcode
natural join drones
GROUP BY ingredient_name, location, amount_available
ORDER BY ingredient_name, location;

-- [29] display_service_view()
-- -----------------------------------------------------------------------------
/* This view displays information in the system from the perspective of a delivery
service.  It includes the identifier, name, home base location and manager for the
service, along with the total sales from the drones.  It must also include the number
of unique ingredients along with the total cost and weight of those ingredients being
carried by the drones. */
-- -----------------------------------------------------------------------------
create or replace view display_service_view2 as
select delivery_services.id, long_name, home_base, manager, sum(sales) as revenue
from delivery_services
left outer join drones on delivery_services.id = drones.id
group by delivery_services.id;

create or replace view display_service_view3 as
select delivery_services.id,count(distinct payload.barcode)as ingredients_carried, 
SUM(quantity * price) as cost_carried, SUM(quantity * weight) as weight_carried
from delivery_services
left outer join payload
ON delivery_services.id = payload.id
Left outer join ingredients
ON payload.barcode = ingredients.barcode
group by delivery_services.id;

create or replace view display_service_view as
select display_service_view2.id, display_service_view2.long_name, display_service_view2.home_base,
display_service_view2.manager, display_service_view2.revenue, 
ingredients_carried, cost_carried, weight_carried
from display_service_view2
left outer JOIN display_service_view3
ON display_service_view2.id = display_service_view3.id;
