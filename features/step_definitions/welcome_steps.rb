Given("I am on the homepage") do
    visit '/#' 
  end
  
  Then("I should see {string} in the homepage title") do |text|
    expect(page).to have_title(text)
  end
  
  Then("I should be on the login page") do
    expect(current_path).to eq('/login') 
  end
  
  Then("I should be on the sign-up page") do
    expect(current_path).to eq('/users/new') 
  end

  Then("the {string} link should have the class {string}") do |link_text, class_name|
    link = find_link(link_text)
    expect(link[:class]).to include(class_name)
  end
  
  Then("the {string} button should have the class {string}") do |button_text, class_name|
    button = find_button(button_text)
    expect(button[:class]).to include(class_name)
  end
 
  When("I click the {string} button") do |button_text|
    puts "Before clicking: Current URL: #{current_path}"
    click_button(button_text)
    puts "After clicking: Current URL: #{current_path}"
  end

  Then('I should view {string}') do |content|
    expect(page).to have_content(content)
  end

  


  
  
  