require 'bcrypt'
require 'io/console'
require_relative './Models/user'
require_relative 'helpers'

# the variable in which the logged-in user will be saved
$user = nil

# username validation when creating a new user
def validate_username(username)
  if User.find_by(:username => username)
    puts "User already exist."
    return false
  end
  if username.length < 4
    puts "Username must be at least 4 characters long."
    return false
  end
  return true
end

# username password when creating a new user
def validate_password(password)
  if password.length < 4
    puts "Password must be at least 4 characters long."
    return false
  end
  return true
end

# creating a new user
def create_user(username, password)
    begin
        # password encryption before saving
        password = BCrypt::Password.create(password)
        User.create(username: username, password: password)
        puts 'User created!'
    rescue
        puts 'Error! User not created!'
    end
end

# user authentication
def try_auth
     # the maximum number of attempts to enter a password
     max_attempts = 3
     # the number of attempts used to enter the password
     attempts = 0
     # authentication result (0 - user not authenticated, 1 - successful authentication)
     result = 0
     puts 'Enter your username: '
     username = STDIN.gets.chomp
     validated = false
     login_user = User.find_by(:username => username)
     if !login_user
        puts 'User not found.'
     else
        while attempts <= max_attempts && !validated
          attempts += 1
          puts 'Enter your password: '
          pw = STDIN.noecho(&:gets)
          pw.strip!
          if BCrypt::Password.new(login_user.password) == pw
            puts "Login successful!"
            validated = true
            $user = login_user
            result = 1
          elsif (max_attempts - attempts) > 0
            puts "Invalid password! #{max_attempts - attempts} remaining"
          else
            puts 'Invalid password entered too many times. No more attempts remain.'
          end
        end
     end
  result
end

def start_user_actions
    # flag to control the moment of return to the menu of working with the user
    exit_loop = false

    loop do
      instructions = "Press 'n' for new user, 'l' to login, or 'x' to exit: -> "
      print_instructions(instructions)

      # choosing an action to work with the user
      valid_input = %w[n l x]
      user_input = STDIN.gets.chomp
      if !valid_input.include? user_input
        puts 'Invalid input'
      # create new user
      elsif user_input == 'n'
        username = nil
        password = nil
        username_validated = false
        password_validated = false
        loop do
            puts 'Please enter a username'
            username = STDIN.gets.chomp
            username_validated = validate_username(username)
            break if username_validated
        end
        loop do
            puts 'Please enter a password'
            password = STDIN.noecho(&:gets)
            password.strip!
            puts 'Please repeat a password'
            password_repeat = STDIN.noecho(&:gets)
            password_repeat.strip!
            if password == password_repeat
                password_validated = validate_password(password)
            else
                puts "Passwords do not match!"
            end
            break if password_validated
        end
        create_user(username, password)
      # authentication (success - proceed to work with costs, failure - exit the program)
      elsif user_input == 'l'
         if try_auth == 1
            exit_loop = true
         else
            abort
         end
      # exit the program
      elsif user_input == 'x'
        abort
      end
      break if exit_loop
    end
end

