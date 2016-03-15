class User < ActiveRecord::Base
  has_and_belongs_to_many :teams, join_table: 'teams_users'
  belongs_to :company
  belongs_to :department

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, # :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validate :has_valid_role?, on: :save

  def self.valid_roles
    ['common', 'administrator', 'manager', 'developer', 'marketeer', 'customer_care', 'owner']
  end

  def is_administrator?
    self.roles.include?('administrator')
  end

  def is_owner?(company)
    self.is_administrator? or (self.roles.include?('owner') and self.company == company)
  end

  def is_owner_or_admin?(company)
    self.is_owner?(company) or self.is_administrator?
  end

  def is_within_company?(company)
    self.company == company
  end

  private

  def has_valid_role?
    roles_counter = self.roles.count
    intersection  = self.roles & User.valid_roles?

    if intersection.count != roles_counter
      errors.add(:invalid_role, 'Role must be allowed')
      return false
    end
    true
  end
end
