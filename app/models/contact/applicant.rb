class Contact::Applicant < Contact
  has_many :applications

  attr_accessor :password

  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validate :authenticated?, on: :update

  def authenticated?
    return if !password || !password_hash || !password_salt
    unless password_hash == BCrypt::Engine.hash_secret(password, password_salt)
      errors.add(:password, I18n.t('activerecord.errors.models.contact/applicant.attributes.password.wrong'))
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
