#!/usr/bin/ruby
# mvcpatterndemo.rb
##############################################################################
# Add dirs to the library path
$: << File.expand_path(".", File.dirname(__FILE__))

require "student"
require "studentview"
require "studentcontroller"
require "studentevent"

##############################################################################
def retrive_student_from_database
  student = Student.new
  student.name = "Robert"
  student.roll_no = "10"
  student
end

##############################################################################
# Main
##############################################################################

# Fetch student record based on his roll no from the database
model = retrive_student_from_database

# Create a view : to write student details on console
view = StudentView.new

event = StudentEvent.new

controller = StudentController.new(model, view, event)
controller.update_view
controller.event_loop

