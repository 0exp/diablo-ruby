# frozen_string_literal: true

require 'fiddle'

class RubyVM::InstructionSequence
  load_fn_addr = Fiddle::Handle::DEFAULT['rb_iseq_load']
  load_fn = Fiddle::Function.new(load_fn_addr, [Fiddle::TYPE_VOIDP] * 3, Fiddle::TYPE_VOIDP)

  define_singleton_method(:load) do |data, parent = nil, opt = nil|
    load_fn.call(Fiddle.dlwrap(data), parent, opt).to_value
  end
end

def with_boost(method_name)
  RubyVM::InstructionSequence.load(
    RubyVM::InstructionSequence.of(method(method_name)).to_a.tap do |seq|
      seq[9] = :top # NOTE: see RubyVM::InstructionSequence#to_a documentation
    end
  ).eval
end

with_boost def omfg
  puts "NIHERA_SEBE"
end
