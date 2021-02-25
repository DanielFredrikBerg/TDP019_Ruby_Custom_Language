(TeX-add-style-hook
 "TDP019mall"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("xcolor" "usenames" "x11names" "svgnames") ("hyperref" "colorlinks=false" "hidelinks") ("babel" "swedish")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "fontspec"
    "xcolor"
    "fancyhdr"
    "hyperref"
    "tabularx"
    "titling"
    "fullpage"
    "lastpage"
    "tikz"
    "parskip"
    "babel")
   (TeX-add-symbols
    "projectpage")
   (LaTeX-add-lengths
    "borderwidth"))
 :latex)

