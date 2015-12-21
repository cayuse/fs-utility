class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_and_belongs_to_many :sites
  has_one :setting
  enum role: [:user, :distadmin, :inventory, :intersession, :manager,
              :accounting, :bidadmin, :biduser, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end    
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         

    def authorized_for_site?(site)
      self.role == "admin" || self.sites.include?(site)
    end

    def administrator?
      (self.role == "admin" || self.role == "distadmin")
    end

    def bid_admin?
      ["admin", "bid_admin"].include? self.role
    end

end
