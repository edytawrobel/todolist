#display tge menu
module Menu

  def menu
    puts "Welcome to your ToDoList. \nPlease choose from the following list:
    1. Add a task\n
    2. Show a task list\n
    3. Write to a File\n
    4. Read from a File\n
    Q. Quit\n"
  end

  def show
    menu
  end
end

module Promptable
  def prompt(message = "What would you like to do next?", symbol = ":>")
    print message
    print symbol
    gets.chomp
  end
end

# Create a list that manages the behavior of an individual list
class List
  attr_reader :all_tasks

  def initialize
    @all_tasks = []
  end

  # Add tasks to list
  def add(task)
    unless task.to_s.chomp.empty?
      all_tasks << task
    end
  end
  # Show all tasks
  def show
    all_tasks
  end

  # Write a list to a file
  def write_to_file(filename)
    IO.write(filename, @all_tasks.map(&:to_s).join("\n"))
  end

  # Read from a file
  def read_from_file(filename)
    IO.readlines(filename) { |line| add(Task.new(line.chomp)) }
  end

  # Delete a task
  # Update a task
end

# manages the behavior of each individual task
class Task
  attr_reader :description
  #description upon creation of each instance
  def initialize(description)
    @description = description
  end

  def to_s
    description
  end
end

#program runner
if __FILE__ == $PROGRAM_NAME
include Menu
include Promptable
  my_list = List.new
  until ['q'].include?(user_input = prompt(Menu.show).downcase)
    case user_input
    when '1'
      my_list.add(Task.new(prompt("What is the task you would like to add?\n")))
    when '2'
      puts my_list.show
    when '3'
      my_list.write_to_file(prompt("what is the file you would like to write to?\n"))
    when '4'
      begin
        my_list.read_from_file(prompt("what is the file you would like to read from?\n"))
      rescue Errno::ENOENT
        puts "No such file or directory - please verify your file name and path"
      end
    else
      puts 'Try again, I did not catch that'
    end
      prompt('Press enter to continue', '')
  end
  puts 'Outro - Thanks for using our system!'
end
