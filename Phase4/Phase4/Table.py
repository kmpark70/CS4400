from tkinter import *

# print(myresult)


class Table:

    def __init__(self, root, relations, headers):
        total_rows = len(relations)
        total_columns = len(relations[0])
        for i in range(len(headers)):
            self.e = Entry(root, width=10, fg='blue',
                           font=('Arial', 16, 'bold'))
            self.e.grid(row=0, column=i)
            self.e.insert(END, headers[i] if headers[i] else "None")
        # code for creating table
        for i in range(total_rows):
            for j in range(total_columns):

                self.e = Entry(root, width=10, fg='black',
                               font=('Arial', 16, 'bold'))
                self.e.grid(row=i + 1, column=j)
                self.e.insert(END, relations[i][j]
                              if relations[i][j] else "None")

# find total number of rows and
# columns in list
# create root window
