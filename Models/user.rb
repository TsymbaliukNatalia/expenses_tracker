require_relative "db"
require_relative "expense"

class User < ActiveRecord::Base
    has_many :expenses
end