File.open('iseq_bin', 'w') do |file|
  file.write(RubyVM::InstructionSequence.compile_file('source.rb').to_binary)
end
