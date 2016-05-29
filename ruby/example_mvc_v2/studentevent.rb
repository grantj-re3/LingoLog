# studentcontroller.rb
##############################################################################
class StudentEvent

  ############################################################################
  # Contructor
  def initialize
  end

  def get
    printf "\nEnter student name (or 'q' to quit): "
    name = STDIN.readline.strip
    return {:event => :quit} if %w{q quit}.include?(name.downcase)
    return {:event => :student_name, :name => name}
  end

end
