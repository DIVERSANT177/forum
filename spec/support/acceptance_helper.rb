module AcceptanceHelper
  Capybara.server = :puma

  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def create_question
    visit questions_path
    click_on 'Задать вопрос'
    fill_in 'Заголовок', with: "MyTitle"
    fill_in 'Текст вопроса', with: "MyBody"
    click_on 'Создать'
  end

  def create_answer(question)
    visit question_path(question)
    fill_in 'Заголовок ответа', with: 'My answer'
    fill_in 'Ваш ответ', with: 'text'
    click_on "Сохранить"
  end
end
