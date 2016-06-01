-- taken from Star Picker-Upper by @seleb
-- http://www.lexaloffle.com/bbs/?tid=3432

-- print white text with dark blue outline
function print_ol(s,_x,_y)
  for x=-1,1 do
    for y=-1,1 do
      print(s,_x+x,_y+y,2)
    end
  end
  print(s,_x,_y,8)
end

-- print outline text centered
function print_ol_c(s,_y)
  print_ol(s,64-#s*4/2,_y)
end
