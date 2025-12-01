def input_data
  file = File.open("input.txt")
  file_data = file.read
  file.close

  file_data.split("\n")
end

def initial_position
  50
end

def zero_click_counter(part_2: false)
  zero_click = 0
  position = initial_position

  input_data.each do |instruction|
    zero_click += extra_zero_passes(instruction, position) if part_2

    position = (position + instruction_value(instruction:)).modulo(100)

    zero_click += 1 if position == 0
  end

  zero_click
end

def instruction_value(instruction:, modulus: false)
  instruction_value = instruction.split(/[R|L]/).last.to_i
  instruction_value *= -1 if instruction.match?(/[L]/) && !modulus

  instruction_value
end

def extra_zero_passes(instruction, position)
  instruction_value = instruction_value(instruction:, modulus: true)
  zero_clicks = instruction_value / 100
  instruction_modulo = instruction_value.modulo(100)

  zero_clicks += 1 if (position + instruction_modulo) > 100 && instruction.match?(/[R]/)
  zero_clicks += 1 if position.positive? && (position < instruction_modulo) && instruction.match?(/[L]/)

  zero_clicks
end

puts "The 0 position is set #{zero_click_counter} times under part 1 instructions"
puts "The 0 position is set #{zero_click_counter(part_2: true)} times under part 2 instructions"
