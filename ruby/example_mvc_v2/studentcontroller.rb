# studentcontroller.rb
##############################################################################
class StudentController

  ############################################################################
  # Contructor for controller
  def initialize(model, view, event)
    @model = model
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
        set_student_name(e[:name])

        # Update view
        update_view
      end

    end
  end

  ############################################################################
  # Interact with Model
  def set_student_name(name)
    @model.name = name
  end

  def get_student_name
    @model.name
  end

  def set_student_roll_no(roll_no)
    @model.roll_no = roll_no
  end

  def get_student_roll_no
    @model.roll_no
  end

  ############################################################################
  # Interact with View
  def update_view
    @view.print_student_details(@model.name, @model.roll_no)
  end

end

