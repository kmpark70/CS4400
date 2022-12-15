
# CS 4400 Phase 4 Project Description 

## 1. Setup Instructions
    a.) Open MySQL with the Phase 2 solution and the procedure SQL file
    b.) Run both scripts and refresh the schemas
## 2. How to Run the App
	a.) Download the zip to your local machine
	b.) cd into the project directory
    c.) Enter your MySQL password on line 6 in Connection.py
    d.) Run python3 App.py
## 3. Technologies Used 
**-Tkinter**: For most of the frontend of the GUI application we used the tkinter, which is a package within Python for creating GUIs. We used a series of functions to        create views that align with the Phase 3 requirements. Within these views, we used the .place() function to plave buttons on the GUI and the .place_forget()              function to remove these when switching views. We largely placed buttons using relative x and y coordinates, designating colors where applicable. Throughout each function,        there is the remove_procs() function at the beginning to ensure that all previous calls are wiped, preventing a crash. Finally, we included a series of code that        displays on every page, which includes labels (.Label()), and buttons (.Button()). This all connects to the root, defined at the beginning as Tk(). <br /> <br />
**-MySQL Connector/Python**: We established a connection to Python with the MySQL Connector package, which connects to the user's local root SQL with the 'restaurant_supply_express' database. There are a series of functions, each with corresponding SQL stored procedures or views. These functions call the stored procedures from Phase 3 using the .callproc() module. The view functions include a query that selects everything from the existing table in SQL using the .fetchall() module and creates an equivalent table in Python to display in the GUI. All of these backend codes are then connected to the frontend Tkinter buttons and views to create the final GUI.                  
## 4. Distribution of Work
**-Sammy**: Developed the framework and coded the frontend GUI, including the buttons, labels, and views. He also coded the backend view calls. <br /> <br />
**-Anh**: Merged the frontend and backend as well as test out the final GUI. She also helped code the frontent GUI. <br /> <br />
**-Ishani**: Coded all of the backend calls to stored procedures and tested out all backend/the final GUI. She also wrote the ReadMe file. <br />
