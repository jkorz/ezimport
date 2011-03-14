# EzImport: Easy XML Import and Export From ActiveRecord

Have you ever been irritated with keeping ActiveRecord models consistent across different developers, but didn't want to waste all the time writing fixtures? Sick of making changes to the database and having to make those changes to all your fixtures again? Well, sicken yourself no further.

EzImport allows you to export and import data from models with no configuration other than specifying what models you want it to work with. It even keeps ids consistent!

## Installation

Unfortunately I haven't packaged this into a gem yet. Right now there is no good way to install other than copying over. I'll get to the gemifying later. If you're really dying to get this wonderful gadget, copy the folders in the lib directory to your rails lib directory and copy the initializer to config/initializers. 

## Usage

Configuration is done in config/initializers/ezimport.rb. If for example, you wanted to export your User and Privilege models, you would enter:

	EzImport.models = ['User', 'Privilege']
	
There is also an option to set the relative export path of your XML files.

	EzImport.xmlpath = "db/ezimport" #default 
	
To export your models:

	$ rake ezimport:export:all

And to import:

	$ rake ezimport:all
	
## Custom Rake Tasks

In the event you'd like to write a separate rake task that only exports a certain model, you simply call EzImport.import and EzImport.export

	namespace :ezimport do
		task :foo => :environment do
			EzImport.import('foo') # model name is not case sensitive, but it won't accept plural or underscored names
		end
		
		namespace :export do
			task :foo => :environment do
				EzImport.export('foo')
			end
		end
	end

## Copyright

Copyright (c) 2011 Joe Korzeniewski. See LICENSE.txt for
further details.

