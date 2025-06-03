require "rails_helper"

feature "User answer", %q(
  To remove incorrect knowledge
  As an authenticated user
  I want to be able to delete answers
) do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, question: question, user: user) }


  scenario 'Authenticated user delete answer', js: true do
    sign_in(user)
    visit question_path(question)
    create_answer(question)
    expect(page).to have_content(answer.title)
    click_link "Delete"
    # save_and_open_page
    # expect(response).to redirect_to(question_path(question))
    expect(page).not_to have_content(answer.title)
  end

  # scenario 'Non-authenticated user create answer', js: true do
  #   visit question_path(question)

  #   fill_in 'Your answer', with: 'My answer'
  #   fill_in 'Body', with: 'text'
  #   click_on "Create"

  #   expect(page).to have_content "Log in"
  # end
end
