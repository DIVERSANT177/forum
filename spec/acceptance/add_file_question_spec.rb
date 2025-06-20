require "rails_helper"

feature "Add_file_to_question", %q(
  In order to illustrate my question
  As an question's author
  I'd like to be able to attach files
) do
  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds file when asks question' do
    fill_in 'Заголовок', with: 'Test question'
    fill_in 'Текст вопроса', with: 'text'
    attach_file 'Файл', "#{Rails.root}/spec/spec_helper.rb"
    click_on "Создать"

    expect(page).to have_link "spec_helper.rb", href: "/uploads/attachment/file/1/spec_helper.rb"
  end
end
