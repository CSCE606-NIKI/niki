class User < ApplicationRecord
    has_many :credits
    has_secure_password
    has_one_attached :profile_pic
    def self.from_omniauth(response)
        User.find_or_create_by(uid: response[:uid], provider: response[:provider]) do |u|
            u.username = response[:info][:name]
            u.email = response[:info][:email]
            u.password_digest = SecureRandom.hex(15)
        end
    end

    # Every user has to have an email, Google and Facebook login fails if no email is returned in hash
    validates :email, presence: true
    validates :username, presence: true

end
