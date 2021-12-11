require 'pry'

def prompt_data
  File.open("prompt.txt")
end

def nums_from_prompt
  prompt_data.readlines.map { |num| num.chomp.to_i }
end

def num_groups_from_prompt
  prompt_data.readlines.map { |str| str.chars.map(&:to_i) }
end

def strs_from_prompt
  prompt_data.readlines.map(&:chomp)
end

def str_groups_from_prompt
  strs_from_prompt.chunk_while do |cur, prv|
    cur != ""
  end.map do |group|
    group.reject { |str| str == "" }
  end
end

def str_single_from_prompt(index = 0)
  strs_from_prompt[index]
end