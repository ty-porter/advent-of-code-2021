require_relative "utils.rb"

dirs = ARGV.any? ? ARGV : Dir.glob('*').select {|f| File.directory? f }

puts colorize("Printing Advent of Code solutions for Year(s) #{dirs.join(', ')}!", Color::YELLOW)

dirs.each do |year|
  puts
  puts colorize("YEAR #{year}", Color::GREEN)

  Dir.glob("#{year}/*").select {|f| File.directory? f }.each_with_index do |solution, index|
    Dir.chdir(solution) do
      indent = " " * 2
      
      puts if index > 0
      puts indent + colorize("- DAY #{solution.split("/").last}", Color::CYAN)

      results = `ruby main.rb`

      puts results.split("\n").map { |line| colorize(indent * 3 + line, Color::YELLOW) }
    end
  end
end