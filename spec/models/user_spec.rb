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
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:microposts) }
  it { should respond_to(:feed) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do 
      @user.save!
      @user.toggle!(:admin)
    end
    
    it { should be_admin }
  end

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

  describe 'remember_token' do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe 'microposts transactions' do
    before { @user.save }
    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end

    it 'should have the right microposts in the right order' do
      expect(@user.microposts.to_a).to eq [newer_micropost, older_micropost]
    end

    it 'should destroy associated microposts' do
      microposts = @user.microposts.to_a
      @user.destroy
      expect(microposts).not_to be_empty
      microposts.each do |micropost|
        expect(Micropost.where(id: micropost.id)).to be_empty
      end
    end
  end

  describe 'micropost associations' do
    before { @user.save }
    let!(:older_micropost) do 
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do 
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end

    describe 'status' do
      let!(:unfollowed_post) do
        FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
      end

      its(:feed){ should include(newer_micropost) }
      its(:feed){ should include(older_micropost) }
      its(:feed){ should_not include(unfollowed_post) }
    end

  end


end
