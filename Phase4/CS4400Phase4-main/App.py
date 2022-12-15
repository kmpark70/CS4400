import tkinter as tk
from tkinter import *
import Connection
from datetime import date, datetime, timedelta


root = Tk()
root.geometry("900x700")


def home_page():
    delete_table(root.grid_slaves())
    remove_views()
    remove_procs()
    remove_input()
    remove_state()
    viewsbtn.place(relx=.5, rely=.4, anchor='center')
    procsbtn.place(relx=.5, rely=.5, anchor='center')
    statesbtn.place(relx=.5, rely=.6, anchor='center')
    home_page_text.place(relx=.5, rely=.1, anchor='center')


def view_page():
    viewsbtn.place_forget()
    procsbtn.place_forget()
    statesbtn.place_forget()
    home_page_text.place_forget()

    remove_views()
    remove_procs()
    remove_input()
    remove_state()

    owner_view_button.place(relx=.42, rely=.4, anchor='center')
    employee_info_view_button.place(relx=.42, rely=.5, anchor='center')
    pilot_view_button.place(relx=.42, rely=.6, anchor='center')
    location_view_button.place(relx=.58, rely=.4, anchor='center')
    ingredient_view_button.place(relx=.58, rely=.5, anchor='center')
    service_view_button.place(relx=.58, rely=.6, anchor='center')

def state_page():
    viewsbtn.place_forget()
    procsbtn.place_forget()
    statesbtn.place_forget()
    home_page_text.place_forget()

    remove_views()
    remove_procs()
    remove_input()
    remove_state()

    service_state_button.place(relx=.30, rely=.3, anchor='center')
    drone_state_button.place(relx=.30, rely=.4, anchor='center')
    employee_state_button.place(relx=.30, rely=.5, anchor='center')
    ingredient_state_button.place(relx=.30, rely=.6, anchor='center')
    location_state_button.place(relx=.50, rely=.3, anchor='center')
    payload_state_button.place(relx=.50, rely=.4, anchor='center')
    pilot_state_button.place(relx=.50, rely=.5, anchor='center')
    restaurant_owner_state_button.place(relx=.50, rely=.6, anchor='center')
    restaurant_state_button.place(relx=.70, rely=.3, anchor='center')
    user_state_button.place(relx=.70, rely=.4, anchor='center')
    worker_state_button.place(relx=.70, rely=.5, anchor='center')
    work_for_state_button.place(relx=.70, rely=.6, anchor='center')

def remove_state():
    service_state_button.place_forget()
    drone_state_button.place_forget()
    employee_state_button.place_forget()
    ingredient_state_button.place_forget()
    location_state_button.place_forget()
    payload_state_button.place_forget()
    pilot_state_button.place_forget()
    restaurant_owner_state_button.place_forget()
    restaurant_state_button.place_forget()
    user_state_button.place_forget()
    worker_state_button.place_forget()
    work_for_state_button.place_forget()

def remove_views():
    home_page_text.place_forget()
    owner_view_button.place_forget()
    employee_info_view_button.place_forget()
    pilot_view_button.place_forget()
    location_view_button.place_forget()
    ingredient_view_button.place_forget()
    service_view_button.place_forget()


def display_owner_view():
    remove_views()
    delete_table(root.grid_slaves())
    table = Connection.display_owner_view(root)


def display_employee_info_view():
    remove_views()
    delete_table(root.grid_slaves())
    table = Connection.display_employee_info_view(root)


def display_pilot_view():
    remove_views()
    delete_table(root.grid_slaves())
    table = Connection.display_pilot_view(root)


def display_location_view():
    remove_views()
    delete_table(root.grid_slaves())
    table = Connection.display_location_view(root)


def display_ingredient_view():
    remove_views()
    delete_table(root.grid_slaves())
    table = Connection.display_ingredient_view(root)


def display_service_view():
    remove_views()
    delete_table(root.grid_slaves())
    table = Connection.display_service_view(root)


def delete_table(table):
    for t in table:
        t.grid_remove()


