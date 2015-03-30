;; ;; -------------------------------------------------------------------
;; ;; para configurar esto tomé en cuenta los tutoriales que están en
;; ;; http://orgmode.org/worg/org-tutorials/orgtutorial_dto.html y en
;; ;; http://doc.norang.ca/org-mode.html


;; ;; -------------------------------------------------------------------
;; ;; no olvidar que también hay configuraciones de org-mode que hace
;; ;; prelude en ~/.emacs.d/modules/prelude-org.el


;; ;; -------------------------------------------------------------------
;; ;; la variable auto-mode-alist también está definida en
;; ;; prelude-org.el, pero probé acá e igual anda (está seteada para
;; ;; abrir en modo org a los archivos cuyas extensiones sean org,
;; ;; org_archive y txt)

;; (add-to-list 'load-path (expand-file-name "~/git/org-mode/lisp"))
;; (add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
;; (require 'org)


;; -------------------------------------------------------------------
;; esta parte está en prelude-org.el.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done t)


;; ------------------------------------------------------------
;; para correr trozos de código dentro de org-mode
;; must have org-mode loaded before we can configure org-babel
(require 'org-install)


;; ------------------------------------------------------------
;; some initial langauges we want org-babel to support
;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '(
;;    (sh . t)
;;    (python . t)
;;    (R . t)
;;    (ruby . t)
;;    (ditaa . t)
;;    (dot . t)
;;    (octave . t)
;;    (sqlite . t)
;;    (perl . t)
;;    ))


;; -------------------------------------------------------------------
;; en vez de seleccionar archivos individuales, voy a conssiderar
;; todos los que estén dentro del directorio mis-archivos-org para
;; armar la agenda. igual dejo, por ahora, comentada, la versión con
;; archivos individuales.

;; esta es la lista de archivos que contienen tareas (TODOs), en los
;; cuales se fija para armar la agenda

;; (setq org-agenda-files (list "~/mis-archivos-org/apuntes-varios.org"
;;                              "~/mis-archivos-org/proyectos.org"
;;                              "~/mis-archivos-org/emacs.org"))

(setq org-agenda-files (list "~/mis-archivos-org/"))


;; -------------------------------------------------------------------
;; variables para que aparezcan los datos de la temporización de
;; actividades dentro de un drawer.

(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))     ;; Separate drawers for clocking and logs
(setq org-clock-into-drawer t)    ;; Save clock data and state changes and notes in the LOGBOOK drawer


;; -------------------------------------------------------------------
;; secuencia de palabras clave para TODO.

(setq org-todo-keywords
      '((sequence "TODO(t)" "EMPEZADO(e)" "ESPERANDO(s)" "HIBERNANDO(h)" "|" "INCUMPLIDO(i)" "COMPLETADO(c)" "CANCELADO(o)")
        (sequence "PARA LEER(p)" "LEYENDO(y)" "|" "LEIDO(l)" "ABANDONADO(a)")))

(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "red" :weight bold))
        ("EMPEZADO" . (:foreground "green" :weight bold))
        ("ESPERANDO" . (:foreground "orange" :weight bold))
        ("HIBERNANDO" . (:foreground "deep sky blue" :weight bold))
        ("INCUMPLIDO" . (:foreground "tan" :weight bold))
        ("COMPLETADO" . (:foreground "forest green"))
        ("CANCELADO" . (:foreground "grey"))
        ("PARA LEER" . (:foreground "salmon"))
        ("LEYENDO" . (:foreground "goldenrod"))
        ("LEIDO" . (:foreground "sea green"))
        ("ABANDONADO" . (:foreground "grey"))
        ))


;; ------------------------------------------------------------------
;; para la navegacion rapida, los comandos se activan cuando el punto
;; esta al inicio del headline, sobre la primera estrella.

(setq org-use-speed-commands t)
(setq org-speed-commands-user (quote (("t" . outline-next-visible-heading)
                                      ("c" . outline-previous-visible-heading)
                                      ("n" . org-forward-heading-same-level)
                                      ("r" . org-backward-heading-same-level))))

;; ------------------------------------------------------------------
;; keybindings para navegar en org-mode

(define-key org-mode-map (kbd "s-c") 'outline-previous-visible-heading)
(define-key org-mode-map (kbd "s-t") 'outline-next-visible-heading)
(define-key org-mode-map (kbd "s-n") 'org-forward-heading-same-level)
(define-key org-mode-map (kbd "s-r") 'org-backward-heading-same-level)
;; (define-key org-mode-map (kbd "S-s-c") 'outline-up-heading)
(define-key org-mode-map (kbd "s-h") 'org-goto)
