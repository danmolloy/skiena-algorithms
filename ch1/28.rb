# Write a function to perform integer division without using either the / or *
# operators. Find a fast way to do it.


RubyVM::InstructionSequence.compile_option = {
  tailcall_optimization: true,
  trace_instruction: false
}


def divide(numerator, divisor, count=0)
  return false if divisor < 1 || numerator < 0
  if numerator < divisor
    return count, numerator
  else
    divide(numerator - divisor, divisor, count + 1)
  end
end

divide(1000000000, 2)