def proc_page():
    viewsbtn.place_forget()
    procsbtn.place_forget()
    statesbtn.place_forget()

    remove_views()
    remove_procs()
    remove_input()
    remove_state()

    owner_button.place(relx=.3, rely=.3, anchor='center')
    user_button.place(relx=.3, rely=.4, anchor='center')
    employee_button.place(relx=.3, rely=.5, anchor='center')
    pilot_button.place(relx=.3, rely=.6, anchor='center')
    drone_button.place(relx=.5, rely=.3, anchor='center')
    service_button.place(relx=.5, rely=.4, anchor='center')
    restaurant_button.place(relx=.5, rely=.5, anchor='center')
    ingredient_button.place(relx=.5, rely=.6, anchor='center')
    location_button.place(relx=.7, rely=.3, anchor='center')
    worker_button.place(relx=.7, rely=.4, anchor='center')
    workfor_button.place(relx=.7, rely=.5, anchor='center')
    payload_button.place(relx=.7, rely=.6, anchor='center')


def remove_procs():
    owner_button.place_forget()
    user_button.place_forget()
    employee_button.place_forget()
    pilot_button.place_forget()
    drone_button.place_forget()
    service_button.place_forget()
    restaurant_button.place_forget()
    ingredient_button.place_forget()
    location_button.place_forget()
    worker_button.place_forget()
    workfor_button.place_forget()
    payload_button.place_forget()

    lblname.config(text="Name:")


def remove_input():
    lblusername.place_forget()
    Username.place_forget()
    lblfname.place_forget()
    Fname.place_forget()
    lbllname.place_forget()
    Lname.place_forget()
    lbladdress.place_forget()
    Address.place_forget()
    lblbirthdate.place_forget()
    Birthdate.place_forget()
    lbltaxid.place_forget()
    Taxid.place_forget()
    lblhired.place_forget()
    Hired.place_forget()
    lblexperience.place_forget()
    Experience.place_forget()
    lblsalary.place_forget()
    Salary.place_forget()
    lbllicense.place_forget()
    License.place_forget()
    lblpilotexp.place_forget()
    PilotExp.place_forget()
    lblbarcode.place_forget()
    Barcode.place_forget()
    lblname.place_forget()
    Name.place_forget()
    lblweight.place_forget()
    Weight.place_forget()
    lblid.place_forget()
    Id.place_forget()
    lbldronetag.place_forget()
    Dronetag.place_forget()
    lblfuel.place_forget()
    Fuel.place_forget()
    lblcapacity.place_forget()
    Capacity.place_forget()
    lblsales.place_forget()
    Sales.place_forget()
    lblflownby.place_forget()
    Flownby.place_forget()
    lblrating.place_forget()
    Rating.place_forget()
    lblspent.place_forget()
    Spent.place_forget()
    lbllocation.place_forget()
    Location.place_forget()
    lblfundedby.place_forget()
    Fundedby.place_forget()
    lblmanager.place_forget()
    Manager.place_forget()
    lblx_coord.place_forget()
    X_coord.place_forget()
    lbly_coord.place_forget()
    Y_coord.place_forget()
    lblspace.place_forget()
    Space.place_forget()
    lblswarm.place_forget()
    Swarm.place_forget()
    lblquantity.place_forget()
    Quantity.place_forget()
    lblprice.place_forget()
    Price.place_forget()

    add_button.place_forget()
    update_button.place_forget()
    remove_button.place_forget()
    update_button_2.place_forget()
    update_button_3.place_forget()
    update_button_4.place_forget()
    update_button_5.place_forget()


def owner():
    remove_procs()

    lblusername.place(x=150, y=60)
    Username.place(x=250, y=60, width=100)

    lblfname.place(x=350, y=60)
    Fname.place(x=450, y=60, width=100)

    lbllname.place(x=550, y=60)
    Lname.place(x=650, y=60, width=100)

    lbladdress.place(x=300, y=100)
    Address.place(x=400, y=100, width=100)

    lblbirthdate.place(x=500, y=100)
    Birthdate.place(x=600, y=100, width=100)

    add_button.configure(command=lambda: Connection.call_add_owner(Username.get(), Fname.get(
    ), Lname.get(), Address.get(), Birthdate.get()), text="Call add_owner")
    add_button.place(x=300, y=300)


def user():
    remove_procs()

    lblusername.place(x=150, y=60)
    Username.place(x=250, y=60, width=100)

    lblfname.place(x=350, y=60)
    Fname.place(x=450, y=60, width=100)

    lbllname.place(x=550, y=60)
    Lname.place(x=650, y=60, width=100)

    lbladdress.place(x=300, y=100)
    Address.place(x=400, y=100, width=100)

    lblbirthdate.place(x=500, y=100)
    Birthdate.place(x=600, y=100, width=100)

    add_button.configure(command=lambda: Connection.add_user(Username.get(), Fname.get(), Lname.get(), Address.get(), Birthdate.get()), text="Call add_user")
    add_button.place(x=300, y=300)


