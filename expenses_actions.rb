require 'terminal-table'
require_relative './Models/expense'
require_relative 'helpers'

# creating a new expense
def add_expense
  puts 'Expense category?'
  expense_category = STDIN.gets.chomp

  puts 'How much did you spend?'
  expense_amount = STDIN.gets.to_f

  puts 'Enter the date of payment in the format DD.MM.YYYY, for example, 14.08.2022 ' \
            '(empty field - today)'
  date_input = STDIN.gets.chomp
  # if the user did not enter a date, we consider today's date as the date of expense
  if date_input == ''
    expense_date = Date.today
  else
    # if the date is valid, we use it, if not, we consider today's date as the date of expense
    begin
      expense_date = Date.parse(date_input)
    rescue ArgumentError
      expense_date = Date.today
    end
  end
  # attempt to create an expense
  begin
    Expense.create(user_id: $user.id, amount: expense_amount, category: expense_category, date: expense_date)
    puts 'Expense successfully added.'
  rescue
    puts 'Error! Expense not created!'
  end
end

# delete user expenses
def delete_expenses
    # ask if the user really agrees to delete all his expenses
    instructions = "Are you sure you want to clear the expense list? If you agree, enter 'y'. To cancel, enter 'n'"
    print_instructions(instructions)
    valid_clear_input = %w[y n]
    user_clear_input = STDIN.gets.chomp
    if !valid_clear_input.include? user_clear_input
        puts 'Invalid input'
        return 0
    # if the user does not want to delete costs, we interrupt the execution of the function
    elsif user_clear_input == 'n'
        return 0
    # the user agrees to remove all expenses
    elsif user_clear_input == 'y'
        # get a list of all user expenses
        user_expenses = $user.expenses
        if user_expenses.size > 0
            user_expenses.each{ |expense| expense.delete }
            puts 'The expense list has been cleared successfully.'
        else
            puts 'The expense list is empty.'
        end
    end
end

# checking the correctness of the input of arguments by the user for finding expenses
def validate_show_expenses_date_input(input)
    input_args = input.split

    # checking for the correct number of arguments
    if input_args.size > 2
        puts "You entered more than 2 arguments. The command supports only 2 arguments date and category name."
        return 0
    # verification of correct date input
    elsif input_args[0].match(/^(\d{2}\.){0,2}+\d{4}$/) == nil
        puts "Invalid date format. Possible formats: DD.MM.YYYY, MM.YYYY, YYYY"
    # attempt to parse the date
    else
        begin
            DateTime.parse(input_args[0])
            return 1
        rescue ArgumentError
            puts "Invalid date!"
            return 0
        end
    end
end

# print a table with the results of the search for expenses
def print_expenses_result_table(expenses, title, total_amount)
    # formation of rows with information about costs
    rows = []
    expenses.each{ |expense|
        rows << [expense.category, expense.date, expense.amount]
    }
    # creating a table to display the results
    table = Terminal::Table.new
    # assigning a table header
    table.title = title
    # assigning row headers
    table.headings = ['Category', 'Date', 'Amount']
    table.rows = rows
    # output of the resulting row
    table.add_separator
    table.add_row [{ :value => 'Total amount', :colspan => 2}, { :value => total_amount, :alignment => :left }]
    # printing of the completed table
    puts table
end

# calculation of the total amount of expenses
def get_expenses_total_amount(expenses)
    total_amount = 0
    expenses.each{ |expense|
        total_amount += expense.amount
    }
    return total_amount
end

# finding expenses for a specific year
def show_expenses_by_year(desired_year, category = nil)
    if category
        expenses = $user.expenses.where('extract(year  from date) = ? and category = ?', desired_year, category)
        title = "Expenses for #{desired_year} by #{category} category"
    else
        expenses = $user.expenses.where('extract(year  from date) = ?', desired_year)
        title = "Expenses for #{desired_year}"
    end
    total_amount = get_expenses_total_amount(expenses)
    print_expenses_result_table(expenses, title, total_amount)
end

# finding expenses for a specific month
def show_expenses_by_month(desired_date, category = nil)
    date = '01.' << desired_date
    d = DateTime.parse(date)
    if category
        expenses = $user.expenses.where('MONTH(date) = ? and YEAR(date) = ? and category = ?', d.month, d.year, category)
        title = "Expenses for #{desired_date} by #{category} category"
    else
        expenses = $user.expenses.where('MONTH(date) = ? and YEAR(date) = ?', d.month, d.year)
        title = "Expenses for #{desired_date}"
    end
    total_amount = get_expenses_total_amount(expenses)
    print_expenses_result_table(expenses, title, total_amount)
end

# finding expenses for a specific date
def show_expenses_by_date(desired_date, category = nil)
    d = DateTime.parse(desired_date)
    if category
        expenses = $user.expenses.where('date = ? and category = ?', d, category)
        title = "Expenses for #{desired_date} by #{category} category"
    else
        expenses = $user.expenses.where('date = ?', d)
        title = "Expenses for #{desired_date}"
    end
    total_amount = get_expenses_total_amount(expenses)
    print_expenses_result_table(expenses, title, total_amount)
end

# show all expenses
def show_expenses
    expenses = $user.expenses
    total_amount = get_expenses_total_amount(expenses)
    print_expenses_result_table(expenses, title, total_amount)
end

# displaying a list of expenses according to the user's request
def show_expenses
  exit_loop = false

  loop do
    instructions = "To see the list of expenses, enter the period and categories of expenses in the command line."  \
    "\nFor example, to see expenses for a month by category of food, you need to enter:"  \
    "'08.2022 food'."  \
    "\nTo see expenses for a specific date for all categories:"  \
    "'08.12.2022'"  \
    "\nIf the input is empty, you will see a list of all expenses"
    "\nPress 'r' to return to the previous menu, or 'x' to exit: -> "
    print_instructions(instructions)

    user_input = STDIN.gets.chomp
    # show all user expenses
    if user_input == ''
        show_all_expenses
    # return to previous menu
    elsif user_input == 'r'
        exit_loop = true
    # exit program
    elsif user_input == 'x'
        abort
    else
        # if the user entered the correct date for the search,
        # we select the period for which we search for expenses
        if validate_show_expenses_date_input(user_input) == 1
            input_args = user_input.split
            if input_args[0].size == 0
                show_expenses
            if input_args[0].size == 4
                show_expenses_by_year(input_args[0], input_args[1])
            elsif input_args[0].size < 9
                show_expenses_by_month(input_args[0], input_args[1])
            else
               show_expenses_by_date(input_args[0], input_args[1])
            end
        end
    end
    break if exit_loop
  end
end

exit_loop = false

# choosing an action for expenses (add, delete, show)
loop do
  instructions = "Press 'n' to add a new expense, 'l' to see a list of expenses, 'd' clear all expenses, or 'x' to exit: -> "
  print_instructions(instructions)
  valid_input = %w[n l d x]
  user_input = STDIN.gets.chomp
  if !valid_input.include? user_input
    puts 'Invalid input'
    puts "\n" + instructions
  elsif user_input == 'n'
    add_expense
  elsif user_input == 'l'
    show_expenses
  elsif user_input == 'd'
    delete_expenses
  elsif user_input == 'x'
    abort
  end
  break if exit_loop
end