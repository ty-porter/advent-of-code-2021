require_relative "../../utils.rb"

REQUIRED = %w[
  byr
  iyr
  eyr
  hgt
  hcl
  ecl
  pid
].sort.freeze

def part_1_solution(hashes)
  count = hashes.count { |hash| (REQUIRED - hash.keys) == [] }

  puts "PART 1: #{count}"
end

# byr (Birth Year) - four digits; at least 1920 and at most 2002.
# iyr (Issue Year) - four digits; at least 2010 and at most 2020.
# eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
# hgt (hgt) - a number followed by either cm or in:
# If cm, the number must be at least 150 and at most 193.
# If in, the number must be at least 59 and at most 76.
# hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
# ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
# pid (Passport ID) - a nine-digit number, including leading zeroes.
# cid (Country ID) - ignored, missing or not.

def part_2_solution(hashes)
  count = 0

  hashes.each do |hash|
    byr = hash["byr"]
    iyr = hash["iyr"]
    eyr = hash["eyr"]
    hgt = hash["hgt"]
    hcl = hash["hcl"]
    ecl = hash["ecl"]
    pid = hash["pid"]

    next unless (REQUIRED - hash.keys) == []
    next unless byr.length == 4 && byr.to_i.between?(1920, 2002)
    next unless iyr.length == 4 && iyr.to_i.between?(2010, 2020)
    next unless eyr.length == 4 && eyr.to_i.between?(2020, 2030)

    if hgt.match?("cm")
      next unless hgt.delete("cm").to_i.between?(150, 193)
    elsif hgt.match?("in")
      next unless hgt.delete("in").to_i.between?(59, 76)
    else
      next
    end

    next unless hcl.match?(/\#([a-fA-F\d]){6}/)
    next unless %w[amb blu brn gry grn hzl oth].include?(ecl)
    next unless pid.match?(/\d{9}/) && pid.size == 9

    count += 1
  end

  puts "PART 2: #{count}"
end

def to_hashes(groups)
  groups.map do |group|
    attributes = {}

    group.each_with_object(attributes) do |string, hash|
      string.split(" ").each do |raw_attr|
        key, value = raw_attr.split(":")

        hash[key] = value
      end
    end

    attributes
  end
end

test_strs = [
  'ecl:gry pid:860033327 eyr:2020 hcl:#fffffd',
  'byr:1937 iyr:2017 cid:147 hgt:183cm',
  '',
  'iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884',
  'hcl:#cfa07d byr:1929',
  '',
  'hcl:#ae17e1 iyr:2013',
  'eyr:2024',
  'ecl:brn pid:760753108 byr:1931',
  'hgt:179cm',
  '',
  'hcl:#cfa07d eyr:2025 pid:166559648',
  'iyr:2011 ecl:brn hgt:59in'
]

invalid_strs = [
  'eyr:1972 cid:100',
  'hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926',
  '',
  'iyr:2019',
  'hcl:#602927 eyr:1967 hgt:170cm',
  'ecl:grn pid:012533040 byr:1946',
  '',
  'hcl:dab227 iyr:2012',
  'ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277',
  '',
  'hgt:59cm ecl:zzz',
  'eyr:2038 hcl:74454a iyr:2023',
  'pid:3556412378 byr:2007'
]

valid_strs = [
  'pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980',
  'hcl:#623a2f',
  '',
  'eyr:2029 ecl:blu cid:129 byr:1989',
  'iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm',
  '',
  'hcl:#888785',
  'hgt:164cm byr:2001 iyr:2015 cid:88',
  'pid:545766238 ecl:hzl',
  'eyr:2022',
  '',
  'iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719'
]

part_1_solution to_hashes(str_groups_from_prompt)
part_2_solution to_hashes(str_groups_from_prompt)
