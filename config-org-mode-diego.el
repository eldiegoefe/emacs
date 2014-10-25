;; ------------------------------------------------------------
;; para correr trozos de código dentro de org-mode
;; must have org-mode loaded before we can configure org-babel
(require 'org-install)

;; ------------------------------------------------------------
;; some initial langauges we want org-babel to support
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (R . t)
   (ruby . t)
   (ditaa . t)
   (dot . t)
   (octave . t)
   (sqlite . t)
   (perl . t)
   ))
