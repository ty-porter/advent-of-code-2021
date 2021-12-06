# A simple utility to copy templates to the correct challenge directory

for arg in ARGV
  if !File.directory?(arg)
    `mkdir #{arg}`
  end

  `cp _template.rb #{arg}/main.rb`
  `touch #{arg}/prompt.txt`
end