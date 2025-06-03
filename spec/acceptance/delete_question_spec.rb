require "rails_helper"

feature "Delete question", %q(
  To remove incorrect question
  As an authenticated user
  I want to be able to delete questions
) do
  given(:user) { create(:user) }
  given(:user_test) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario "Non-authenticated user ties to delete question" do
    visit question_path(question)
    expect(page).not_to have_link "Delete Question"
  end

  describe "Authenticated user" do
    before do
      sign_in(user)
      create_question
    end

    scenario 'try to delete his question', js: true do
      click_on "Delete Question"

      page.driver.browser.switch_to.alert.accept
      expect(current_path).to eq questions_path
      expect(page).to_not have_content "MyString"
    end

    scenario "sees link to delete" do
      expect(page).to have_link "Delete Question"
    end

    scenario "try to delete other user's question", js: true do
      click_on 'Выйти'

      sign_in(user_test)
      visit question_path(question)

      expect(page).not_to have_link "Delete Question"
    end
  end
end
