## Description

The console application is designed to calculate expenses <br />

## Must be installed for correct operation

ruby >= 3.0.0 <br />
bcrypt (gem install bcrypt) <br />
io/console (gem install io-console) <br />
terminal-table (gem install terminal-table) <br />
mysql2 (gem install mysql2) <br />
active_record (gem install activerecord) <br />

## DB

Data source - MySQL

## DB connection settings

The path to the file to configure the database connection - "/Models/db.rb" <br />

ActiveRecord::Base.establish_connection(<br />
:adapter  => 'mysql2',<br />
:database => your_db_name,<br />
:username => username,<br />
:password => password,<br />
:host     => host)<br />

## Start the application

cd /expenses_tracker<br />
ruby main.rb<br />

## Actions with user

After launching the program, you will see an instruction <br />
"Press 'n' for new user, 'l' to login, or 'x' to exit: ->"<br />

n - create new user<br />
l - log in<br />
x - close application<br />
Entering any other character will display an error "Invalid input"<br />

## Create new user

After pressing 'n', you need to enter the login and password 2 times<br />

The login can be anything, but not shorter than 4 characters<br />
The password can be anything, but not shorter than 4 characters<br />

If a user with this login already exists, you will see an error message<br />
"User already exist."<br />

If the user is successfully created, you will see a success message<br />
"User created!"<br />

## Log in

After pressing 'l', you need to enter the login and password<br />

If a user with this login does not exist, you will see an error message<br />
"User not found."<br />
After that, the program will finish its work.<br />

If you entered the wrong login, the program will ask you to try again.<br /> 
You will have three attempts to enter the correct password. <br />
After that, the program will finish its work.<br />

If the login and password are entered correctly, <br />
you will see a message about successful authentication.<br />
"Login successful!"<br />
After that, a menu for interacting with expenses will be displayed.<br />

## Menu for interacting with expenses

Press 'n' to add a new expense, 'l' to see a list of expenses, 'd' clear all expenses, or 'x' to exit: -><br />

n - add new expense<br />
l - show expenses<br />
d - delete all expenses<br />
x - close application<br />
Entering any other character will display an error "Invalid input"<br />

## Add new expense

After pressing 'n', you will be prompted to enter the name of the category <br />
you want to make the expense into (example "food")<br />
"Expense category?"<br />
If the category name is not specified, you will see an error message "Incorrect input! Please enter a category name"<br />
You will then be prompted to re-enter the category name.<br />

You will then see a message "How much did you spend?"<br />
Enter the amount in 10 or 10.50 format.<br />
If the amount input format is incorrect, <br />
you will see a message "Incorrect amount input format! The correct format is 10 or 10.50"<br />
and an invitation to enter the amount again.<br />

You will then see a message "Enter the date of payment in the format DD.MM.YYYY, for example, 14.08.2022 (empty field - today)"<br />
You must enter the expense date in the desired format or leave the field blank and press 'enter'.<br />
If you enter a date in the wrong format, the expense will be recorded on today's date.<br />

## Show expenses

After pressing 'l', you will see instruction<br />
"To see the list of expenses, enter the period and categories of expenses in the command line.<br />
For example, to see expenses for a month by category of food, you need to enter:'08.2022 food'.<br />
To see expenses for a specific date for all categories:'08.12.2022'<br />
If the input is empty, you will see a list of all expenses"<br />

To see expenses for the year by category, enter the date in YYYY format and the name of the category separated by a space (example - 2022 food).<br />
To see expenses for the year in all categories, enter the date in YYYY format (example - 2022).<br />

To see expenses for the month by category, enter the date in MM.YYYY format and the name of the category separated by a space (example - 08.2022 food).<br />
To see expenses for the month in all categories, enter the date in MM.YYYY format (example - 08.2022).<br />

To see expenses for the date by category, enter the date in DD.MM.YYYY format and the name of the category separated by a space (example - 12.08.2022 food).<br />
To see expenses for the date in all categories, enter the date in DD.MM.YYYY format (example - 12.08.2022).<br />

If you entered an invalid date (example - 46.05.2018), you will see an error message "Invalid date!"<br />
and return to the instruction.<br />

If the input is correct, you will see a table with the results and return to the previous menu<br />
An example of a table:<br />
+--------------------------------+
|       Expenses for 2022        |
+----------+------------+--------+
| Category | Date       | Amount |
+----------+------------+--------+
| joy      | 2022-08-14 | 250.0  |
| food     | 2022-08-14 | 40.0   |
| dancing  | 2022-06-15 | 12.4   |
| food     | 2022-06-14 | 15.0   |
| food     | 2022-08-15 | 5.0    |
| ff       | 2022-08-15 | 5.0    |
+----------+------------+--------+
| Total amount          | 327.4  |
+-----------------------+--------+


## Delete expenses

After pressing 'd', you will see instruction<br />
"Are you sure you want to clear the expense list? If you agree, enter 'y'. To cancel, enter 'n'"<br />

If you press 'n' you will return to the previous menu.<br />

If you press y, the entire list of your expenses will be cleared, you will see a message "The expense list has been cleared successfully."<br />
and return to the previous menu.<br />

Entering any other character will display an error "Invalid input"<br />




