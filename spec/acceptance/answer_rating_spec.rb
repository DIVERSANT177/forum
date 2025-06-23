require "rails_helper"

feature "Rate answer", %q(
  To mark the best answers
  As an authenticated user
  I want to be able to rate answers
) do
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer, question: question, user: user) }

  describe "Rate answer" do
    before do
      sign_in(user)
      visit question_path(question)
      create_answer(question)
    end

    scenario "Authenticated user rate answer", js: true do
      find(".rate-up-button", match: :first).click

      expect(page).to have_content("Рейтинг: 1")
    end

    scenario 'Non-authenticated user rate answer', js: true do
      click_on 'Выйти'
      sleep 1
      visit question_path(question)
      expect(page).to_not have_css(".rate-up-button")
    end
  end
end
