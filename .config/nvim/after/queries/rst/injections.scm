((directive
  name: (type) @_type
  body: (body
    (content) @injection.content))
  (#set! injection.language "python")
  (#eq? @_type "lily"))
