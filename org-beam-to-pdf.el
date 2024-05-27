(dolist (f (file-expand-wildcards "*.org"))
  (find-file f)
  (org-beamer-export-to-latex)
  (call-process "pdflatex" nil "* org-beam-to-pdf output *" t (replace-regexp-in-string "org$" "tex" f)))
