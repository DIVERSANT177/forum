require "rails_helper"

feature "Create answer", %q(
  In order to exchange my knowledge
  As an authenticated user
  I want to be able to create answers
) do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user create answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Заголовок ответа', with: 'My answer'
    fill_in 'Ваш ответ', with: 'text'
    click_on "Сохранить"
    # save_and_open_page
    expect(current_path).to eq question_path(question)

    within '#answers' do
      expect(page).to have_content "My answer"
    end
  end

  scenario 'Non-authenticated user create answer', js: true do
    visit question_path(question)

    fill_in 'Заголовок ответа', with: 'My answer'
    fill_in 'Ваш ответ', with: 'text'
    click_on "Сохранить"

    expect(page).to have_content "Log in"
  end

  scenario 'User try to create invalid answer', js: true do
    sign_in(user)
    visit question_path(question)

    click_on "Сохранить"

    expect(page).to have_content "Заполните поле"
  end
end
