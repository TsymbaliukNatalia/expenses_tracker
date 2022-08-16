require 'rspec'
require_relative '../user_actions.rb'

describe 'user_actions' do
    describe "validate_username" do
        describe "validate_username exist username" do
            before do
                user = User.find_by(:username => "RSpec Intro")
                User.create(username: "RSpec Intro", password: 'password') if user.nil?
            end
            it 'validate_username exist username' do
                expect(validate_username("RSpec Intro")).to eql(false)
            end
        end
        describe "validate_username not_exist username" do
            before do
                user = User.find_by(:username => "RSpec Intro")
                user.delete if user
            end
            it 'validate_username not exist correct username' do
                expect(validate_username("RSpec Intro")).to eql(true)
            end
            it 'validate_username short not exist username' do
                expect(validate_username("RS")).to eql(false)
            end
        end
    end
    describe "validate_password" do
         it 'validate_password short password' do
             expect(validate_password("4")).to eql(false)
         end

         it 'validate_password correct password' do
             expect(validate_password("1234")).to eql(true)
         end
    end
    describe "create user" do
        describe "user created" do
            before do
                user = User.find_by(:username => "RSpec Intro")
                user.delete if user
            end
            it 'successful create' do
                user = User.create(username: "RSpec Intro", password: 'password')
                expect(user).to be_valid
            end
        end
    end
end