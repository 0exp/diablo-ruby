require 'fiber'

$fiber1 = Fiber.new do
  $fiber2.transfer
  puts 'kek'
  $fiber3.transfer
  puts 'pek'
end

$fiber2 = Fiber.new do
  $fiber3.transfer
end


$fiber3 = Fiber.new do
  $fiber1.transfer
  $fiber1.transfer
end

$fiber1.resume

array = []
1000.times do |time|
  array << []
  array.each { |arr| arr << [] }
end
