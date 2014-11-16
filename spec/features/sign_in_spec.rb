# All users have to log in
# in order to edit their tasks
# because users want security

feature 'Sign in' do
  let(:email) { 'steve@jobs.com' }
  let(:password) { '&Minted14Jodi' }

  scenario 'with valid credentials' do
    user = FactoryGirl.create(:user, email: email, password: password)

    visit '/'
    click_link 'Log in'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'

    expect(page).to have_content(/signed in successfully/i)

    # Should be on the own nodes page
    expect(current_path).to eq '/nodes'
  end
end
