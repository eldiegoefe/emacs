;;; configuraciones personales de emacs
;;; diego efe *** argentina *** 2014
;;; tw: @eldiegoefe *** fb: el diego efe
;;; em: eldiegoefe@gmail.com

;;; usando prelude, by bbatsov
;;; https://github.com/bbatsov/prelude

;; ------------------------------------------------------------
;; ------------------------------------------------------------
;; lineas de configuración automática (¿prelude?)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes (quote ("3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" default)))
 '(fci-rule-color "#383838")
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map (quote ((20 . "#BC8383") (40 . "#CC9393") (60 . "#DFAF8F") (80 . "#D0BF8F") (100 . "#E0CF9F") (120 . "#F0DFAF") (140 . "#5F7F5F") (160 . "#7F9F7F") (180 . "#8FB28F") (200 . "#9FC59F") (220 . "#AFD8AF") (240 . "#BFEBBF") (260 . "#93E0E3") (280 . "#6CA0A3") (300 . "#7CB8BB") (320 . "#8CD0D3") (340 . "#94BFF3") (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; ------------------------------------------------------------
;; ------------------------------------------------------------
;; inicio de las configuraciones extraidas del video 8 de rt2011
;; ------------------------------------------------------------


;; ------------------------------------------------------------
;; emacs server
;; do not close the file that was being edited when C-x # is typed
(setq server-kill-new-buffers nil)

;; ------------------------------------------------------------
;; start the emacs server for emacsclient
(server-start)

;; ------------------------------------------------------------
;; setup custom shortcuts
(global-set-key "\C-x\C-g" 'goto-line)
(global-set-key (kbd "<C-f5>") 'compile)
(global-set-key (kbd "<C-f6>") 'next-error)

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

;; ------------------------------------------------------------
;; fin de las configuraciones extraidas del video 8 de rt2011
;; ------------------------------------------------------------
;; ------------------------------------------------------------


;; ------------------------------------------------------------
;; yasnippets

(add-to-list 'load-path
             "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)


;; ------------------------------------------------------------
;; para evitar que se molesten los modos de company y yasnippet

(define-key company-active-map "\t" 'company-yasnippet-or-completion)

(defun company-yasnippet-or-completion ()
  (interactive)
  (if (yas/expansion-at-point)
      (progn (company-abort)
             (yas/expand))
    (company-complete-common)))

(defun yas/expansion-at-point ()
  "Tested with v0.6.1. Extracted from `yas/expand-1'"
  (first (yas/current-key)))


;; ------------------------------------------------------------
;; slime

(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")


;; ------------------------------------------------------------
;; para que M-S-down y M-S-up funcionen en org-mode

(define-key prelude-mode-map [(meta shift up)] nil)
(define-key prelude-mode-map [(meta shift down)] nil)


;; ------------------------------------------------------------
;; mis definiciones de teclas

(global-set-key (kbd "<f2>") 'kill-ring-save)
(global-set-key (kbd "<f3>") 'yank)


;; ------------------------------------------------------------
;; intercambio de letras para facilitar keybindings en dvorak

(global-set-key (kbd "C-t") 'previous-line)
(keyboard-translate ?\C-x ?\C-u)
(keyboard-translate ?\C-u ?\C-x)


;; ------------------------------------------------------------
;; setear ipython -sin el notebook-
;; ("How to open IPython interpreter in emacs?" en stackexchange)

(when (executable-find "ipython")
  (setq
   python-shell-interpreter "ipython"
   python-shell-interpreter-args ""
   python-shell-prompt-regexp "In \\[[0-9]+\\]: "
   python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
   python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
   python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
   python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"))


;; ------------------------------------------------------------
;; gestor de sesiones (guarda buffers y ventanas)
(require 'workgroups2)
(workgroups-mode 1)


;; ------------------------------------------------------------
;; ------------------------------------------------------------
;; fuera de uso
;; ------------------------------------------------------------


;; ------------------------------------------------------------
;; emacs ipyython notebook (no funciona: oct2014)

;; (require 'ein)
;;(setq ipython-command "/usr/bin/ipython")
;;(require 'ipython)


;; ------------------------------------------------------------
;; para guardar los buffers abiertos (no guarda las ventanas)

;; (desktop-save-mode 1)
