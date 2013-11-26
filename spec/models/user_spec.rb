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

  describe 'when password is too short' do
    before { @user.password = @user.password_confirmation = 'a' * 5 }
    it { should be_invalid }
  end

  describe 'return value of authenticate method' do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe 'with valid password' do
      it { should eq(found_user.authenticate(@user.password)) }
    end

    describe 'with invalid password' do
      let(:user_for_invalid_password) { found_user.authenticate('invalid') }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe 'email address with mix cases' do
    let(:mixed_case_email) { 'Foo@ExAMPle.CoM' }

    it 'should be save as all lowercase' do
      @user.email = mixed_case_email
      @user.save

      @user.reload.email.should eq(mixed_case_email.downcase)
    end
  end

  describe 'invalid email address with two dots' do
    before { @user.email = 'foo@bar..com' }
    it { should be_invalid }
  end


end
