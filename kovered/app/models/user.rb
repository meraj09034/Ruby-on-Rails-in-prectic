class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  before_save :create_role
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates :email, presence: true, uniqueness: true, length: { maximum: 40 }
  validates :username, presence: true,
            :uniqueness => {
                :case_sensitive => true
            }, length: { maximum: 40 }

  has_one :fan, dependent: :destroy
  has_one :artist, dependent: :destroy
  has_one :executive, dependent: :destroy
  has_one :admin, dependent: :destroy
  has_one :image
  accepts_nested_attributes_for :image
  has_one :role
  accepts_nested_attributes_for :role

  attr_accessor :login, :user_role
  scope :without_current_user, ->(user){ where.not(id: user) }

=begin
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end
=end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid, :email)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
    end
  end

  def self.find_for_google_oauth2(access_token)
    where(access_token.slice(:provider, :uid, :email)).first_or_initialize.tap do |user|
      user.provider = access_token.provider
      user.token = access_token.credentials.token
      user.uid = access_token.uid
      user.email = access_token.info.email
    end
    # data = access_token.info
    # user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    # unless user
    #     user = User.create(name: data["name"],
    #        email: data["email"],
    #        password: Devise.friendly_token[0,20]
    #     )
    # end
    # user
  end


  # def self.koala(auth)
  #   access_token = auth['token']
  #   facebook = Koala::Facebook::API.new(access_token)
  #   facebook.get_object("me?fields=name,picture")
  # end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.is_email_exist(email,current_user)
    (current_user.blank? ? self.find_by(:email => email) : self.without_current_user(current_user).find_by(:email => email))

    # role = user_role.singularize
    # self.role << Role.find_by_name('User')
  end

  def create_role
    if self.new_record?
      if user_role.present?
        role_type = user_role.singularize.to_sym
      else
        role_type = 'admin'
      end
      self.build_role(role_type => true)
      # self.role << Role.find_by(role_type,true)
    end
  end

end
