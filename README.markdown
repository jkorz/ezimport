# EzImport: Easy XML import/export from ActiveRecord

A plugin for rails that allows easy exporting/importing of XML files for your models.

## Installation

Unfortunately I haven't packaged this into a gem yet. Right now there is no good way to install other than copying over. I'll get to the gemifying later. If you're really dying to get this wonderful gadget, copy the folders in the lib directory to your rails lib directory and copy the initializer to config/initializers. 

## Usage

Configuration is done in config/initializers/ezimport.rb. If for example, you wanted to export your User and Privilege models, you would enter:

	EzImport::Models = ['User', 'Privilege']
	
There is also an option to set the relative export path of your XML files.

	EzImport::XMLPath = "db/ezimport" #default 
	
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

Copyright (c) 2011 'Joe Korzeniewski'. See LICENSE.txt for
further details.

