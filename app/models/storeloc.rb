class Storeloc < ActiveRecord::Base
  belongs_to :site
  has_many :monthlyinvitems
  has_many :itemlocs, :dependent => :destroy
  has_many :items, :through => :itemlocs
  validates_presence_of :name

 scope :site, ->(user) { where(site_id: user.setting.site.id).order(:number) }


  def link_to_remote(name, options = {}, html_options = {})
    html_options.merge!({:href => url_for(options[:url])}) unless options[:url].blank?
    super(name, options, html_options)
  end

  def <=> (other)
    number.to_i <=> other.number.to_i
  end

end
