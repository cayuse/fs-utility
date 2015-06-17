#!/usr/bin/env ruby


#RAILS_ENV = 'production'
require File.expand_path('../../config/environment', __FILE__)
require 'csv'
#require File.dirname("/home/shared/fsutility/script") + '/config/environment'

#40075759,Abad Ramirez,Samantha,8/9/2009,72,7149864568,0,,TRACK C
#963962,Abadilla,Jan Danielle,5/29/1997,27,7143481342,12,,Traditional
#1005903,Abadilla,Aaron Jakob,6/18/2000,27,7143481342,09,,Traditional

#studentNumbers = {}
#studentNumbers = Student.all.collect(&:number)
#allstus = Student.all
#allstus.each{ |s| studentNumbers[s.number.to_i]=s }

stus = CSV.read("/home/shared/students.csv")
stus.shift

#40075759,Abad Ramirez,Samantha,8/9/2009,72,7149864568,0,,TRACK C
#963962,Abadilla,Jan Danielle,5/29/1997,27,7143481342,12,,Traditional
#1005903,Abadilla,Aaron Jakob,6/18/2000,27,7143481342,09,,Traditional

  for stu in stus

    (studentNumber, lName, fName,
     bDate, site_number, phoneNumber, grade, email, track) = stu
       
    student = Student.new
    student.number = studentNumber
    student.site = Site.find_by_number site_number
    student.name = "#{lName}, #{fName}"
    #puts bDate
    bDate ||= "1/1/1"
    student.birthdate = Date.strptime(bDate, "%m/%d/%Y")
    student.phone = phoneNumber
    student.grade = grade
    student.email = email
    if student.site
      student.save
    end
  end