# studentcontroller.rb
##############################################################################
class StudentController

  ############################################################################
  # Contructor for controller
  def initialize(model, view)
    @model = model
    @view = view
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

