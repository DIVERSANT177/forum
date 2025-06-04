require "rails_helper"

feature "Question view realtime", %q(
  In order not to miss new questions
  As an user
  I want to see new questions in real time
) do
  given(:user) { create(:user) }

  scenario "User sees new question in real time", js: true do
    sign_in(user)

    within_window open_new_window do
      create_question
    end

    expect(page).to have_content("MyTitle")
  end
end
