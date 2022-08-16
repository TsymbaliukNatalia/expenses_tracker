require 'rspec'
require_relative '../expenses_actions.rb'

describe 'expenses_actions' do
    describe "validate_show_expenses_date_input" do
         it 'validate_show_expenses_date_input incorrect date' do
            expect(validate_show_expenses_date_input('48.09.2015')).to eql(0)
         end
         it 'validate_show_expenses_date_input invalid format' do
            expect(validate_show_expenses_date_input('10/09/2015')).to eql(0)
         end
         it 'validate_show_expenses_date_input correct year' do
            expect(validate_show_expenses_date_input('2022')).to eql(1)
         end
         it 'validate_show_expenses_date_input correct month' do
             expect(validate_show_expenses_date_input('08.2022')).to eql(1)
         end
         it 'validate_show_expenses_date_input not correct date' do
             expect(validate_show_expenses_date_input('10.05.2022')).to eql(1)
         end
    end

end