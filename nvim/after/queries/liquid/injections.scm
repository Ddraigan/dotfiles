; extends

((liquid_tag
    (tag_name) @tag_name (#eq? @tag_name "stylesheet")
    (body) @css)
  (#set! injection.language "css")
  (#set! injection.include-children))
