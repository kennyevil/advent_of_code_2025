def input_data
  file = File.open("input.txt")
  file_data = file.read
  file.close

  file_data.split(",")
end

def id_ranges
  input_data.map { |id_range| id_range.split("-") }
end

def invalid_id_finder
  invalid_ids = []
  id_ranges.each do |id_range|
    range = id_range.first.strip.to_i..id_range.last.strip.to_i

    range.each do |id|
      id_string = id.to_s
      id_string_first_half = id_string[0, id_string.length/2]
      id_string_second_half = id_string[id_string.length/2, id_string.length]

      invalid_ids << id if id_string_first_half == id_string_second_half
    end
  end

  invalid_ids
end

puts "The total sum of all the invalid ids is #{invalid_id_finder.sum}"
