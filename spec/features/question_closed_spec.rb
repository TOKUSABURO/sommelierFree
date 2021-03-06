require 'rails_helper'

RSpec.feature "Question closed", type: :feature do
  let(:user)      { create :confirmed_user }
  let(:question)  { create :question, author: user } 

  scenario "A question that is not closed" do
    visit new_user_session_path
    fill_in 'Login', with: user.username
    fill_in 'Password', with: '12345678'
    click_button 'Log in'
    visit question_path(question)

    expect(page).to have_selector "form.new_answer"
  end

  scenario "A question that is closed" do
    closed_question = create :question, author: user, closed: true

    visit new_user_session_path
    fill_in 'Login', with: user.username
    fill_in 'Password', with: '12345678'
    click_button 'Log in'
    visit question_path(closed_question)
    
    expect(page).to_not have_selector "form.new_answer"
  end
end