def employee():
    remove_procs()

    lblusername.place(x=150, y=60)
    Username.place(x=250, y=60, width=100)

    lblfname.place(x=350, y=60)
    Fname.place(x=450, y=60, width=100)

    lbllname.place(x=550, y=60)
    Lname.place(x=650, y=60, width=100)

    lbladdress.place(x=200, y=100)
    Address.place(x=300, y=100, width=100)

    lblbirthdate.place(x=400, y=100)
    Birthdate.place(x=500, y=100, width=100)

    lbltaxid.place(x=600, y=100)
    Taxid.place(x=700, y=100, width=100)

    lblhired.place(x=150, y=140)
    Hired.place(x=250, y=140, width=100)

    lblexperience.place(x=350, y=140)
    Experience.place(x=450, y=140, width=100)

    lblsalary.place(x=550, y=140)
    Salary.place(x=650, y=140, width=100)

    add_button.configure(command=lambda: Connection.call_add_employee(Username.get(), Fname.get(
    ), Lname.get(), Address.get(), Birthdate.get(),
        Taxid.get(), Hired.get(), Experience.get(), Salary.get()), text="Call add_employee")
    add_button.place(x=300, y=300)


def pilot():
    remove_procs()

    lblusername.place(x=150, y=60)
    Username.place(x=250, y=60, width=100)

    lbllicense.place(x=350, y=60)
    License.place(x=450, y=60, width=100)

    lblpilotexp.place(x=550, y=60)
    PilotExp.place(x=650, y=60, width=100)

    add_button.configure(command=lambda: Connection.call_add_pilot_role(
        Username.get(), License.get(), PilotExp.get()),
                         text="Call add_pilot_role")
    add_button.place(x=300, y=300)

    remove_button.configure(command=lambda: Connection.call_remove_pilot_role(Username.get()), text="Call remove_pilot_role")
    remove_button.place(x=500, y=300)


def worker():
    remove_procs()
    lblusername.place(x=150, y=60)
    Username.place(x=250, y=60, width=100)

    add_button.configure(command=lambda: Connection.call_add_worker_role(Username.get()),
                         text="Call add_worker_role")
    add_button.place(x=300, y=300)


def drone():
    remove_procs()
    lblid.place(x=150, y=60)
    Id.place(x=250, y=60, width=100)

    lbldronetag.place(x=350, y=60)
    Dronetag.place(x=450, y=60, width=100)

    lblfuel.place(x=550, y=60)
    Fuel.place(x=650, y=60, width=100)

    lblcapacity.place(x=100, y=100)
    Capacity.place(x=200, y=100, width=100)

    lblsales.place(x=300, y=100)
    Sales.place(x=400, y=100, width=100)

    lblflownby.place(x=500, y=100)
    Flownby.place(x=600, y=100, width=100)

    lblswarm.place(x=700, y=100)
    Swarm.place(x=800, y=100, width=100)

    lbllocation.place(x=150, y=140)
    Location.place(x=250, y=140, width=100)

    add_button.configure(command=lambda: Connection.call_add_drone(
        Id.get(), Dronetag.get(), Fuel.get(), Capacity.get(), Sales.get(), Flownby.get()), text="Call add_drone")
    add_button.place(x=300, y=300)

    update_button.config(command=lambda: Connection.call_takeover_drone(Flownby.get(), Id.get(), Dronetag.get()),
                         text="Call takeover_drone")
    update_button.place(x=500, y=300)

    update_button_2.config(command=lambda: Connection.call_join_swarm(
        Id.get(), Dronetag.get(), Swarm.get()), text="Call join_swarm")
    update_button_2.place(x=200, y=400)

    update_button_3.config(
        command=lambda: Connection.call_leave_swarm(Id.get(), Dronetag.get()), text="Call leave_swarm")
    update_button_3.place(x=400, y=400)

    update_button_4.config(text="Call refuel_drone", command=lambda: Connection.call_refuel_drone(Id.get(), Dronetag.get(), Fuel.get()))
    update_button_4.place(x=600, y=400)

    update_button_5.config(text="Call fly_drone", command=lambda: Connection.call_fly_drone(Id.get(), Dronetag.get(), Location.get()))
    update_button_5.place(x=300, y = 500)

    remove_button.config(text="Call remove_drone", command=lambda: Connection.call_remove_drone(Id.get(), Dronetag.get()))
    remove_button.place(x=500, y=500)


