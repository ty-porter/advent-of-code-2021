require_relative "../../utils.rb"

def top(range)
  range.reduce(:-) / 2 + range.last
end

def bottom(range)
  (range.reduce(:-) / 2) + 1 + range.last
end

def reduce_range(str, range)
  value = (0..str.size).each do |i|
    if %w[F L].include?(str[i])
      range = [top(range), range.last]
    elsif %w[B R].include?(str[i])
      range = [range.first, bottom(range)]
    end

    break range.first if range.uniq.size == 1
    break range.max   if i == str.size - 1
  end

  value
end

def part_1_solution(strs)
  row_range = [127, 0]
  col_range = [  7, 0]

  max_id = strs.map do |str|
    row_str = str[0..6]
    col_str = str[7..9]

    row = reduce_range(row_str, row_range)
    col = reduce_range(col_str, col_range)

    row * 8 + col
  end.max

  puts "PART 1: #{max_id}"
end

def part_2_solution(strs)
  row_range = [127, 0]
  col_range = [  7, 0]

  ids = strs.map do |str|
    row_str = str[0..6]
    col_str = str[7..9]

    row = reduce_range(row_str, row_range)
    col = reduce_range(col_str, col_range)

    row * 8 + col
  end.sort

  chunks = ids.chunk_while { |cur, prv| cur + 1 == prv }.to_a
  id = chunks.first.last + 1

  puts "PART 2: #{id}"
end

part_1_solution strs_from_prompt
part_2_solution strs_from_prompt