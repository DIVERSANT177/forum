equire "rails_helper"

feature "Rate answer", %q(
  To mark the best answers
  As an authenticated user
  I want to be able to rate answers
) do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario "Authenticated user rate answer", js: true do
    sign_in(user)
    visit question_path(question)

    click_on "Like"

    expect(page).to have_content("Рейтинг: 1")
  end

  scenario 'Non-authenticated user rate answer', js: true do
    visit question_path(question)
    expect(page).to_not have_content("Like")
  end
end
