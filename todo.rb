#display tge menu
module Menu

  def menu
    puts "Welcome to your ToDoList. \nPlease choose from the following list:
    1. Add\n
    2. Show\n
    3. Update\n
    4. Delete\n
    5. Write to File\n
    6. Read from File\n
    7. Toggle status\n
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
      all_tasks << task
  end
  # Show all tasks
  def show
    all_tasks.map.with_index { |l, i| "(#{i.next}): #{l}"}
  end

  def update(task_number, task)
    all_tasks[task_number - 1] = task
  end

  def delete(task_number)
    all_tasks.delete_at(task_number - 1)
  end
  # Write a list to a file
  def write_to_file(filename)
      fl = @all_tasks.map(&:to_machine).join("\n")
      IO.write(filename, fl)
  end

  # read each line from the file, displaying both the description and the status
  def read_from_file(filename)
    IO.readlines(filename).each do |line|
      status, *description = line.split(':')
      status = status.include?('X')
      add(Task.new(description.join(':').strip, status))
    end
  end

  def toggle(task_number)
    all_tasks[task_number - 1].toggle_status
  end
end

# manages the behavior of each individual task
class Task
  attr_reader :description
  attr_accessor :status
  #description upon creation of each instance
  def initialize(description, status=false)
    @description = description
    @status = status
  end

  def to_s
    "#{represent_status} : #{description}"
  end

  def completed?
    status
  end

  def to_machine
    "#{represent_status} : #{description}"
  end

  def toggle_status
    @status = !completed?
  end

  private
  def represent_status
     "#{(completed?) ? '[X]' : '[ ]'}"
  end
end

#program runner
if __FILE__ == $PROGRAM_NAME
include Menu
include Promptable
  my_list = List.new
  until ['q'].include?(user_input = prompt(show).downcase)
    case user_input
    when '1'
      my_list.add(Task.new(prompt("What is the task you would like to add?\n")))
    when '2'
      puts my_list.show
    when '3'
      my_list.update(prompt("What is the task you would like to update?\n").to_i, Task.new(prompt('enter your task description')))
    when '4'
      puts my_list.show
      my_list.delete(prompt("What is the task you would like to delete?\n").to_i)
    when '5'
      my_list.write_to_file(prompt 'What is the filename to write to?')
    when '6'
      begin
        my_list.read_from_file(prompt('What is the filename to read from?'))
      rescue Errno::ENOENT
        puts 'File name not found, please verify your file name and path.'
      end
    when '7'
      puts my_list.show
      my_list.toggle(prompt('Which would you like to toggle the status for?').to_i)
    else
      puts 'Try again, I did not catch that'
    end
    prompt('Press enter to continue', '')
  end
  puts 'Outro - Thanks for using our system!'
end
