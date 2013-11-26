require 'spec_helper'

describe User do
  before do @user = User.new(name: "Example User", email: "user@example.com",
                            password: 'foobar', password_confirmation: 'foobar')
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

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

  describe 'when password is not present' do
    before do
      @user = User.new(name: 'Example User', email: 'user@example.com',
                       password: ' ', password_confirmation: ' ')
    end
    it { should_not be_valid }
  end

  describe 'when password does not match' do
    before { @user.password_confirmation = 'mismatch' }
    it { should_not be_valid }
  end





end
