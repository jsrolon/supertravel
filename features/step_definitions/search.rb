Given(/^I am on the home page$/) do
  visit "/"
end

When /^I fill in "([^\"]*)" with "([^\"]*)"$/ do |field, value|
  fill_in(field.gsub(' ', '_'), :with => value)
end

Then(/^I should see "(.*?)"$/) do |arg1|
  page.should have_content arg1
end