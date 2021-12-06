require_relative "../../utils.rb"

def part_1_solution(nums)
  map = {}

  value = nums.each do |num|
    break map[num] * num if map[num]

    map[2020 - num] = num
  end

  puts "PART 1: #{value}"
end

def part_2_solution(nums)
  map = {}

  value = nums.each_with_index do |outer_num, i|
    curr_sum = 2020 - outer_num

    pair = nums.each_with_index do |num, j|
      next if i == j
      break [map[num], num] if map[num]
  
      map[curr_sum - num] = num
    end

    next unless pair.size == 2

    triplet = [*pair, outer_num]
    
    break triplet.reduce(:*)
  end

  puts "PART 2: #{value}"
end

part_1_solution nums_from_prompt
part_2_solution nums_from_prompt