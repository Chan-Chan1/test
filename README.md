# test
this is a test repository
this line, I have edited in github
this line, I have edited in my local machine

# test1
this is a test repository - created from my local machine
# Friendly-Cukes
friendly-cukes is user friendly cucumber test automation framework created by tester for tester.
It is a ruby-cucumber based generic automation framework for desktop and mobile web automation. It is built using Cucumber (1.3.15), page-object (1.0.2) and appium_lib (4.1.0). All you need is to install the gem and that's it, you have set with cucumber automation.

Gem requirements :
The gem requires [Ruby (2.0.0)](https://www.ruby-lang.org/en/downloads/), [ChromeDriver.exe (v2.10.267521)](http://chromedriver.storage.googleapis.com/index.html), [IEDriverServer.exe (2.45.0.0)](http://selenium-release.storage.googleapis.com/index.html) and [Appium (1.3.4.1)](http://appium.io/downloads.html). As of now the framework is designed to work with the given software setup and tested only on Windows machine.

1. Install friendly-cukes gem

		gem install friendly-cukes

2. Install generic cucumber framework 

		friendly-cukes --new test_app_name
	where test_app_name is the test application name
	This will install the generic cukes framework under 'test_app_name' directory
	
3. Then type `cd test_app_name` and start with the cucumber automation
	By default the framework have some features files for demo purpose.
	Type `rake -T`, the cucumber run command for the default feature files is created as rake task. The above command list three tasks. Run any of the task, like `rake desktop_google_search` and it will start the cucumber execution.
	
	
# test heading
## test heading
### test heading
#### test heading