def service():
    remove_procs()

    lblid.place(x=150, y=60)
    Id.place(x=250, y=60, width=100)

    lblname.place(x=350, y=60)
    Name.place(x=450, y=60, width=100)

    lbllocation.place(x=150, y=100)
    Location.place(x=250, y=100, width=100)

    lblmanager.place(x=350, y=100)
    Manager.place(x=450, y=100, width=100)

    add_button.configure(command=lambda: Connection.call_add_service(
        Id.get(), Name.get(), Location.get(), Manager.get()), text="Call add_service")
    add_button.place(x=300, y=300)

    update_button.configure(command=lambda:     Connection.call_manage_service(Username.get(), Id.get()),
                            text="Call manage_service")
    update_button.place(x=500, y=300)


def restaurant():
    remove_procs()
    lblname.place(x=150, y=60)
    Name.place(x=250, y=60, width=100)

    lbllocation.place(x=350, y=60)
    Location.place(x=450, y=60, width=100)

    lblrating.place(x=550, y=60)
    Rating.place(x=650, y=60, width=100)

    lblspent.place(x=300, y=100)
    Spent.place(x=400, y=100, width=100)

    lblfundedby.place(x=500, y=100)
    Fundedby.place(x=600, y=100)

    add_button.configure(command=lambda: Connection.call_add_restaurant(
        Name.get(), Rating.get(), Spent.get(), Location.get()),
                         text="Call add_restaurant")
    add_button.place(x=300, y=300)

    update_button.config(text="Call start_funding", command=lambda: Connection.call_start_funding(
        Fundedby.get(), Name.get()
    ))
    update_button.place(x=450, y=300)


def ingredient():
    remove_procs()
    lblbarcode.place(x=150, y=60)
    Barcode.place(x=250, y=60, width=100)

    lblname.place(x=350, y=60)
    Name.place(x=450, y=60, width=100)

    lblweight.place(x=550, y=60)
    Weight.place(x=650, y=60, width=100)

    add_button.configure(command=lambda: Connection.call_add_ingredient(
        Barcode.get(), Name.get(), Weight.get()),
                         text="Call add_ingredient")
    add_button.place(x=300, y=300)

    remove_button.configure(text="Call remove_ingredient", command=lambda: Connection.call_remove_ingredient(Barcode.get()))
    remove_button.place(x=500, y=300)


def location():
    remove_procs()
    lblname.place(x=150, y=60)
    Name.place(x=250, y=60, width=100)

    lblx_coord.place(x=350, y=60)
    X_coord.place(x=450, y=60, width=100)

    lbly_coord.place(x=150, y=100)
    Y_coord.place(x=250, y=100, width=100)

    lblspace.place(x=350, y=100)
    Space.place(x=450, y=100, width=100)

    add_button.configure(command=lambda: Connection.call_add_location(
        Name.get(), X_coord.get(), Y_coord.get(), Space.get()), text="Call add_location")
    add_button.place(x=300, y=300)


def work_for():
    remove_procs()
    lblusername.place(x=250, y=100)
    Username.place(x=350, y=100, width=100)

    lblid.place(x=450, y=100)
    Id.place(x=550, y=100, width=100)

    add_button.configure(command=lambda: Connection.call_hire_employee(
        Username.get(), Id.get()), text="Call hire_employee")
    add_button.place(x=300, y=300)

    remove_button.config(command=lambda: Connection.call_fire_employee(
        Username.get(), Id.get()), text="Call fire_employee")
    remove_button.place(x=500, y=300)


def payload():
    remove_procs()

    lblid.place(x=150, y=60)
    Id.place(x=250, y=60, width=100)

    lbldronetag.place(x=350, y=60)
    Dronetag.place(x=450, y=60, width=100)

    lblbarcode.place(x=550, y=60)
    Barcode.place(x=650, y=60, width=100)

    lblquantity.place(x=150, y=100)
    Quantity.place(x=250, y=100, width=100)

    lblprice.place(x=350, y=100)
    Price.place(x=450, y=100, width=100)

    lblname.place(x=550, y=100)
    lblname.config(text="Restaurant:")
    Name.place(x=650, y=100, width=100)

    add_button.config(command=lambda: Connection.call_load_drone(Id.get(), Dronetag.get(
    ), Barcode.get(), Quantity.get(), Price.get()), text="Call load_drone")
    add_button.place(x=300, y=300)

    update_button.config(text="Call purchase_ingredient", command=lambda: Connection.call_purchase_ingredient(Name.get(), Id.get(), Dronetag.get(), Barcode.get(), Quantity.get()))
    update_button.place(x=500, y=300)


