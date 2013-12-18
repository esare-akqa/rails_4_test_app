include ApplicationHelper

def valid_signin(user)
  fill_in 'email',    with: user.name
  fill_in 'password', with: user.password
  click_button 'Sign in'
end

def check_form_values
  puts page.find('#email')[:type]
  email = page.find('#email')[:value]
  puts "email value: #{email}"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end