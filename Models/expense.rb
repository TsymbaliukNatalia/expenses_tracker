require_relative "db"
require_relative "user"

class Expense < ActiveRecord::Base
    belongs_to :user
end