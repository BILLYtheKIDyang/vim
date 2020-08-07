# the function must be defined in such a place 
# ... so as to "catch" the binding of the vars ... cheesy
# otherwise we're kinda stuck with the extra param on the caller
@_binding = binding
def write_pair(p, b = @_binding)
  eval("
    local_variables.each do |v| 
      if eval(v.to_s + \".object_id\") == " + p.object_id.to_s + "
        puts v.to_s + ': ' + \"" + p.to_s + "\"
      end
    end
  " , b)
end

# if the binding is an issue just do here:
# write_pair = lambda { |p| write_pair(p, binding) }

# just some test vars to make sure it works
username1 = "tyndall"
username  = "tyndall"
username3 = "tyndall"

# the result:
write_pair(username)
# username: tyndall
