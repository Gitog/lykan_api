class User < ApplicationRecord
    attr_accessor :password
    validates_confirmation_of :password
    validates :email, presence: true, uniqueness: true
    before_save :encrypt_password

    def encrypt_password
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end

    def self.authenticate(email, password)
        user = find_by_email(email)
        if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
            user
        else
            nil
        end
    end

    belongs_to :role
    has_many :order
end