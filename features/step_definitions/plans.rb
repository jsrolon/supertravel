Given(/^I am on the home page$/) do
  visit "/"
end

When(/^I press "(.*?)"$/) do |arg1|
  click_link arg1
end

Then(/^I should see "(.*?)"$/) do |arg1|
  page.should have_content arg1
end