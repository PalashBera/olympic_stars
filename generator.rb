# frozen_string_literal: true

# time array generator

array = []

24.times do |t|
  str = t.to_s.rjust(2, "0")

  12.times do |tt|
    val = "#{str}:#{(tt * 5).to_s.rjust(2, '0')}"
    array << val
  end
end
