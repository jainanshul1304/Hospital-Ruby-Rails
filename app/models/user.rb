class User < ApplicationRecord
    has_many :patients
    enum role: { receptionist: 1, doctor: 2, admin: 3}
    before_create :set_default_role

    private
  
    def set_default_role
      self.role ||= :doctor
    end
    after_initialize :set_default_role, if: :new_record?

    ROLES = %w[patient doctor receptionist]

    validates :role, presence: true, inclusion: { in: ROLES }
    before_save { self.email = email.downcase }

    validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }

    validates :password, presence: true, length: { minimum: 6, maximum: 30 }

    has_secure_password
end
