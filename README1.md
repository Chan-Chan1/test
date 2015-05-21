# Framework components detailed description

## 1. config 

#### a. config.yml

- holds the various users profiles and global environment values used in run
- the dynamic profiles include both test and development
- only the free profile (having in_use: ‘no’) will be used during run
- we can have multiple parallel execution with these profiles by specifying the profile (i.e., box) name and we can have any number of profiles under each node

Ex: as given in cucumber.yml
	desktop_dev_chrome – will take any free profile under any developmentx node (where x is the node number)
	desktop_devboxx_chrome – will take any free profile only under dev_boxx

- If you wish to run cukes in multiple parallel machines, then for each execution have different devboxX profiles and in each machine parallel execution can be made with the same profile 
	
	the number of parallel threads = number of profiles, if you are running cukes in dev environment in 3 parallel threads, then there should be atleast 3 profiles under devboxX node
	
	config.yml node descriptions :
	
		environment: node holds the execution level data used throughout the cukes run
		logger_level: DEBUG       -> custom logger level
		default_page_wait: 60   -> explicit page load wait time in seconds
		default_element_wait: 60  -> explicit element load wait time in seconds
		datetime_pattern: '%d_%m_%Y-%H_%M_%S‘  -> default datetime format
		feature_id_prefix: '@rq_‘   -> prefix for unique feature level tag name
		scenario_id_prefix: '@tc_‘  -> prefix for unique scenario level tag name
		parallel_execution_count: 0  ->  used internally for parallel executions count
		no_of_parallel_threads: 1  -> no of parallel executions
		delay_between_parallel_threads: 60 seconds  -> delay between each parallel execution
		performance_report: 'no‘  -> flag for including performance report
		db_server: EHR2Aspire  -> DB server which holds DB where execution performance data are stored
		db_name: PerformanceReport  -> DB that holds relations for storing performance data
		db_user_name: dba  -> user name for DB access
		db_password: sql  -> password for DB access

### b. cucumber.yml

- holds the cucumber run profiles with custom settings 
- The default: profile is for desktop (app) - test (node) – chrome (browser)
- The profiles denote the profile type (from config.yml), application type (desktop or mobile) and the browser (Chrome, IE or Firefox)
- You can n number profiles provided you have the equivalent boxes in config.yml
- Each profile includes node for custom reporting – the cucumber html report files uses the custom formatter (present in support/html_formatter.rb)  

## 2. features

### a. desktop
- holds the desktop web feature files
- The feature files can be placed under any directory level under desktop
- Each feature should have an unique feature tag name starting with the prefix given in environment/ feature_id_prefix node in config.yml

		Ex: @rq_desktop_search
		
- Each scenario should have an unique scenario tag name starting with the prefix given in environment/ scenario_id_prefix node in config.yml

		Ex: @tc_01
		
- The custom report log file created by cukes will have the name with the relative path of the feature file directory that is executed

### b. mobile

- holds the mobile web feature files
- The feature files can be placed under any directory level under mobile
- Rest of the things are the same for mobile as well

## 3. library

### a. app_init

#####- app_driver.rb -> Requires the cukes support directory files for globalizing PageObjects under library

###	b. app_utils

#####- data_file_names.rb -> contains constants with value of the test data (yml) file names and these constants can be used throughout the cukes without including or requiring
#####- page_utils.rb -> contains generic methods that defines page objects related manipulations, which can be used for both desktop and mobile app automation

### c. generic
#####- app_logo_1.png -> logo of cukes, that will be added in custom html report files
#####- create_log.rb -> contains custom logger class methods
					-> creates two or more log files – app_env.log holds the execution environment and run duration details and other log files are created with the name as relative path of the current running feature file directory and holds logging of the feature, scenarios and their steps with scenariosrun duration details
#####- custom_html_report.rb -> contains custom html report  class methods
							-> the custom report is extracted from the cucumber generated reports (html and json files). The custom html report will be placed in custom_report under current report directory under test_result directory
							-> The report also merges html reports generated during parallel executions. If there are 3 parallel executions, then 3 report directories will be created and the custom_report  (holding the report for all 3 executions) will be present only in one of the report directory
							-> The report_home.html holds the execution summary, which includes the pass-fail count of features, scenarios and steps. On click on the feature link opens another html page that holds the pass-fail count of the scenarios and steps with cukes logs
