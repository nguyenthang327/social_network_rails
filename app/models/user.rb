class User < ApplicationRecord
    # relation
    has_many :posts, dependent: :destroy

    has_secure_password

    before_save :downcase_email

    validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true
    validates :name, presence: true, length: { minimum: 4, maximum: 30 }

    private

    def downcase_email
        self.email = email.downcase
    end
end
