-- Import from tmux 'clipboard'. (E.g. on application start)
function import_tmux_clipboard(buffer)
  -- Import clipboard from tmux
  local p = spawn('tmux save-buffer -b 0 -')
  local text = p:read("*all")
  buffer.copy_text(buffer, text)
end

-- Copy into tmux 'clipboard'
function copy_tmux(buffer)
  -- Replicate normal copy operation
  buffer.copy(buffer)
  -- Export clipboard to tmux
  local p = spawn('tmux load-buffer -b 0 -')
  p:write(ui.clipboard_text)
  p:close()
end

-- Cut into tmux 'clipboard'
function cut_tmux(buffer)
  -- Replicate normal cut operation
  buffer.cut(buffer)
  -- Export clipboard to tmux
  local p = spawn('tmux load-buffer -b 0 -')
  p:write(ui.clipboard_text)
  p:close()
end

-- Paste from tmux 'clipboard'
function paste_tmux(buffer)
  -- Import clipboard from tmux
  local p = spawn('tmux save-buffer -b 0 -')
  local text = p:read("*all")
  buffer.copy_text(buffer, text)
  -- Replicate normal paste operation
  buffer.paste(buffer)
end

-- Edit shortcut keys as desired. I override the defaults.
keys['cc'] = { copy_tmux, buffer }
keys['cx'] = { cut_tmux, buffer }
keys['cv'] = { paste_tmux, buffer }
