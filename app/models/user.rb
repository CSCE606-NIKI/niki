class User < ApplicationRecord
    has_many :credits
    has_many :credit_types

    has_secure_password
    has_one_attached :profile_pic
    # Every user has to have an email, Google and Facebook login fails if no email is returned in hash
    validates :email, presence: true
    validates :username, presence: true

    before_create { generate_token(:auth_token) }

    def self.from_omniauth(response)
        # Check if user's email is already in the database
        if User.exists?(email: response[:info][:email])
            # Check if that email is registered with the same provider and uid
            if User.exists?(email: response[:info][:email], provider: response[:provider], uid: response[:uid])
                return User.find_by(email: response[:info][:email], provider: response[:provider], uid: response[:uid])
            # If provider and uid don't match, return nil to prevent account hijacking
            else
                return nil
            end
        # Nothing to worry about if the email is not in the database
        else
            User.create(uid: response[:uid], provider: response[:provider]) do |u|
                u.username = response[:info][:name]
                u.email = response[:info][:email]
                u.password_digest = SecureRandom.hex(15)
            end
        end
    end


    def generate_token(column)
        begin
            self[column] = SecureRandom.urlsafe_base64
        end while User.exists?(column => self[column])
    end

end
