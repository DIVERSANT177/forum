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
    click_on 'Ask question'
    fill_in 'Title', with: "MyTitle"
    fill_in 'Body', with: "MyBody"
    click_on 'Create'
  end

  def create_answer(question)
    visit question_path(question)
    fill_in 'Your answer', with: 'My answer'
    fill_in 'Body', with: 'text'
    click_on "Save"
  end
end
