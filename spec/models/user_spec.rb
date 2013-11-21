require 'spec_helper'

describe User do
  before { @user = User.new( name: "Example User", email: "user@example.com") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  context 'when it is valid' do
    it { should be_valid }
  end

  context 'name is missing' do
    before { @user.name = ' '}
    it { should be_invalid }
  end

  context 'name is too long' do
    before { @user.name = 'a' * 51 }
    it { should be_invalid }
  end

  context 'email is missing' do
    before { @user.email = ' '}
    it { should be_invalid }
  end

  context 'duplicate email' do
    before do 
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
      
    it { should be_invalid }
  end


end
