require_relative "../../utils.rb"

class Scanner
  def initialize(number, points)
    @number = number
    @points = points
    @origin = [0, 0] if number == 0
  end

  attr_accessor :number, :points, :origin

  def to_s
    "<Scanner ##{@number}: origin -> #{origin || 'UNKNOWN'}, size -> #{beacon_count} >"
  end

  def log
    File.open('log.txt', 'w') do |f|
      points.sort.each do |point|
        f.write point
        f.write("\n")
      end
    end
  end

  def beacon_count
    points.size
  end

  def target_rotation(world)
    world.points.each do |p_ref|
      rotations.map do |rotation|
        offset = p_ref.zip(rotation.first).map { |pair| pair.reduce(:-) }
        
        absolute_points = rotation.map do |p_rel|
          offset.zip(p_rel).map(&:sum)
        end
  
        if absolute_points.count { |p_abs| world.points.include?(p_abs) } >= 12
          @origin = offset

          return absolute_points
        end
      end
    end

    nil
  end

  def rotations
    return @rotations if @rotations

    @rotations = Array.new(24) { [] }

    points.each do |x, y, z|
      # Face forward
      @rotations[ 0] << [ x,  y,  z]
      @rotations[ 1] << [-y,  x,  z]
      @rotations[ 2] << [-x, -y,  z]
      @rotations[ 3] << [ y, -x,  z]
      
      # Face left
      @rotations[ 4] << [ z,  y, -x]
      @rotations[ 5] << [ z,  x,  y]
      @rotations[ 6] << [ z, -y,  x]
      @rotations[ 7] << [ z, -x, -y]
      
      # Face back
      @rotations[ 8] << [-x,  y, -z]
      @rotations[ 9] << [-y, -x, -z]
      @rotations[10] << [ x, -y, -z]
      @rotations[11] << [ y,  x, -z]

      # Face right
      @rotations[12] << [-z,  y,  x]
      @rotations[13] << [-z,  x, -y]
      @rotations[14] << [-z, -y, -x]
      @rotations[15] << [-z, -x,  y]
      
      # Face up
      @rotations[16] << [ x,  z, -y]
      @rotations[17] << [-y,  z, -x]
      @rotations[18] << [-x,  z,  y]
      @rotations[19] << [ y,  z,  x]

      # Face down
      @rotations[20] << [ x, -z,  y]
      @rotations[21] << [ y, -z, -x]
      @rotations[22] << [-x, -z, -y]
      @rotations[23] << [-y, -z,  x]
    end

    @rotations
  end

  def signature
    @signature ||= points.permutation(2).map do |pair|
      pair.first.zip(pair.last).map do |coordinate|
        coordinate.reduce(:-).abs
      end
    end.uniq
  end
end

def part_1_solution(groups)
  scanners = groups.map.with_index do |group, i| 
    point_list = group[1..-1].map { |point| point.split(',').map(&:to_i) }

    Scanner.new(i, point_list)
  end

  world = scanners.shift
  found_scanners = []

  until scanners.empty?
    target_scanner = scanners.detect do |target_scanner|
      absolute_points = target_scanner.target_rotation(world)

      next unless absolute_points

      world.points = [*world.points, *absolute_points].uniq
      
      true
    end

    break if target_scanner.nil?

    found_scanners << target_scanner
    scanners.select! { |scanner| scanner != target_scanner }
  end

  puts "PART 1: #{world.beacon_count}"
end

def part_2_solution(values)
  value = 0

  puts "PART 2: #{value}"
end

part_1_solution str_groups_from_prompt
part_2_solution []