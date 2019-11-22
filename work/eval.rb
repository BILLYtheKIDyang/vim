ps1 =  "ruby> "
code = ''
print ps1
while true
  line = line
  begin; line = readline(); rescue EOFError; break; end
  if line.length > 1
    code = code + line
    print ' ' * ps1.length 
  else
    puts "|#{code.strip()}|"
    begin
      if code.strip().length > 0 
        puts eval(code)
      end
    rescue Exception  => e
      puts $!
    end
    code = ''
    print ps1
  end
end
