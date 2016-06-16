# studentcontroller.rb
##############################################################################
class StudentController

  ############################################################################
  # Contructor for controller
  def initialize(student, view, event)
    @student = student			# The model object
    @view = view
    @event = event
  end

  ############################################################################
  def event_loop
    while true

      # Get event (eg. user input, mouse click)
      e = @event.get
      case e[:event]

      when :quit
        break

      when :student_name
        # Update model data
        @student.name = e[:name]

        # Update view
        @view.print_student_details(@student.name, @student.roll_no)
      end

    end
  end

end

