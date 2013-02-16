# EzImport: Easy XML Import and Export From ActiveRecord

Have you ever been irritated with keeping ActiveRecord models consistent across different developers or server instances, but didn't want to waste all the time maintaining fixtures? Now importing and exporting is easy.

EzImport allows you to export and import data from models while keeping the ID's consistent. Now you can make your adjustments to the database directly and freeze those changes in version control. 

## Installation

	gem 'ez_import'

## Usage
	
To export a single model:

	$ rake ez_export model_name
	
To export a multiple models:

	$ rake ez_export model_name another_model third_model
	
To import a single model:
	
	$ rake ez_import model_name
	
To export a multiple models:

	$ rake ez_import model_name another_model third_model

## Batch Imports

You may want to sync up the same group of models from time to time without having to specify each on the command line. For that, you'd use batch imports.

First, generate an initializer (config/initializers/ez_import.rb):

	$ rails g ez_import:config user_type subscription_type
	
Now you can import and export automatically from this list:
	
	$ rake ez_export:all
	
	$ rake ez_import:all
	

## Custom callbacks

There may be a situation where you want to do something after an import in order to fix it in the database. A good example of this is when you are importing something with a counter cache. The counter cache gets imported and then incremented for each record after it. This is no good. The solution is to define a callback class method in your model. It must be named after_ezimport.

	def self.after_ezimport
		Post.all.each do |p|
			Post.reset_counters(p.id, :comments) 
		end
	end


## Copyright

Copyright (c) 2013 Joe Korzeniewski. See LICENSE.txt for
further details.

