-- Copyright 2006-2015 Mitchell mitchell.att.foicica.com. See LICENSE.
-- PHP LPeg lexer.

local l = require('lexer')
local token, word_match = l.token, l.word_match
local P, R, S, V = lpeg.P, lpeg.R, lpeg.S, lpeg.V

local M = {_NAME = 'dust'}

-- Whitespace.
local ws = token(l.WHITESPACE, l.space^1)

-- Dust.
local operator = token(l.OPERATOR, S('</+|'))
local word = token(l.FUNCTION, l.word)

M._rules = {
  {'whitespace', ws},
  {'operator', operator}
}

-- Embedded in HTML.
local html = l.load('html')

-- Embedded PHP.
local dust_start_rule = token('dust_tag', '{')
local dust_end_rule = token('dust_tag', '}')
l.embed_lexer(html, M, dust_start_rule, dust_end_rule)

M._tokenstyles = {
  dust_tag = l.STYLE_OPERATOR
}

return M
