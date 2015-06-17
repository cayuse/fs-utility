class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :fix_date, only: [:update, :create]

  def index
    @students = Student.search params[:search], :page => params[:page], :per_page => 30, :include => :site
  end
  
  def new
    @student = Student.new
  end
  
  def show
    @notes = @student.notes
    @note = Note.new(:student_id => @student.id)
  end

  def edit
  end

  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

    def fix_date
      params[:student][:birthdate] = Date.strptime(params[:student][:birthdate], "%m/%d/%Y")
    end
      
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:name, :birthdate, :number, :grade, :site_id, {:meal_ids => []})
    end
end




#  def intersession
#    if Setting.just_site_number(current_user) && Setting.just_track_code
#      site = Setting.just_site_number(current_user)
#      track = Setting.just_track_code(current_user)
#      @students = Student.find(:all, :conditions => "site_id = '#{site}' AND track = '#{track}' and intersession='Y'",
#                                     :order => "name")
#    else
#      flash[:error] = 'No Site or Track Selected. Please ensure you have both selected before continuing.'
#      redirect_to(setting_url, :action=>'edit')
#    end
#  end
#  
#  def drop_all
#    if Setting.just_site_number(current_user) && Setting.just_track_code(current_user)
#      site = Setting.just_site_number(current_user)
#      track = Setting.just_track_code(current_user)
#          Student.update_all( "intersession='f'", "site_id = '#{site}' AND track = '#{track}'" )
#      redirect_to (students_url)
#    else
#      flash[:error] = 'No Site or Track Selected. Please ensure you have both selected before continuing.'
#      redirect_to(setting_url, :action=>'edit')
#    end
#  end
