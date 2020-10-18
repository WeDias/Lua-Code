mem = {1, 1}
function fib(n)
  if not mem[n] then mem[n] = fib(n - 1) + fib(n - 2) end
  return mem[n]
end

print('Fib(100) = ' .. fib(100))
