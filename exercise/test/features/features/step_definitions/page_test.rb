$txt_vals = Array["txt_val_1","txt_val_2","txt_val_3","txt_val_4","txt_val_5","txt_ttl_val"]
$txt_vals_no_balance =  Array["txt_val_1","txt_val_2","txt_val_3","txt_val_4","txt_val_5"]


def chk_obj_by_id_exists(obj_id)
  element = $driver.find_element(id: obj_id)
  if element.displayed? == true
    'true'
  else
    'false'
  end
end

def count_of_objs(obj_array)
  @num = 0
  obj_array.each do |obj_id|
    result = chk_obj_by_id_exists(obj_id)
    if result == 'true'
      @num = @num + 1
    end
  end
  return @num
end

def get_obj_val(obj_id)
  if(chk_obj_by_id_exists(obj_id))
    element = $driver.find_element(id: obj_id)
    @val = element.value
  end
  return @val
end


def calculate_balance(obj_array)
  @total = 0
  obj_array.each do |obj_id|
    @str =  get_obj_val(obj_id)
    @str = @str[1,@str.size]
    @total = @total+ @str.to_i
  end
  return @total
end

def chk_format_of_value(obj_id)
  @val= get_obj_val(obj_id)
  @prefix = @val[0]
  @num = @val[1,@val.size]
  if @prefix == "$" && @num.to_i > 0
    'true'
  else
    'false'
  end
end

Given("User navigates to exercise link") do
  $driver = Selenium::WebDriver.for :chrome
  #driver.get "https://www.exercise1.com"
  $driver.get "http://localhost:8080"
end

When("Check the {string} in the page") do |given_object|
  @actual_result = chk_obj_by_id_exists(given_object)
end

Then("It should be indicated by {string}") do |result|
  expect(@actual_result).to eq(result)
  $driver.quit
end

When("Check the count of values") do
  @count = count_of_objs($txt_vals)
end

Then("The count should be 6") do
  expect(@count).to eq(6)
  $driver.quit
end

Then("The count of values should be greater than 0") do
  expect(@count).to be > 0
  $driver.quit
end

When("Calculate the total balance of the values") do
  @balance = calculate_balance($txt_vals_no_balance)
end

Then("Balance should match the balance listed") do
  @bal_listed = get_obj_val("txt_ttl_val")
  @bal_listed = @bal_listed[1,@bal_listed.size]
  expect(@balance).to eq(@bal_listed.to_i)
  $driver.quit
end

When("Check the value format") do
  $txt_vals.each do |obj_id|
    @result = chk_format_of_value(obj_id)
  end
end

Then("The values are formatted as currencies") do
  expect(@result).to eq("true")
end