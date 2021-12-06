require_relative "../../utils.rb"

def part_1_solution(slope, pos: [0, 0], offset:[3, 1], can_print: false)
  count = 0

  while true
    pos = pos.zip(offset).map(&:sum)

    line = slope[pos.last]
    break if line.nil?
    if line.length <= pos.first
      line *= ((pos.first / line.length) + 1)
    end

    count += 1 if line[pos.first] == "#"
  end

  puts "PART 1: #{count}" if can_print
  count
end

def part_2_solution(slope)
  offsets = [
    [1, 1],
    [3, 1],
    [5, 1],
    [7, 1],
    [1, 2]
  ]

  count = offsets.map { |offset| part_1_solution(slope, offset: offset, can_print: false) }.reduce(:*)

  puts "PART 2: #{count}"
end

test_slope = %w[
  ..##.......
  #...#...#..
  .#....#..#.
  ..#.#...#.#
  .#...##..#.
  ..#.##.....
  .#.#.#....#
  .#........#
  #.##...#...
  #...##....#
  .#..#...#.#
]

part_1_solution strs_from_prompt, can_print: true
part_2_solution strs_from_prompt