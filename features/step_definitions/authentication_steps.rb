Given /^a user visits the signin page$/ do
  visit signin_path
end

When /^they enter invalid signin information$/ do
  click_button 'Sign in'
end

Then /^they should see an error message$/ do
  page.should have_selector('div.alert.alert-error', text: 'Invalid')
end

And /^the user has an account$/ do
  @user = FactoryGirl.create(:user)
end

When /^the user submits valid signin information$/ do
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Sign in'
end

Then /^they should see their profile page$/ do
  page.current_path.should eq(user_path(@user))
end

Then /^they should see a signout link$/ do
  page.should have_link('Sign out')
end
