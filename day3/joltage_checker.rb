def input_data
  file = File.open("input.txt")
  file_data = file.read
  file.close

  file_data.split("\n")
end

def joltage_summer
  joltage = 0

  input_data.each { |battery_set| joltage += max_joltage(battery_set) }

  joltage
end

def max_joltage(battery_set)
  first_joltage = max_joltage_battery(battery_set)

  second_joltage = second_joltage_battery(battery_set, first_joltage)

  (first_joltage + second_joltage).to_i
end

def max_joltage_battery(battery_set)
  battery_joltages = battery_set.split("").map(&:to_i)

  max_joltage = battery_joltages.max

  return max_joltage.to_s unless battery_joltages.find_index(max_joltage) == battery_joltages.size - 1

  battery_joltages.sort[-2].to_s
end

def second_joltage_battery(battery_set, first_joltage)
  return first_joltage if battery_set.count(first_joltage) > 1 && battery_set.split("").map(&:to_i).max == first_joltage.to_i

  battery_set.split(first_joltage).last.split("").map(&:to_i).max.to_s
end

puts "The total joltage is #{joltage_summer}"