def service_state():
    remove_state()
    delete_table(root.grid_slaves())
    table = Connection.display_delivery_services_table(root)

def drones_state():
    remove_state()
    delete_table(root.grid_slaves())
    table = Connection.display_drones_table(root)

def employee_state():
    remove_state()
    delete_table(root.grid_slaves())
    table = Connection.display_employees_table(root)

def ingredient_state():
    remove_state()
    delete_table(root.grid_slaves())
    table = Connection.display_ingredients_table(root)

def location_state():
    remove_state()
    delete_table(root.grid_slaves())
    table = Connection.display_locations_table(root)    

def employee_state():
    remove_state()
    delete_table(root.grid_slaves())
    table = Connection.display_employees_table(root)

def payload_state():
    remove_state()
    delete_table(root.grid_slaves())
    table = Connection.display_payload_table(root)

def pilot_state():
    remove_state()
    delete_table(root.grid_slaves())
    table = Connection.display_pilots_table(root)

def restaurant_owner_state():
    remove_state()
    delete_table(root.grid_slaves())
    table = Connection.display_restaurant_owners_table(root)

def restaurant_state():
    remove_state()
    delete_table(root.grid_slaves())
    table = Connection.display_restaurants_table(root)

def user_state():
    remove_state()
    delete_table(root.grid_slaves())
    table = Connection.display_users_table(root)

def worker_state():
    remove_state()
    delete_table(root.grid_slaves())
    table = Connection.display_workers_table(root)

def work_for_state():
    remove_state()
    delete_table(root.grid_slaves())
    table = Connection.display_work_for_table(root)


# These will be on every page
home_page_text = tk.Label(
    root, text="Restaurant Supply Express", font=('System', 30, 'bold'))
home_page_text.place(relx=.5, rely=.1, anchor='center')
homebtn = tk.Button(root, text="Main Screen", command=home_page)
homebtn.place(relx=.1, rely=.9, anchor='center')

# These are on the home page
viewsbtn = tk.Button(root, text="Display views", command=view_page)
procsbtn = tk.Button(root, text="Modify Database", command=proc_page)
statesbtn = tk.Button(root, text="View Database states", command=state_page)
viewsbtn.place(relx=.5, rely=.4, anchor='center')
procsbtn.place(relx=.5, rely=.5, anchor='center')
statesbtn.place(relx=.5,rely=.6, anchor='center')

# Buttons on the views page
owner_view_button = tk.Button(
    root, text="Owner View", bg='blue', command=display_owner_view)
employee_info_view_button = tk.Button(
    root, text="Employee View", bg='blue', command=display_employee_info_view)
pilot_view_button = tk.Button(
    root, text="Pilot View", bg='blue', command=display_pilot_view)
location_view_button = tk.Button(
    root, text="Location View", bg='blue', command=display_location_view)
ingredient_view_button = tk.Button(
    root, text="Ingredient View", bg='blue', command=display_ingredient_view)
service_view_button = tk.Button(
    root, text="Service View", bg='blue', command=display_service_view)

# Buttons on the procs page
owner_button = tk.Button(root, text="Owner", command=owner)
user_button = tk.Button(root, text="User", command=user)
employee_button = tk.Button(root, text="Employee", command=employee)
pilot_button = tk.Button(root, text="Pilot", command=pilot)
drone_button = tk.Button(root, text="Drone", command=drone)
service_button = tk.Button(root, text="Service", command=service)
restaurant_button = tk.Button(root, text="Restaurant", command=restaurant)
ingredient_button = tk.Button(root, text="Ingredient", command=ingredient)
location_button = tk.Button(root, text="Location", command=location)
worker_button = tk.Button(root, text="Worker", command=worker)
workfor_button = tk.Button(root, text="Works For", command=work_for)
payload_button = tk.Button(root, text="Payload", command=payload)

