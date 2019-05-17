(TeX-add-style-hook "math1"
 (lambda ()
    (LaTeX-add-environments
     "thm")
    (LaTeX-add-bibitems
     "a")
    (TeX-run-style-hooks
     "listings"
     "amsthm"
     "amssymb"
     "amsmath"
     "babel"
     "danish"
     "inputenc"
     "utf8"
     "latex2e"
     "rep10"
     "report"
     "")))

