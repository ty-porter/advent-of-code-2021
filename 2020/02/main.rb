require_relative "../../utils.rb"

def split_password_parts(strs)
  strs.map do |str|
    pattern, password = str.split(": ")

    [password, pattern.split(/[\s\-]/).map.with_index { |str, i| i < 2 ? str.to_i : str }]
  end
end

def part_1_solution(strs)
  passwords = split_password_parts(strs) 
  value = passwords.count do |group|
    password, rule = group
    min, max, char = rule

    password.count(char) >= min && password.count(char) <= max
  end

  puts "PART 1: #{value}"
end

def part_2_solution(strs)
  passwords = split_password_parts(strs) 
  value = passwords.count do |group|
    password, rule = group
    start, stop, char = rule

    [password[start - 1], password[stop - 1]].count(char) == 1
  end

  puts "PART 2: #{value}"
end

test_strs = [
  "1-3 a: abcde",
  "1-3 b: cdefg",
  "2-9 c: ccccccccc"
]

part_1_solution strs_from_prompt
part_2_solution strs_from_prompt