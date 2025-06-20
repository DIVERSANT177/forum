require "rails_helper"

feature "Create question", %q(
  In order to get answer from community
  As an authenticated user
  I want to be able to ask questions
) do
  given(:user) { create(:user) }

  scenario "Authenticated user creates question" do
    sign_in(user)

    visit questions_path
    click_on 'Задать вопрос'
    fill_in 'Заголовок', with: 'Test question'
    fill_in 'Текст вопроса', with: 'text text'
    click_on 'Создать'

    expect(page).to have_content 'Your question successfully created'
  end

  scenario "Non-authenticated user ties to create question" do
    visit questions_path
    expect(page).to_not have_content 'Your question successfully created'

    # expect(page).to have_content "You need to sign in or sign up before continuing"
  end
end
