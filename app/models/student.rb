class Student < ActiveRecord::Base

  GRADES = [:Kindergarten, :"1", :"2", :"3", :"4", :"5", :"6", :"7", :"8", :"9", :"10", :"11", :"12",
            :"13", :"14", :"15", :"16", :"17", :"18", :"Headstart AM", :"Headstart PM", :Preschool]
  STATUSES = [ :empty, :pending, :denied, :completed, :stopped ]
  
  validates_uniqueness_of :number
  belongs_to :site
  has_many :studentallergens
  has_many :allergens, :through => :studentallergens
  has_many :diets
  has_many :dietdocuments
  has_many :notes

  
  has_many :student_meals
  has_many :meals, :through => :student_meals
  
  enum grade: GRADES
  enum request_status: STATUSES

  def current_diet
    year = SiteSetting.current_year
    diet = self.diets.where(schoolyear: year).first
  end
  
end
