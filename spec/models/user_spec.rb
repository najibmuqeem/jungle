require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create valid user' do
      user = User.create(
        first_name: "Jon",
        last_name: "Bon Jovi",
        email: "jon@bonjovi.com",
        password: "itsmylife",
        password_confirmation: "itsmylife"
        )
      expect(user).to be_valid
    end

    it 'fails to save user if passwords do not match' do
      user = User.create(
        first_name: "Jon",
        last_name: "Bon Jovi",
        email: "jon@bonjovi.com",
        password: "itsmylife",
        password_confirmation: "itsnowornever"
        )
      expect(user).to_not be_valid
    end

    it 'fails to save user if email exists already (not case sensitive)' do
      user1 = User.create(
        first_name: "Jon",
        last_name: "Bon Jovi",
        email: "jon@bonjovi.com",
        password: "itsmylife",
        password_confirmation: "itsmylife"
        )
      user2 = User.create(
        first_name: "Jon",
        last_name: "Bon Jovi",
        email: "JoN@bOnJoVi.com",
        password: "itsmylife",
        password_confirmation: "itsmylife"
        )
      expect(user2).to_not be_valid
    end

    it 'fails to save if no first name' do
      user = User.create(
        last_name: "Bon Jovi",
        email: "jon@bonjovi.com",
        password: "itsmylife",
        password_confirmation: "itsmylife"
        )
        expect(user.errors.full_messages).to include "First name can't be blank"
    end

    it 'fails to save if no last name' do
      user = User.create(
        first_name: "Jon",
        email: "jon@bonjovi.com",
        password: "itsmylife",
        password_confirmation: "itsmylife"
        )
        expect(user.errors.full_messages).to include "Last name can't be blank"
    end

    it 'fails to save if no email' do
      user = User.create(
        first_name: "Jon",
        last_name: "Bon Jovi",
        password: "itsmylife",
        password_confirmation: "itsmylife"
        )
        expect(user.errors.full_messages).to include "Email can't be blank"
    end

    it 'fails to save user if password length is less than 3' do
      user = User.create(
        first_name: "Jon",
        last_name: "Bon Jovi",
        email: "jon@bonjovi.com",
        password: "it",
        password_confirmation: "it"
        )
        expect(user.errors.full_messages).to include "Password is too short (minimum is 3 characters)"
    end
  end

  describe '.authenticate_with_credentials' do
    it 'logs in valid user' do
      user = User.create(
        first_name: "Jon",
        last_name: "Bon Jovi",
        email: "jon@bonjovi.com",
        password: "itsmylife",
        password_confirmation: "itsmylife"
        )
      loginUser = User.authenticate_with_credentials(user.email, user.password)
      expect(loginUser).to be true
    end

    it "logs in user with case insensitive email" do
      user = User.create(
        first_name: "Jon",
        last_name: "Bon Jovi",
        email: "jon@bonjovi.com",
        password: "itsmylife",
        password_confirmation: "itsmylife"
        )
      loginUser = User.authenticate_with_credentials('JoN@bOnJoVi.com', user.password)
      expect(loginUser).to be true
    end

    it "logs in user with spaces around email" do
      user = User.create(
        first_name: "Jon",
        last_name: "Bon Jovi",
        email: "jon@bonjovi.com",
        password: "itsmylife",
        password_confirmation: "itsmylife"
        )
        loginUser = User.authenticate_with_credentials("  jon@bonjovi.com ", user.password)
        expect(loginUser).to be true
      end
  end
end 