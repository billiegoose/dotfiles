require "encpath"

function getSavePath(filename)
  return _G._USERHOME .. "/last_place/" .. path2name(filename)
end

function saveCursor(buffer)
  if buffer.filename then
    local save_path = getSavePath(buffer.filename)
    local f = io.open(save_path, "w")
    if f ~= nil then
      f:write(buffer.selection_start)
      f:write(' ')
      f:write(buffer.selection_end)
      f:write(' ')
      f:write(buffer.first_visible_line)
      f:close()
    end
  end
end

function saveCursors()
  for i,t in ipairs(_BUFFERS) do
    saveCursor(t)
  end
end

events.connect(events.FILE_BEFORE_SAVE, saveCursor)
events.connect(events.QUIT, saveCursors)

function restoreCursor(filename)
  local save_path = getSavePath(filename)
  local f = io.open(save_path, "r")
  if f ~= nil then
    buffer.selection_start    = f:read("*number")
    buffer.selection_end      = f:read("*number")
    buffer.first_visible_line = f:read("*number")
    f:close()
  end
end

events.connect(events.FILE_OPENED, restoreCursor)
