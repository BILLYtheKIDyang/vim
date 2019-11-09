def fib(n)
  if n < 2
    n
  else
    fib(n - 2) + fib(n - 1)
  end
end

print "fib (6) = ", fib(6), "\n"

class Stack
  def initialize
    @stack = []
    @sp = 0
  end

  def push(value)
    @stack[@sp] = value
    @sp += 1
  end

  def pop
    return nil if @sp == 0
    @sp -= 1
    return @stack[@sp]
  end
end

stack = Stack.new
stack.push(1)
stack.push(2)
stack.push(3)
stack.pop()
stack.pop
stack.pop
stack.pop
