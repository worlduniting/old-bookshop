Given /^the file "([^"]*)" does not exist$/ do |file|
  FileUtils.rm(file) if File.exists? file
end

Then /^a new file "([^"]*)" should exist$/ do |file|
  File.exists? file
end

Given /^there is an existing book source file "([^"]*)"$/ do |file|
  File.exists? file
end