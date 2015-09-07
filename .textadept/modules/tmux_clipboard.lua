-- Import from tmux 'clipboard' to textadept 'clipboard'.
function import_tmux_clipboard(buffer)
  -- Import clipboard from tmux
  local p = spawn('tmux save-buffer -b 0 -')
  local text = p:read("*all")
  if (text ~= nil) then
    buffer.copy_text(buffer, text)
  end
end

-- Export from textadept 'clipboard' to to tmux 'clipboard'.
function export_tmux_clipboard(ui)
  -- Export clipboard to tmux
  local p = spawn('tmux load-buffer -b 0 -')
  p:write(ui.clipboard_text)
  p:close()
end

-- Replace default Copy operation
function copy_tmux(buffer)
  -- Replicate normal copy operation
  buffer.copy(buffer)
  -- Then export clipboard to tmux
  export_tmux_clipboard(ui)
end

-- Replace default Cut operation
function cut_tmux(buffer)
  -- Replicate normal cut operation
  buffer.cut(buffer)
  -- Then export clipboard to tmux
  export_tmux_clipboard(ui)
end

-- Replace default Paste operation
function paste_tmux(buffer)
  -- Import clipboard from tmux
  import_tmux_clipboard(buffer)
  -- Replicate normal paste operation
  buffer.paste(buffer)
end

-- Edit shortcut keys as desired. I override the defaults.
keys['cc'] = { copy_tmux, buffer }
keys['cx'] = { cut_tmux, buffer }
keys['cv'] = { paste_tmux, buffer }
