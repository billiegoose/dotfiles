-- Copyright 2006-2015 Mitchell mitchell.att.foicica.com. See LICENSE.
-- CoffeeScript LPeg lexer.

local l = require('lexer')
local token, word_match = l.token, l.word_match
local P, S = lpeg.P, lpeg.S

local M = {_NAME = 'coffeescript'}

-- Whitespace.
local ws = token(l.WHITESPACE, l.space^1)

-- Comments.
local block_comment = '###' * (l.any - '#') * (l.any - '###')^0 * P('###')^-1
local line_comment = '#' * l.nonnewline_esc^0
local comment = token(l.COMMENT, block_comment + line_comment)

-- Strings.
local large_sq_str = "'''" * (l.any - "'''")^0 * "'''"
local small_sq_str = l.delimited_range("'")
local sq_str = large_sq_str + small_sq_str
-- Interpolated strings.
local inner_code = token(l.EMBEDDED, '#' * l.nested_pair('{','}'))
local large_dq_str = l.token(l.STRING, '"""')
                     * (inner_code + l.token(l.STRING, l.any - '"""'))^0
                     * l.token(l.STRING, '"""')
local small_dq_str = l.token(l.STRING, '"')
                     * (inner_code + l.token(l.STRING, l.any -  '"' ))^0
                     * l.token(l.STRING, '"')
local dq_str = large_dq_str + small_dq_str
local regex_str = l.last_char_includes('+-*%<>!=^&|?~:;,([{') *
                  l.delimited_range('/', true) * S('igm')^0
local string = large_dq_str + small_dq_str + token(l.STRING, sq_str) + token(l.REGEX, regex_str)

-- Numbers.
local number = token(l.NUMBER, l.float + l.integer)

-- Keywords.
local keyword = token(l.KEYWORD, word_match{
  'all', 'and', 'bind', 'break', 'by', 'case', 'catch', 'class', 'const',
  'continue', 'default', 'delete', 'do', 'each', 'else', 'enum', 'export',
  'extends', 'false', 'for', 'finally', 'function', 'if', 'import', 'in',
  'instanceof', 'is', 'isnt', 'let', 'loop', 'native', 'new', 'no', 'not', 'of',
  'off', 'on', 'or', 'return', 'super', 'switch', 'then', 'this', 'throw',
  'true', 'try', 'typeof', 'unless', 'until', 'var', 'void', 'with', 'when',
  'while', 'yes'
})

-- Fields: object properties and methods.
local field = token(l.FUNCTION, '.' * (S('_$') + l.alpha) *
                                (S('_$') + l.alnum)^0)

-- Identifiers.
local identifier = token(l.IDENTIFIER, l.word)

-- Operators.
local operator = token(l.OPERATOR, S('+-/*%<>!=^&|?~:;,.()[]{}'))

M._rules = {
  {'whitespace', ws},
  {'keyword', keyword},
  {'field', field},
  {'identifier', identifier},
  {'comment', comment},
  {'number', number},
  {'string', string},
  {'operator', operator},
}

M._FOLDBYINDENTATION = true

return M
