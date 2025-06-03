require "rails_helper"

feature "Answer editing", %q(
  In order to fix mistake
  As an author of answer
  I'd like to be able to egit my answer
) do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, question: question, user: user) }

  scenario 'Unauthenticated user try to edit question' do
    visit question_path(question)
    expect(page).to_not have_link 'Edit'
  end

  describe "Authenticated user" do
    before do
      sign_in(user)
      visit question_path(question)
    end
    scenario 'sees link to edit', js: true do
      create_answer(question)
      within '.answers' do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'try to edit his answer', js: true do
      create_answer(question)
      within '.answers' do
        click_on 'Edit'
        fill_in 'Your answer', with: 'Edit answer'
        click_on 'Save'
      end

      expect(page).to_not have_content answer.title
      expect(page).to have_content 'Edit answer'
    end

    scenario "try to edit other user's question" do
    end
  end
end
