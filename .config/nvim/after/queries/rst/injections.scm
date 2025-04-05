; extends

((directive
   name: (type) @_type
   body: (body (content) @injection.content))
 (#any-of?
  @_type
  "friend" "book" "artwork" "artist" "gallery" "event"
  "leetcode" "term" "jour" "okr" "people" "rhythm" "dev"
  "okr")
 (#set! injection.language "rst"))

((directive
   name: (type) @_type
   body: (body (content) @injection.content))
 (#any-of?
  @_type
  "lily")
 (#set! injection.language "lilypond"))
