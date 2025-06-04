require 'rails_helper'

RSpec.describe AnswerChannel, type: :channel do
  scenario "User sees new answer in real time", js: true do
    user_a = create(:user)
    user_b = create(:user)

    visit questions_path
    fill_in "Email", with: user_a.email
    fill_in "Password", with: "password"
    click_button "Log in"

    within_window open_new_window do
      visit questions_path
      fill_in "Email", with: user_b.email
      fill_in "Password", with: "password"
      click_button "Log in"
    end
  end
end
