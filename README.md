## Description

The console application is designed to calculate expenses

## Must be installed for correct operation

ruby >= 3.0.0
bcrypt (gem install bcrypt)
io/console (gem install io-console)
terminal-table (gem install terminal-table)
mysql2 (gem install mysql2)
active_record (gem install activerecord)

## DB

Data source - MySQL

## DB connection settings

The path to the file to configure the database connection - "/Models/db.rb"

ActiveRecord::Base.establish_connection(
:adapter  => 'mysql2',
:database => your_db_name,
:username => username,
:password => password,
:host     => host)

## Start the application

cd /expenses_tracker
ruby main.rb

## Actions with user

After launching the program, you will see an instruction 
"Press 'n' for new user, 'l' to login, or 'x' to exit: ->"

n - create new user
l - log in
x - close application
Entering any other character will display an error "Invalid input"

## Create new user

After pressing 'n', you need to enter the login and password 2 times

The login can be anything, but not shorter than 4 characters
The password can be anything, but not shorter than 4 characters

If a user with this login already exists, you will see an error message
"User already exist."

If the user is successfully created, you will see a success message
"User created!"

## Log in

After pressing 'l', you need to enter the login and password

If a user with this login does not exist, you will see an error message
"User not found."
After that, the program will finish its work.

If you entered the wrong login, the program will ask you to try again. 
You will have three attempts to enter the correct password. 
After that, the program will finish its work.

If the login and password are entered correctly, 
you will see a message about successful authentication.
"Login successful!"
After that, a menu for interacting with expenses will be displayed.

## Menu for interacting with expenses

Press 'n' to add a new expense, 'l' to see a list of expenses, 'd' clear all expenses, or 'x' to exit: ->

n - add new expense
l - show expenses
d - delete all expenses
x - close application
Entering any other character will display an error "Invalid input"

## Add new expense

After pressing n, you will be prompted to enter the name of the category 
you want to make the expense into (example "food")
"Expense category?"

You will then see a message "How much did you spend?"
Enter the amount in 10 or 10.50 format.
If the amount input format is incorrect, 
you will see a message "Incorrect amount input format! The correct format is 10 or 10.50"
and an invitation to enter the amount again.


