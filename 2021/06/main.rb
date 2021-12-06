require_relative "../../utils.rb"

def part_1_solution(strs, amt: 80, print: true)
  fish_list = strs.first.split(",").map(&:to_i)
  fish_counts = {}

  (-1..8).each do |value|
    fish_counts[value] = fish_list.count(value) || 0
  end

  amt.times do |day|
    new_fish_counts = (-1..8).map { |value| [value, 0] }.to_h

    fish_counts.each do |key, value|
      new_fish_counts[key - 1] = value
    end

    new_fish_counts[6] += new_fish_counts[-1]
    new_fish_counts[8] += new_fish_counts[-1]
    new_fish_counts[-1] = 0
    new_fish_counts.delete(-2)

    fish_counts = new_fish_counts
  end

  puts "PART 1: #{fish_counts.values.sum}" if print

  fish_counts.values.sum
end

def part_2_solution(strs)
  puts "PART 2: #{part_1_solution(strs, amt: 256, print: false)}"
end

test_strs = [
  "3,4,3,1,2"
]

part_1_solution strs_from_prompt
part_2_solution strs_from_prompt