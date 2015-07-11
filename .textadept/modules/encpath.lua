--[[
http://stackoverflow.com/a/4814299/2168416
Use the String of the path and encode just the specials, like:

% -> %%
\ -> %)
/ -> %(
: -> %;
--]]
-- Since % already means something in lua, I use a different escape character.
function path2name (str)
  str = string.gsub(str,  "^", "^^")
  str = string.gsub(str, "\\", "^)")
  str = string.gsub(str,  "/", "^(")
  str = string.gsub(str,  ":", "^;")
  return str
end
