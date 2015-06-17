class Company < ActiveRecord::Base
  has_many :companybidnames, :dependent => :destroy
  has_many :bidnames, :through => :companybidnames
end
