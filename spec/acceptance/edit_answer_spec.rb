require "rails_helper"

feature "Answer editing", %q(
  In order to fix mistake
  As an author of answer
  I'd like to be able to egit my answer
) do
  given(:user) { create(:user) }
  given(:user1) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, question: question, user: user) }

  scenario 'Unauthenticated user try to edit question' do
    visit question_path(question)
    expect(page).to_not have_link 'Редактировать'
  end

  describe "Authenticated user" do
    before do
      sign_in(user)
      visit question_path(question)
      create_answer(question)
    end

    scenario 'sees link to edit', js: true do
      within '#answers' do
        expect(page).to have_link 'Редактировать'
      end
    end

    scenario 'try to edit his answer', js: true do
      within '#answers' do
        click_on 'Редактировать'
        fill_in 'Заголовок ответа', with: 'Edit answer'
        click_on 'Сохранить'
      end

      expect(page).to_not have_content answer.title
      expect(page).to have_content 'Edit answer'
    end

    scenario "try to edit other user's answer", js: true do
      click_on 'Выйти'
      sleep 1
      sign_in(user1)
      visit question_path(question)
      expect(page).to_not have_link 'Редактировать'
    end
  end
end
