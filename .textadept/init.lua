require "modules/last_place"
textadept.editing.AUTOPAIR = false
textadept.editing.TYPEOVER_CHARS = false
textadept.editing.STRIP_TRAILING_SPACES = true
require "modules/tmux_clipboard"
import_tmux_clipboard(buffer)
textadept.file_types.extensions.dust = 'dust'
textadept.file_types.extensions.coffee = 'coffeescript'
