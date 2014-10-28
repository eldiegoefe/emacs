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
 '(custom-safe-themes (quote ("b21bf64c01dc3a34bc56fff9310d2382aa47ba6bc3e0f4a7f5af857cd03a7ef7" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" default)))
 '(delete-selection-mode t)
 '(fci-rule-color "#383838")
 '(initial-scratch-message nil)
 '(org-CUA-compatible nil)
 '(org-replace-disputed-keys t)
 '(recentf-menu-before nil)
 '(recentf-mode t)
 '(shift-select-mode nil)
 '(smex-prompt-string nil)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map (quote ((20 . "#BC8383") (40 . "#CC9393") (60 . "#DFAF8F") (80 . "#D0BF8F") (100 . "#E0CF9F") (120 . "#F0DFAF") (140 . "#5F7F5F") (160 . "#7F9F7F") (180 . "#8FB28F") (200 . "#9FC59F") (220 . "#AFD8AF") (240 . "#BFEBBF") (260 . "#93E0E3") (280 . "#6CA0A3") (300 . "#7CB8BB") (320 . "#8CD0D3") (340 . "#94BFF3") (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(yas-snippet-dirs (quote ("~/.emacs.d/personal/misSnippets/" yas-installed-snippets-dir)) nil (yasnippet)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; -------------------------------------------------------------------
;; para agregar los paquetes de contrib

(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

;; nuevo layout de ergoemacs

(defvar ergoemacs-layout-er
  '("" ""   "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" ""  ""  ""
    "" "\\" "." "," ";" "p" "y" "f" "g" "c" "h" "l" ""  ""  ""
    "" ""   "a" "o" "e" "u" "i" "d" "r" "t" "n" "s" "'" ""  ""
    "" ""   "-" "q" "j" "k" "x" "b" "m" "w" "v" "z" ""  ""  ""
    ;; Shifted
    "" ""  "!" "@" "#" "$" "%" "^" "&" "*" "(" ")" ""  "" ""
    "" "|" ">" "<" ":" "P" "Y" "F" "G" "C" "H" "L" ""  "" ""
    "" ""  "A" "O" "E" "U" "I" "D" "R" "T" "N" "S" "'" "" ""
    "" ""  "_" "Q" "J" "K" "X" "B" "M" "W" "V" "Z" ""  "" "")
  "Ergodox con Dvorak.  Del Diego Efe.")

;; -------------------------------------------------------------------
;; ergoemacs de vuelta!

;; (package-initialize)

(setq ergoemacs-theme nil)
(setq ergoemacs-keyboard-layout "er")
(require 'ergoemacs-mode)
(ergoemacs-mode 1)


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
;; (server-start)

;; ------------------------------------------------------------
;; setup custom shortcuts
(global-set-key "\C-x\C-g" 'goto-line)
(global-set-key (kbd "<C-f5>") 'compile)
(global-set-key (kbd "<C-f6>") 'next-error)

;; -------------------------------------------------------------------
;; configuracion de org-mode

(load "~/.emacs.d/personal/config-org-mode-diego.el")
;; (load "~/.emacs.d/personal/config-org-mode.el")


;; ------------------------------------------------------------
;; fin de las configuraciones extraidas del video 8 de rt2011
;; ------------------------------------------------------------
;; ------------------------------------------------------------


;; ------------------------------------------------------------
;; yasnippets

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

;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
;; (setq inferior-lisp-program "sbcl")


;; ------------------------------------------------------------
;; para que M-S-down y M-S-up funcionen en org-mode

(define-key prelude-mode-map [(meta shift up)] nil)
(define-key prelude-mode-map [(meta shift down)] nil)


;; ------------------------------------------------------------
;; mis definiciones de teclas

(global-set-key (kbd "<f2>") 'kill-ring-save)
(global-set-key (kbd "<f3>") 'yank)

;; en /.emacs.d/core/prelude-global-keybindings.el está aun la
;; definición con <f12> pero la cambio acá para probar las cosas del
;; tutorial de org-mode. Queda entonces redundante, pero anda...

(global-set-key (kbd "<M-f12>") 'menu-bar-mode)


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
;; cambiar M-x a la version power de helm
(global-set-key (kbd "M-x") 'helm-M-x)

;; ------------------------------------------------------------
;; emacs reconoce las oraciones cuando encuentra punto y dos
;; espacios. para que las reconozca con un solo espacio:

(setq sentence-end-double-space nil)


;; ------------------------------------------------------------
;; smart mode line

(sml/setup)
;;(sml/apply-theme 'dark)
;;(sml/apply-theme 'light)
;;(sml/apply-theme 'respectful)
;;(sml/apply-theme 'automatic)
(sml/apply-theme 'powerline)


;; ------------------------------------------------------------
;; guide key abre un buffer con las opciones de keybindings
;; correspondientes a cada prefix-keys que se vayan apretando

(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x" "C-c"))
(setq guide-key/recursive-key-sequence-flag t)
(guide-key-mode 1)


;; -------------------------------------------------------------------
;; nuevo modo de indentación de artur malabarba, reemplaza
;; electric-indent-mode

(global-aggressive-indent-mode)

;; -------------------------------------------------------------------
;; desactivo key-chords para probar evil-mode

;; (key-chord-mode -1)


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


;; ------------------------------------------------------------
;; para poner mis snippets en ~/emacs.d/personal/misSnippets
;; edit: desactivado porque edité yas-snippet-dirs desde
;; customize variable.

;; (setq yas-snippet-dirs '("~/emacs.d/personal/misSnippets"))
