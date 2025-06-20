require "rails_helper"

feature "Add_file_to_answer", %q(
  In order to illustrate my answer
  As an answer's author
  I'd like to be able to attach files
) do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User adds file when asks question', js: true do
    fill_in 'Заголовок ответа', with: 'Test answer'
    fill_in 'Ваш ответ', with: 'text'
    attach_file 'Прикрепить файл', "#{Rails.root}/spec/spec_helper.rb"
    click_on "Сохранить"
    expect(page).to have_link "spec_helper.rb", href: "/uploads/attachment/file/1/spec_helper.rb"
  end
end
