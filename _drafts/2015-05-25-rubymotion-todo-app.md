---
layout: post
title: "Todo App - RubyMotion"
description: "Introduction to RubyMotion Using a Simple Todo App"
tags: ['Ruby','RubyMotion','IOS']
author: Mehakdeep Singh
---
{% include JB/setup %}

**What is rubymotion?**

Simply putting RubyMotion is a tool that allows you to write IOS apps in ruby. Rubymotion compiles the ruby code to machine code which is same as objective C.So the device can’t tell the difference between rubymotion and the objective C ios apps.

**Why use rubymotion?**

If you have a strong hold on ruby , and you want to quickly start working on a ios app, then rubymotion is the way to go instead of learning a new langauge. Its true that you would to learn a new framework (Cocoa Touch), rather than learning a new language (Swift,Object C).
And Rubymotion preserves the iOS SDK exactly as intended by Apple, so all existing code examples and tutorials are perfectly translatable.

**Installation**


> "*<a href="http://www.rubymotion.com/buy/index2.html?utm_expid=54787903-6.ZJfhJyorSiu-xKssExEmxA.1&utm_referrer=http://www.rubymotion.com/buy/index2.html
" title="RubyMotion">RubyMotion</a>* is created by Hipbyte. Its Paid software with 30 days fully functional trial, with a option of money back if it doesn’t suit you."

It requires Xcode , which can be downloaded form the app store. Other dependencies are  IOS simulator and command line tools.

**Getting Started**

A very good place to start learning is the following two tutorials.

* <a href="http://www.rubymotion.com/developers/guides/manuals/cocoa/getting-started/">getting-started</a>
* <a href="http://rubymotion-tutorial.com/1-hello-motion">hello-motion</a>

Both of these tutorial guides you to building a hello world app.

<div class="row"><div class='col-md-8 col-md-offset-2'><img class="img-responsive" alt="hello-ios" src="/assets/blogs/hello-ios.png" style="margin: 20px 2px"></div></div>

After Going through the above mentioned tutorials , the basic points that you would have noticed would be.

*  `rake` command is used to run app on simulator
*  Everything that is visible on the screen is a `UIView`
*  Views can subviews, and that can keep on going.
*  It uses the Model-View-Controller pattern.

 **Build A ToDo App**

 Assuming that you already created a hello world app from above mentioned tutorials lets create a new Todo App.

 `motion create todo`

 Create a List Controller , which is UIViewController, right now it sets background color white.

~~~ ruby
  class ListController < UIViewController
    def viewDidLoad
      super
      self.view.backgroundColor = UIColor.blackColor
    end
  end
~~~

change the change app_delegate to load our new controller as root view controller.


~~~ ruby
  class AppDelegate
    def application(application, didFinishLaunchingWithOptions:launchOptions)
      @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
      @window.makeKeyAndVisible
      @window.rootViewController = ListController.new
      @window.rootViewController.wantsFullScreenLayout = true

      $root_controller = @window.rootViewController
      true
    end
  end
~~~

<div class="row"><div class='col-md-8 col-md-offset-2'><img class="img-responsive" alt="todo-0" src="/assets/blogs/todo-0.png" style="margin: 20px 2px; border:3px solid black;"></div></div>


**Add Text Area**

Now we added a `UITextArea` and a `UIButton`. We call `add_task` function on button click. Which just prints a log right now.

The rest of the code if self understood.

now the listcontroller looks like

