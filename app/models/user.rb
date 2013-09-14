class User < ActiveRecord::Base
  has_many :authentications
  has_many :roles
  has_many :accounts
  has_many :orders
  #has_one :user_image
  #accepts_nested_attributes_for :user_image
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  #TODO: this method is requred by declarative_authorization
  def role_symbols
    roles.map do |role|
      role.title.underscore.to_sym
    end
  end

  def apply_omniauth(omniauth)
    logger.debug(omniauth.inspect)
    begin
    #TODO this hash is not necessarily always correct
    self.email = omniauth[:user_info][:email] if email.blank?
    rescue
    end
    authentications.build(:provider => omniauth[:provider], :uid => omniauth[:uid])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  #TODO create a mechanism where password is automatically generated for the brand new user signing up from one of the providers
end
