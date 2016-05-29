#!/usr/bin/ruby
# mvcpatterndemo.rb
##############################################################################
# Add dirs to the library path
$: << File.expand_path(".", File.dirname(__FILE__))

require "student"
require "studentview"
require "studentcontroller"

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

controller = StudentController.new(model, view)
controller.update_view

#
# Typically I suspect that the statements below should be put into a loop
# within method: controller.main_loop
#

# while true

  # Get event (eg. user input or mouse click)
  student_name = "John"

  # Update model data
  controller.set_student_name(student_name)

  # Update view
  controller.update_view

# end