#####- datetime_library.rb -> contains generic module methods for date-time manipulation
#####- file_library.rb -> contains generic module methods for file related manipulations
#####- performance_report.rb -> contains generic class methods for creating data for performance report
							-> The execution duration details are extracted from the json report file and saved into Sybase database (with credentials from config.yml) as relations
							-> SqlAnywhere is used as DB, the server and database name are provided in config.yml
							-> the json report file holds the execution duration in nano seconds only at step level and hence the steps are iterated for scenario, feature and build level
							-> each build is marked unique and holds reference to its corresponding features, scenarios and steps, which includes the counts of pass, fail, skip and net result
							-> these data can be populated as a report for application performance analysis
#####- read_from_yml.rb -> contains generic class methods for yml file manipulation
						-> the methods includes all kinds of yml data node traversal
						-> cukes uses yml file for test data storage
						
## 4. object_repository

### a. desktop
- all desktop web page-object class files are placed under object_repository directory
- all the library classes and modules are visible to page class files
- you can also have multiple repository files
### b. mobile
- all mobile web page-object class files are placed under object_repository directory
- all the library classes and modules are visible to page class files
- you can also have multiple repository files

## 5. object_repository

### a. desktop
- holds generic page object class methods that defines the actual script action (with the objects from object_repository) on desktop web browser
- all library class methods and object_repository modules are visible to the page object classes defined here
### b. desktop
- holds generic page object class methods that defines the actual script action (with the objects from object_repository) on mobile web browser
- all library class methods and object_repository modules are visible to page object classes defined here

## 6. step_definitions

###a. desktop
- holds the step definition files for the features under desktop directory
- the step definition files can be grouped under directories under desktop directory 
###b. mobile
- holds the step definition files for the features under mobile directory 
- the step definition files can be grouped under directories under desktop directory
 
## 7. support
##### a. browser_settings.rb
- contains generic module methods for browser related manipulations
- holds browser object profiles for desktop browsers like chrome, internet explorer and firefox and mobile browsers like chrome (Android)  and safari (IOS)
##### b. env.rb
- holds require statements for including ruby library classes and modules and requires library and object_repository of cukes (for making cukes library files available to the entire framework)
- contains constants definitions holding cucumber run command line arguments (environment) values
- all global class and module declarations can be made here (using World)
##### c. hooks.rb
- holds the scenario hooks definitions that defines the feature/scenario/step pre and post actions
- all profile values used by cukes are defined as constants
- major stuffs like log file creation, browser/application launching, scenarios/steps pre and post action setup, custom and performance reports creation are done in this file
##### d. html_formatter.rb
- contains generic class methods for custom html report formatter
- holds method definitions for embedding image, text, link or a file

## 8. test_result

for each execution an unique test report directory will be created with the name ‘test_report_<timestamp>’ under which by default the following exists

##### a. app_env.log – holds the log for execution environment and duration details
##### b. feature based custom log file – holds the log based on the currently running feature – there can n number of feature log files
##### c. report_<timestamp>.html – cucumber generated html report file that holds the log for features, scenarios and steps
##### d. report_<timestamp>.json – cucumber generated json report file that holds the log for features, scenarios and steps and the step level durations in nano seconds
##### e. custom_report
- custom_report – the directory holds custom html report files
- report_home.html – holds the summary report of the execution

## 9. Gemfile 

- holds the gem names with version used in cukes
- if you wish to add/remove/update any gem or its version, then those changes can be made in this file and run bundle 	install to install the gems in your machine
- for IDE (like RubyMine) no need to do bundle install, as it automatically does it when any change is made to this file
- When bundle install is successful a file named Gemfile.lock will be created which holds the gems and its dependencies (kindly avoid updating gemfile.lock, make changes only to Gemfile)

## 10. Rakefile.rb

- all the rake tasks can be defined here
- instead of typing a lengthy cucumber run command, it can be given as a rake task and can be invoked by rake <task_name>
- the pre and post conditions can also be set here

## 11. Code coverage 

- Cukes uses simplecov for code coverage
- if you want to include code coverage into cukes,  then add CODE_COVERAGE=yes or true in cucumber run command
- like, cucumber –p desktop_dev_chrome -t @tc_01 APP=GOOGLE CODE_COVERAGE=yes 
- it will create a directory coverage under cukes under which rcov/index.html report file holds the code coverage metric details, which covers all the files under cukes
- it also creates json report files in the name .last_run.json – holds total coverage percent and resultset.json – holds individual files code coverage percent 
- the json report file will be used in code coverage integration with Jenkins