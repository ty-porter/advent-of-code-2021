require_relative "../../utils.rb"

def part_1_solution(groups)
  value = groups.map do |group|
    group.map(&:chars)
         .flatten
         .uniq
         .count
  end.sum

  puts "PART 1: #{value}"
end

def part_2_solution(groups)
  value = groups.map do |group|
    map = {}

    group.each_with_object(map) do |answers, hash|
      answers.chars.each { |char| hash[char] ? hash[char] += 1 : hash[char] = 1 }
    end

    map.keys.count { |key| map[key] == group.size }
  end.sum

  puts "PART 2: #{value}"
end

test_groups = [
  %w[abc],
  %w[
    a
    b
    c
  ],
  %w[
    ab
    ac
  ],
  %w[
    a
    a
    a
    a
  ],
  %w[b]
]

part_1_solution str_groups_from_prompt
part_2_solution str_groups_from_prompt