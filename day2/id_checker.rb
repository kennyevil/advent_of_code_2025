def input_data
  file = File.open("input.txt")
  file_data = file.read
  file.close

  file_data.split(",")
end

def id_ranges
  input_data.map { |id_range| id_range.split("-") }
end

def invalid_id_finder(part_2: false)
  invalid_ids = []
  id_ranges.each do |id_range|
    range = id_range.first.strip.to_i..id_range.last.strip.to_i

    range.each { |id| invalid_ids << id if id_invalid?(id:, part_2:) }
  end

  invalid_ids
end

def id_invalid?(id:, part_2:)
  id_string = id.to_s

  return part_1_validator(id_string:) unless part_2

  part_2_validator(id_string:)
end

def part_1_validator(id_string:)
  id_string_first_half = id_string[0, id_string.length/2]
  id_string_second_half = id_string[id_string.length/2, id_string.length]

  id_string_first_half == id_string_second_half
end

def part_2_validator(id_string:)
  return false if id_string.length == 1
  return true if early_part_2_validator(id_string:)

  invalid_id = false
  max_string_length_check = (id_string.length/2)-1

  (max_string_length_check..2).step(-1) do |string_length|
    next if invalid_id

    string_components = id_string.scan(/.{#{string_length}}/)

    invalid_id = string_components.join().length == id_string.length && string_components.size > 1 && string_components.uniq.size == 1
  end

  invalid_id
end

def early_part_2_validator(id_string:)
  id_string.split("").uniq.size == 1 || part_1_validator(id_string:)
end

puts "The total sum of all the invalid ids for part 1 is #{invalid_id_finder.sum}"
puts "The total sum of all the invalid ids for part 2 is #{invalid_id_finder(part_2: true).sum}"