~~~ruby
  class ListController < UIViewController
    def viewDidLoad
      super
      self.view.backgroundColor = UIColor.whiteColor
      add_text_area
    end

    def add_text_area
      text_field_view = UITextField.alloc.initWithFrame(CGRectMake(0, 20, self.view.frame.size.width - 50, 40))
      text_field_view.delegate = self
      text_field_view.borderStyle = UITextBorderStyleRoundedRect

      text_field_view.textColor =UIColor.blackColor
      text_field_view.becomeFirstResponder

      text_field_view.placeholder = "new task"
      text_field_view.textAlignment = NSTextAlignmentLeft
      self.view.addSubview(text_field_view)

      #add button
      add_task_button = UIButton.buttonWithType UIButtonTypeCustom
      add_task_button.setFrame(CGRectMake(self.view.frame.size.width - 40, 20, 35, 40))
      add_task_button.setTitleColor(UIColor.blackColor, forState: UIControlStateNormal)
      add_task_button.setTitle("Add", forState: UIControlStateNormal)
      add_task_button.addTarget(self,
                                   action: :add_task,
                                   forControlEvents: UIControlEventTouchUpInside)
      self.view.addSubview add_task_button
    end

    def add_task
      NSLog("Task Added")
    end

  end
~~~

<div class="row"><div class='col-md-8 col-md-offset-2'><img class="img-responsive" alt="todo-1" src="/assets/blogs/todo-1.png" style="margin: 20px 2px; border:3px solid black;" border="5"></div></div>

**Add Empty table**

Now We will Add a Empty `UITable` for our app.<a href="http://rubymotion-tutorial.com/5-tables/">This</a>
 is a very good introduction to using tables.

First we will intialize a empty table and add it to main view as a subview.

~~~ruby
  def add_task_list
    table_view = UITableView.alloc.initWithFrame(CGRectMake(0, 70, self.view.frame.size.width, 200))
    table_view.dataSource = self
    table_view.delegate = self
    table_view.clipsToBounds = false
    self.view.addSubview table_view
  end
~~~

this function set values for each row in the table, right now its nil

~~~ruby
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "cell"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: @reuseIdentifier)


    cell
  end
~~~

this function  returns total number of rows in the table.We hard-coded it to 10 for now.

~~~ruby
  def tableView(tableView, numberOfRowsInSection: section)
    10
  end
~~~

and my viewDidLoad now looks like this.

~~~ruby
  def viewDidLoad
    super
    self.view.backgroundColor = UIColor.whiteColor
    add_text_area
    add_task_list
  end
~~~



<div class="row"><div class='col-md-8 col-md-offset-2'><img class="img-responsive" alt="todo-2" src="/assets/blogs/todo-2.png" style="margin: 20px 2px; border:3px solid black;" border="5"></div></div>

**Following The MVC**

It seems like we are writing a load of view related code in our controller , now we will create a list_view in `app/views/` , which is a `UIView` and move all the code there.

We override the `initWithFrame` function for the ListView, which is a setter for this class.

~~~ruby
  def initWithFrame frame
    super
    add_text_area
    add_task_list
  end
~~~


And we Initialise this view from our ListController.

~~~ruby
  def viewDidLoad
    super
    self.view.backgroundColor = UIColor.whiteColor
    list_view = ListView.alloc.initWithFrame(self.view.frame)
    self.view.addSubview(list_view)
  end
~~~


**Adding a task**

Now we will implement that when we add a task it goes to the list.

**using attr_accessor**

Now we need to alter these views from different functions, so we will use the attr_accessor and so the we can set and use attributes :).

`attr_accessor :text_area, :task_list, :add_task_button`

`self.text_area = text_field_view`



Now we store the tasks in attribute which is a array and add the current text of the text_area to that array when add_task button is clicked. Then we reload the table data.

~~~ruby
  def add_task
    NSLog("Task Added")
    self.tasks << self.text_area.text
    self.task_list.reloadData
  end
~~~

select appropriate value for the table row.

~~~ruby
  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "cell"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: @reuseIdentifier)


    cell.textLabel.text = "#{self.tasks[indexPath.row]}"

    cell
  end
~~~


<div class="row"><div class='col-md-8 col-md-offset-2'><img class="img-responsive" alt="todo-3" src="/assets/blogs/todo-3.png" style="margin: 20px 2px; border:3px solid black;" border="5"></div></div>

**adding local database**

Right now the app is not storing any data, so that means, when you restart the all the tasks will be gone.
So now we will implement local storage.
we will use NanoStore as DB. And Cocoapods to integrate the nanostore.

* <a href="https://github.com/tciuro/NanoStore">NanoStore</a>
* <a href="https://github.com/siuying/NanoStoreInMotion">NanoStoreInMotion</a>

