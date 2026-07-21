((raw_string_literal
  (string_content) @injection.content)
  (#match? @injection.content "^[ \t\n]*(SELECT|INSERT|UPDATE|DELETE|WITH|CREATE)")
  (#set! injection.language "sql"))

((string_literal
  (string_content) @injection.content)
  (#match? @injection.content "^[ \t\n]*(SELECT|INSERT|UPDATE|DELETE|WITH|CREATE)")
  (#set! injection.language "sql"))
