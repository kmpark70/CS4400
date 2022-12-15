import mysql.connector
from tkinter import *
import Table

cnx = mysql.connector.connect(user='root',
                              password="",
                              host='localhost',
                              database='restaurant_supply_express')

cursor = cnx.cursor()

def add_user(username, fname, lname, address, bdate):
    if username == '':
        username = None
    if fname == '':
        fname = None
    if lname == '':
        fname = None
    if address == '':
        address = None
    if bdate == '':
        bdate = None
    
    add_query = ("INSERT INTO users "
               "(username, first_name, last_name, address, birthdate) "
               "VALUES (%s, %s, %s, %s, %s)")

    user_data = (username, fname, lname, address, bdate)

    cursor.execute(add_query, user_data)

    cnx.commit()

def call_add_owner(username, fname, lname, address, bdate):
    if username == '':
        username = None
    if fname == '':
        fname = None
    if lname == '':
        lname = None
    if address == '':
        address = None
    if bdate == '':
        bdate = None

    try:
        args = (username, fname, lname, address, bdate)
        print(args)
        cursor.callproc('add_owner', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_add_employee(username, fname, lname, address, bdate, taxID, hired, experience, salary):
    if username == '':
        username = None
    if fname == '':
        fname = None
    if lname == '':
        lname = None
    if address == '':
        address = None
    if bdate == '':
        bdate = None
    if taxID == '':
        taxID = None
    if hired == '':
        hired = None
    if experience == '':
        experience = None
    if salary == '':
        salary = None

    try:
        args = (username, fname, lname, address, bdate, taxID, hired, experience, salary)
        cursor.callproc('add_employee', args)
        cnx.commit()
    except Exception as e:
        print(e)


def call_add_pilot_role(username, licenseID, experience):
    if username == '':
        username = None
    if licenseID == '':
        licenseID = None
    if experience == '':
        experience = None

    try:
        args = (username, licenseID, experience)
        cursor.callproc('add_pilot_role', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_add_worker_role(username):
    if username == '':
        username = None
    
    try:
        args = [username]
        cursor.callproc('add_worker_role', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_add_ingredient(barcode, iname, weight):
    if barcode == '':
        barcode = None
    if iname == '':
        iname = None
    if weight == '':
        weight = None

    try:
        args = (barcode, iname, weight)
        cursor.callproc('add_ingredient', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_add_drone(drone_id, tag, fuel, capacity, sales, flown_by):
    if drone_id == '':
        drone_id = None
    if tag == '':
        tag = None
    if fuel == '':
        fuel = None
    if capacity == '':
        capacity = None
    if sales == '':
        sales = None
    if flown_by == '':
        flown_by = None

    try:
        args = (drone_id, tag, fuel, capacity, sales, flown_by)
        cursor.callproc('add_drone', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_add_restaurant(name, rating, spent, location):
    if name == '':
        name = None
    if rating == '':
        rating = None
    if spent == '':
        spent = None
    if location == '':
        location = None

    try:
        args = (name, rating, spent, location)
        cursor.callproc('add_restaurant', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_add_service(s_id, name, home_base, manager):
    if s_id == '':
        s_id = None
    if name == '':
        name = None
    if home_base == '':
        home_base = None
    if manager == '':
        manager = None

    try:
        args = (s_id, name, home_base, manager)
        cursor.callproc('add_service', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_add_location(label, x, y, space):
    if label == '':
        label = None
    if x == '':
        x = None
    if y == '':
        y = None
    if space == '':
        space = None

    try:
        args = (label, x, y, space)
        cursor.callproc('add_location', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_start_funding(owner, name):
    if owner == '':
        owner = None
    if name == '':
        name = None

    try:
        args = (owner, name)
        cursor.callproc('start_funding', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_hire_employee(username, e_id):
    if username == '':
        username = None
    if e_id == '':
        e_id = None

    try:
        args = (username, e_id)
        cursor.callproc('hire_employee', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_fire_employee(username, e_id):
    if username == '':
        username = None
    if e_id == '':
        e_id = None

    try:
        args = (username, e_id)
        cursor.callproc('fire_employee', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_manage_service(username, e_id):
    if username == '':
        username = None
    if e_id == '':
        e_id = None

    try:
        args = (username, e_id)
        cursor.callproc('manage_service', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_takeover_drone(username, d_id, tag):
    if username == '':
        username = None
    if d_id == '':
        d_id = None
    if tag == '':
        tag = None

    try:
        args = (username, d_id, tag)
        cursor.callproc('takeover_drone', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_join_swarm(d_id, tag, leader_tag):
    if d_id == '':
        d_id = None
    if tag == '':
        tag = None
    if leader_tag == '':
        leader_tag == None

    try:
        args = (d_id, tag, leader_tag)
        cursor.callproc('join_swarm', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_leave_swarm(d_id, swarm_tag):
    if d_id == '':
        d_id = None
    if swarm_tag == '':
        swarm_tag = None

    try:
        args = (d_id, swarm_tag)
        cursor.callproc('leave_swarm', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_load_drone(d_id, tag, barcode, packages, price):
    if d_id == '':
        d_id = None
    if tag == '':
        tag = None
    if barcode == '':
        barcode = None
    if packages == '':
        packages = None
    if price == '':
        price = None

    try:
        args = (d_id, tag, barcode, packages, price)
        cursor.callproc('load_drone', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_refuel_drone(d_id, tag, fuel):
    if d_id == '':
        d_id = None
    if tag == '':
        tag = None
    if fuel == '':
        fuel = None

    try:
        args = (d_id, tag, fuel)
        cursor.callproc('refuel_drone', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_fly_drone(d_id, tag, destination):
    if d_id == '':
        d_id = None
    if tag == '':
        tag = None
    if destination == '':
        destination = None

    try:
        args = (d_id, tag, destination)
        cursor.callproc('fly_drone', args)
        cnx.commit()
    except Exception as e:
        print(e)


def call_purchase_ingredient(name, i_id, tag, barcode, quantity):
    if name == '':
        name = None
    if i_id == '':
        i_id = None
    if barcode == '':
        barcode = None
    if quantity == '':
        quantity = None

    try:
        args = (name, i_id, tag, barcode, quantity)
        cursor.callproc('purchase_ingredient', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_remove_ingredient(barcode):
    if barcode == '':
        barcode = None

    try:
        args = [barcode]
        cursor.callproc('remove_ingredient', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_remove_drone(d_id, tag):
    if d_id == '':
        d_id = None
    if tag == '':
        tag = None

    try:
        args = (d_id, tag)
        cursor.callproc('remove_drone', args)
        cnx.commit()
    except Exception as e:
        print(e)

def call_remove_pilot_role(username):
    if username == '':
        username = None
    
    try:
        args = [username]
        cursor.callproc('remove_pilot_role', args)
        cnx.commit()
    except Exception as e:
        print(e)

def display_owner_view(root):
    cursor.callproc('proc_display_owner_view')
    select_query = ("SELECT * from display_owner_view")
    cursor.execute(select_query)
    table = Table.Table(root, cursor.fetchall(), cursor.column_names)
    
    
def display_employee_info_view(root):
    cursor.callproc('proc_display_employee_view')
    select_query = ("SELECT * from display_employee_view")
    cursor.execute(select_query)
    table = Table.Table(root, cursor.fetchall(), cursor.column_names)

def display_pilot_view(root):
    cursor.callproc('proc_display_pilot_view')
    select_query = ("SELECT * from display_pilot_view")
    cursor.execute(select_query)
    table = Table.Table(root, cursor.fetchall(), cursor.column_names)

def display_location_view(root):
    cursor.callproc('proc_display_location_view')
    select_query = ("SELECT * from display_location_view")
    cursor.execute(select_query)
    table = Table.Table(root, cursor.fetchall(), cursor.column_names)

def display_ingredient_view(root):
    cursor.callproc('proc_display_ingredient_view')
    select_query = ("SELECT * from display_ingredient_view")
    cursor.execute(select_query)
    table = Table.Table(root, cursor.fetchall(), cursor.column_names)

def display_service_view(root):
    cursor.callproc('proc_display_service_view')
    select_query = ("SELECT * from display_service_view")
    cursor.execute(select_query)
    table = Table.Table(root, cursor.fetchall(), cursor.column_names)

def display_delivery_services_table(root):
    select_query = ("SELECT * from delivery_services")
    cursor.execute(select_query)
    table = Table.Table(root, cursor.fetchall(), cursor.column_names)

def display_drones_table(root):
    select_query = ("SELECT * from drones")
    cursor.execute(select_query)
    table = Table.Table(root, cursor.fetchall(), cursor.column_names)

def display_employees_table(root):
    select_query = ("SELECT * from employees")
    cursor.execute(select_query)
    table = Table.Table(root, cursor.fetchall(), cursor.column_names)

def display_ingredients_table(root):
    select_query = ("SELECT * from ingredients")
    cursor.execute(select_query)
    table = Table.Table(root, cursor.fetchall(), cursor.column_names)

def display_locations_table(root):
    select_query = ("SELECT * from locations")
    cursor.execute(select_query)
    table = Table.Table(root, cursor.fetchall(), cursor.column_names)

def display_payload_table(root):
    select_query = ("SELECT * from payload")
    cursor.execute(select_query)
    table = Table.Table(root, cursor.fetchall(), cursor.column_names)

def display_pilots_table(root):
    select_query = ("SELECT * from pilots")
    cursor.execute(select_query)
    table = Table.Table(root, cursor.fetchall(), cursor.column_names)

def display_restaurant_owners_table(root):
    select_query = ("SELECT * from restaurant_owners")
    cursor.execute(select_query)
    table = Table.Table(root, cursor.fetchall(), cursor.column_names)

def display_restaurants_table(root):
    select_query = ("SELECT * from restaurants")
    cursor.execute(select_query)
    table = Table.Table(root, cursor.fetchall(), cursor.column_names)

def display_users_table(root):
    select_query = ("SELECT * from users")
    cursor.execute(select_query)
    table = Table.Table(root, cursor.fetchall(), cursor.column_names)

def display_workers_table(root):
    select_query = ("SELECT * from workers")
    cursor.execute(select_query)
    table = Table.Table(root, cursor.fetchall(), cursor.column_names)

def display_work_for_table(root):
    select_query = ("SELECT * from work_for")
    cursor.execute(select_query)
    table = Table.Table(root, cursor.fetchall(), cursor.column_names)