Add required gems to Gemfile

`gem 'motion-cocoapods’`

`gem 'nano-store'`

here is the RakeFile

~~~ruby
  # -*- coding: utf-8 -*-
  $:.unshift("/Library/RubyMotion/lib")
  require 'motion/project/template/ios'
  require 'motion-cocoapods'
  require 'nano-store'


  begin
    require 'bundler'
    Bundler.require
  rescue LoadError
  end

  Motion::Project::App.setup do |app|
    # Use `rake config' to see complete project settings.
    app.name = 'todo'

    app.pods do
      pod 'NanoStore'
    end
  end
~~~

Install the gems and pods.

`bundle install`

`bundle exec rake pod:install`

And to the app_delegate add following line to set db file path.We will use a local file as DB.

~~~ruby
  documents_path         = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0]
  NanoStore.shared_store = NanoStore.store(:file, documents_path + "/nano.db")
~~~


**bringing models in action**

Now we will create model for task and store it locally.

~~~ruby
  class Task  < NanoStore::Model
    attribute :name
    attribute :created_at
  end
~~~

Loading all tasks in memory when ListView loaded.

~~~ruby
  def initWithFrame frame
    super
    self.tasks = Task.all.sort {|a,b| b.created_at <=> a.created_at}
    add_text_area
    add_task_list
  end
~~~


Create new Task in the DB on add task.

~~~ruby
  def add_task
    NSLog("Task Added")
    task = Task.create(:name =>  self.text_area.text, :created_at => Time.now)
    self.tasks.unshift(task)

    self.task_list.reloadData
    self.text_area.text = ""
  end
~~~

**Different Sections for completed and pending Tasks**

Now we will separate the table in 2 sections , completed and pending tasks. And clicking on a task will move it from one section to another.

we have 2 attributes `:completed_tasks, :uncompleted_tasks`

and we initialize these 2 attrbutes with required data.

~~~ruby
  self.completed_tasks = Task.find(:completed, NSFEqualTo, 1).sort { |a, b| b.created_at <=> a.created_at }
  self.uncompleted_tasks = Task.find(:completed, NSFEqualTo, 0).sort { |a, b| b.created_at <=> a.created_at }
~~~

We add these 2 sections in our table “pending” and “completed”.


~~~ruby
  def numberOfSectionsInTableView(tableView)
    2
  end
~~~

~~~ruby
  def tableView(tableView, titleForHeaderInSection: section)
    if section == 1
      "completed"
    elsif section == 0
      "pending"
    end
  end
~~~

~~~ruby

  def tableView(tableView, cellForRowAtIndexPath: indexPath)

    @reuseIdentifier ||= "cell"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: @reuseIdentifier)

    if indexPath.section == 0
      cell.textLabel.text = "#{self.uncompleted_tasks[indexPath.row].name}"
    elsif indexPath.section == 1
      cell.textLabel.text = "#{self.completed_tasks[indexPath.row].name}"
    end
    cell
  end

~~~

~~~ruby
  def tableView(tableView, numberOfRowsInSection: section)
    if section == 0
      Task.find(:completed, NSFEqualTo, 0).count
      self.uncompleted_tasks.count
    elsif section == 1
      Task.find(:completed, NSFEqualTo, 1).count
    else
      0
    end
  end
~~~

This Function handles the event when any row is clicked.

~~~ruby
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    cell = tableView.cellForRowAtIndexPath(indexPath)
    self.mark_as_done(cell)
  end
~~~


And the mark_as_done function toggles the task between completed and pending.

~~~ruby
  def mark_as_done cell
    task = Task.find(:name, NSFEqualTo, cell.textLabel.text).first
    task.completed = !task.completed
    task.save
    self.reload_table_sections
  end
~~~



<div class="row"><div class='col-md-8 col-md-offset-2'><img class="img-responsive" alt="todo-4" src="/assets/blogs/todo-4.png" style="margin: 20px 2px; border:3px solid black;" border="5"></div></div>


