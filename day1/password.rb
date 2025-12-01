def input_data
  file = File.open("input.txt")
  file_data = file.read
  file.close

  file_data.split("\n")
end

def initial_position
  50
end

def zero_click_counter
  zero_click = 0
  position = initial_position

  input_data.each do |instruction|
    instruction_value = instruction.split(/[R|L]/).last.to_i
    instruction_value *= -1 if instruction.match?(/[L]/)

    position += instruction_value

    zero_click += 1 if position%100 == 0
  end

  zero_click
end

puts "The 0 position is set #{zero_click_counter} times"
