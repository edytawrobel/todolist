# Create a list that manages the behavior of an individual list
class List
  attr_reader :all_tasks

  def initialize
    @all_tasks = []
  end

  # Add tasks to list
  def add(task)
    @all_tasks << task
  end

  # Show all tasks
  def show
    all_tasks
  end
  # Read a task from a file
  # Write a list to a file
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
#   Create a task item
end

#program runner

if __FILE__ == $PROGRAM_NAME
 my_list = List.new
 puts 'You have created a new list'
 my_list.add(Task.new('Go to the health shop'))
 my_list.add(Task.new('Write another blog post'))
 my_list.add('Finish off Ruby project')
 puts 'You have added a task to the Todo List'
 puts 'Your task list:'
 puts my_list.show
end