# Buttons on the state page
service_state_button = tk.Button(root, text="Delivery service table", command = service_state)
drone_state_button = tk.Button(root, text="Drones table", command=drones_state)
employee_state_button = tk.Button(root, text="Employees table", command=employee_state)
ingredient_state_button = tk.Button(root, text="Ingredients table", command=ingredient_state)
location_state_button = tk.Button(root, text="Locations table", command=location_state)
payload_state_button = tk.Button(root, text="Payload table", command=payload_state)
pilot_state_button = tk.Button(root, text="Pilots table", command=pilot_state)
restaurant_owner_state_button = tk.Button(root, text="Restaurant owners table", command=restaurant_owner_state)
restaurant_state_button = tk.Button(root, text="Restaurants table", command=restaurant_state)
user_state_button = tk.Button(root, text="Users table", command=user_state)
worker_state_button = tk.Button(root, text="Workers table", command=worker_state)
work_for_state_button = tk.Button(root, text="Work for table", command=work_for_state)

# Input Buttons/Entries
add_button = tk.Button(root, text="Add")
update_button = tk.Button(
    root)
remove_button = tk.Button(root, text="Remove")
update_button_2 = tk.Button(root)
update_button_3 = tk.Button(root)
update_button_4 = tk.Button(root)
update_button_5 = tk.Button(root)

lblusername = tk.Label(root, text="Username:", )
Username = tk.Entry(root, width=35)
lblfname = tk.Label(root, text="First Name:", )
Fname = tk.Entry(root, width=35)
lbllname = tk.Label(root, text="Last Name:", )
Lname = tk.Entry(root, width=35)
lbladdress = tk.Label(root, text="Address:", )
Address = tk.Entry(root, width=35)
lblbirthdate = tk.Label(root, text="Birthdate:", )
Birthdate = tk.Entry(root, width=35)
lbltaxid = tk.Label(root, text="Tax Id:", )
Taxid = tk.Entry(root, width=35)
lblhired = tk.Label(root, text="Hired:", )
Hired = tk.Entry(root, width=35)
lblexperience = tk.Label(root, text="Experience:", )
Experience = tk.Entry(root, width=35)
lblsalary = tk.Label(root, text="Salary:", )
Salary = tk.Entry(root, width=35)
lbllicense = tk.Label(root, text="License:", )
License = tk.Entry(root, width=35)
lblpilotexp = tk.Label(root, text="Pilot Experience:", )
PilotExp = tk.Entry(root, width=35)
lblbarcode = tk.Label(root, text="Barcode:", )
Barcode = tk.Entry(root, width=35)
lblname = tk.Label(root, text="Name:", )
Name = tk.Entry(root, width=35)
lblweight = tk.Label(root, text="Weight:", )
Weight = tk.Entry(root, width=35)
lblid = tk.Label(root, text="Id:", )
Id = tk.Entry(root, width=35)
lbldronetag = tk.Label(root, text="Tag:", )
Dronetag = tk.Entry(root, width=35)
lblfuel = tk.Label(root, text="Fuel:", )
Fuel = tk.Entry(root, width=35)
lblcapacity = tk.Label(root, text="Capacity:", )
Capacity = tk.Entry(root, width=35)
lblsales = tk.Label(root, text="Sales:", )
Sales = tk.Entry(root, width=35)
lblflownby = tk.Label(root, text="FlownBy:")
Flownby = tk.Entry(root, width=35)
lblrating = tk.Label(root, text="Rating:")
Rating = tk.Entry(root, width=35)
lblspent = tk.Label(root, text="Spent:")
Spent = tk.Entry(root, width=35)
lbllocation = tk.Label(root, text="Location:")
Location = tk.Entry(root, width=35)
lblfundedby = tk.Label(root, text="Funded By:")
Fundedby = tk.Entry(root)
lblmanager = tk.Label(root, text="Manager:")
Manager = tk.Entry(root)
lblx_coord = tk.Label(root, text="X_coord:")
X_coord = tk.Entry(root)
lbly_coord = tk.Label(root, text="Y_coord:")
Y_coord = tk.Entry(root)
lblspace = tk.Label(root, text="Space:")
Space = tk.Entry(root)
lblswarm = tk.Label(root, text="Swarm tag:")
Swarm = tk.Entry(root)
lblquantity = tk.Label(root, text="Quantity:")
Quantity = tk.Entry(root)
lblprice = tk.Label(root, text="Price")
Price = tk.Entry(root)

root.mainloop()
