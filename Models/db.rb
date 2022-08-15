require 'mysql2'
require "active_record"

ActiveRecord::Base.establish_connection(
  :adapter  => 'mysql2',
  :database => 'expenses_tracker',
  :username => 'root',
  :password => 'Budapesht2021@',
  :host     => 'localhost')