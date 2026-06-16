; extends

; SilverRainZ/bullet
((directive
   name: (type) @_type
   body: (body (content) @injection.content))
 (#any-of?
  @_type
  "friend" "book" "artwork" "artist" "gallery" "event"
  "leetcode" "term" "jour" "okr" "people" "rhythm" "dev"
  "okr")
 (#set! injection.language "rst"))

; sphinxnotes-lilypond
((directive
   name: (type) @_type
   body: (body (content) @injection.content))
 (#any-of?
  @_type
  "lily")
 (#set! injection.language "lilypond"))

; sphinxnotes-project
((directive
   name: (type) @_type
   body: (body (content) @injection.content))
 (#any-of?
  @_type
  "example" "autoconfval" "autoobject")
 (#set! injection.language "rst"))

; sphinxnotes-render
((directive
   name: (type) @_type
   body: (body (content) @injection.content))
 (#any-of?
  @_type
  "data.template" "data.render")
 (#set! injection.language "jinja"))
