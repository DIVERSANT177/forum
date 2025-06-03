require "rails_helper"

feature "Delete answer", %q(
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
    expect(page).not_to have_content(answer.title)
  end

  scenario 'Non-authenticated user delete answer', js: true do
    visit question_path(question)
    expect(page).not_to have_link "Delete"
  end
end
