; extends

; https://sphinx.silverrainz.me/strike/
((interpreted_text
  (role) @_role
  "interpreted_text" @markup.strikethrough)
  (#any-of?
   @_role
   ":del:" ":strike:"))

; https://sphinx.silverrainz.me/any/
((directive
   name: (type) @function.builtin)
 (#any-of?
  @function.builtin
  "friend" "book" "artwork" "artist" "gallery" "event" "leetcode" "term" "jour"
  "okr" "people" "rhythm" "dev"))

; https://sphinx-design.readthedocs.io/
((directive
   name: (type) @function.builtin)
 (#any-of?
  @function.builtin
  "grid" "grid-item" "grid-item-card"
  "card" "card-carousel"
  "dropdown" "card-carousel"
  "tabset" "tab-set-code" "tab-item"
  ))
