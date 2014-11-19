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
 '(ansi-color-names-vector ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#GENERALIDADES"])
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes (quote ("756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" "b21bf64c01dc3a34bc56fff9310d2382aa47ba6bc3e0f4a7f5af857cd03a7ef7" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" default)))
 '(delete-selection-mode t)
 '(ergoemacs-handle-ctl-c-or-ctl-x (quote only-C-c-and-C-x))
 '(ergoemacs-smart-paste (quote browse-kill-ring))
 '(fci-rule-color "#383838")
 '(org-CUA-compatible nil)
 '(org-agenda-files nil)
 '(org-clock-into-drawer t t)
 '(org-replace-disputed-keys t)
 '(recentf-mode t)
 '(shift-select-mode nil)
 '(sml/pos-id-separator (quote ("" (:propertize " " face powerline-active1) (:eval (propertize " " (quote display) (funcall (intern (format "powerline-%s-%s" powerline-default-separator (car powerline-default-separator-dir))) (quote powerline-active1) (quote powerline-active2)))) (:propertize " " face powerline-active2))))
 '(sml/pos-minor-modes-separator (quote ("" (:propertize " " face powerline-active1) (:eval (propertize " " (quote display) (funcall (intern (format "powerline-%s-%s" powerline-default-separator (cdr powerline-default-separator-dir))) (quote powerline-active1) nil))) (:propertize " " face sml/global))))
 '(sml/pre-id-separator (quote ("" (:propertize " " face sml/global) (:eval (propertize " " (quote display) (funcall (intern (format "powerline-%s-%s" powerline-default-separator (car powerline-default-separator-dir))) nil (quote powerline-active1)))) (:propertize " " face powerline-active1))))
 '(sml/pre-minor-modes-separator (quote ("" (:propertize " " face powerline-active2) (:eval (propertize " " (quote display) (funcall (intern (format "powerline-%s-%s" powerline-default-separator (cdr powerline-default-separator-dir))) (quote powerline-active2) (quote powerline-active1)))) (:propertize " " face powerline-active1))))
 '(sml/pre-modes-separator (propertize " " (quote face) (quote sml/modes)))
 '(sml/theme (quote dark))
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


;; ------------------------------------------------------------
;; Emacs reconoce las oraciones cuando encuentra un punto y dos
;; espacios. para que las reconozca con un solo espacio:
(setq sentence-end-double-space nil)


;; ------------------------------------------------------------------
;; para la navegacion rapida, los comandos se activan cuando el punto
;; esta al inicio del headline, sobre la primera estrella.

(setq org-use-speed-commands t)
(setq org-speed-commands-user (quote (("t" . outline-next-visible-heading)
                                      ("c" . outline-previous-visible-heading)
                                      ("n" . org-forward-heading-same-level)
                                      ("r" . org-backward-heading-same-level))))


;; -------------------------------------------------------------------
;; configuracion de org-mode, tambien se incluye el repositorio para
;; agregar los paquetes de contrib
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(load "~/.emacs.d/personal/config-org-mode-diego.el")


(defmacro hook-into-modes (func modes)
  `(dolist (mode-hook ,modes)
     (add-hook mode-hook ,func)))

(if (package-installed-p 'use-package)
    (message "ya esta instalado")
  (package-install 'use-package))

(require 'use-package)
(setq company-show-numbers t)


;; USE-PACKAGE


(use-package ergoemacs-mode
  :ensure ergoemacs-mode
  :init
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
  :config
  (progn
    (setq ergoemacs-theme nil)
    (setq ergoemacs-keyboard-layout "er")
    (ergoemacs-mode 1)))



(use-package yasnippet
  :ensure yasnippet
  :commands (yas-minor-mode yas-expand)
  :init
  (progn
    (defun company-yasnippet-or-completion ()
      (interactive)
      (if (yas/expansion-at-point)
          (progn (company-abort)
                 (yas/expand))
        (company-complete-common)))

    (defun yas/expansion-at-point ()
      "Tested with v0.6.1. Extracted from `yas/expand-1'"
      (first (yas/current-key)))

    (hook-into-modes #'(lambda () (yas-minor-mode 1))
                     '(org-mode-hook
                       python-mode-hook
                       rst-mode-hook))))



(use-package workgroups2
  ;; gestor de sesiones (guarda buffers y ventanas)
  :ensure workgroups2
  :init
  (workgroups-mode 1))



(use-package smart-mode-line
  :ensure smart-mode-line
  :config
  (progn
    (sml/setup)
    ;;(sml/apply-theme 'dark)
    ;;;;(sml/apply-theme 'light)
    ;;(sml/apply-theme 'respectful)
    (sml/apply-theme 'automatic)
    ;;(sml/apply-theme 'powerline))
))



(use-package aggressive-indent
  ;; Nuevo modo de indentación (creado por artur malabarba), reemplaza
  ;; al modo electric-indent-mode
  ensure: aggressive-indent
  init:
  (global-aggressive-indent-mode))



(use-package popup
  :ensure popup
  :commands popup-tip)  ; el comando popup-tip lo saqué por prueba y
                        ; error. si ponía popup solamente, la función
                        ; describe-thing-in-popup no funcionaba


(use-package help-fns+
  ;; help-fns+ mejora las ayudas. además, se agrega una función para
  ;; que la ayuda sobre la función debajo del punto se abra en una
  ;; ventanita (sin ocupar un buffer aparte). Esto último me lo
  ;; recomendaron en mi pregunta en Emacs.SE: how to get the function
  ;; help without typing.
  :ensure help-fns+
  :init
  (defun describe-thing-in-popup ()
    (interactive)
    (let* ((thing (symbol-at-point))
           (help-xref-following t)
           (description (save-window-excursion
                          (with-temp-buffer
                            (help-mode)
                            (help-xref-interned thing)
                            (buffer-string)))))
      (popup-tip description
                 :point (point)
                 :around t
                 :height 20
                 :scroll-bar t
                 :margin t))))



;; KEYBINDINGS


(global-set-key (kbd "M-a") 'helm-M-x)
(global-set-key (kbd "<M-f12>") 'menu-bar-mode)
(global-set-key (kbd "s-l") 'describe-thing-in-popup)


;; ------------------------------------------------------------------
;; quitar keybindings en algunos modos que tapan funciones habituales

(define-key prelude-mode-map (kbd "M-o") nil)
(define-key org-mode-map (kbd "M-a") nil)

;; ------------------------------------------------------------------
;; keybindings para navegar en org-mode

(define-key org-mode-map (kbd "s-c") 'outline-previous-visible-heading)
(define-key org-mode-map (kbd "s-t") 'outline-next-visible-heading)
(define-key org-mode-map (kbd "s-n") 'org-forward-heading-same-level)
(define-key org-mode-map (kbd "s-r") 'org-backward-heading-same-level)
;; (define-key org-mode-map (kbd "S-s-c") 'outline-up-heading)
(define-key org-mode-map (kbd "s-h") 'org-goto)



;; -----------------------------------------------------------
;; para company

(defun company-abort-y-completar-caracter (mi-char)
  (company-abort)
  (insert mi-char))

(define-key company-active-map (kbd "SPC")
  (lambda() (interactive) (company-abort-y-completar-caracter '" ")))

(define-key company-active-map [return] 'company-complete-selection)
;; (define-key company-active-map (kbd "M-c") 'company-select-previous-or-abort)
;; (define-key company-active-map (kbd "M-t") 'company-select-next-or-abort)
;; ------------------------------------------------------------
;; para evitar que se molesten los modos de company y yasnippet
;; "\t" se refiere a TAB

(define-key company-active-map "\t" 'company-yasnippet-or-completion)


;; ------------------------------------------------------------
;; intercambio de letras para facilitar keybindings en dvorak
;; (global-set-key (kbd "C-t") 'previous-line)
;; (keyboard-translate ?\C-x ?\C-u)
;; (keyboard-translate ?\C-u ?\C-x)


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



;; ------------------------------------------------------------
;; emacs server
;; do not close the file that was being edited when C-x # is typed
;; (setq server-kill-new-buffers nil)

;; ------------------------------------------------------------
;; start the emacs server for emacsclient
;; (server-start)

;; ------------------------------------------------------------
;; setup custom shortcuts
;; (global-set-key "\C-x\C-g" 'goto-line)

;; (global-set-key (kbd "<C-f5>") 'compile)
;; (global-set-key (kbd "<C-f6>") 'next-error)

;; ------------------------------------------------------------
;; guide key abre un buffer con las opciones de keybindings
;; correspondientes a cada prefix-keys que se vayan apretando

;; (require 'guide-key)
;; (setq guide-key/guide-key-sequence '("C-x" "C-c"))
;; (setq guide-key/recursive-key-sequence-flag t)
;; (guide-key-mode 1)


;; ------------------------------------------------------------
;; slime

;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
;; (setq inferior-lisp-program "sbcl")



;; ------------------------------------------------------------
;; mis definiciones de teclas

;; (global-set-key (kbd "<f2>") 'kill-ring-save)
;; (global-set-key (kbd "<f3>") 'yank)



;; ------------------------------------------------------------
;; setear ipython -sin el notebook-
;; ("How to open IPython interpreter in emacs?" en stackexchange)

;; (when (executable-find "ipython")
;;   (setq
;;    python-shell-interpreter "ipython"
;;    python-shell-interpreter-args ""
;;    python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;    python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;;    python-shell-completion-setup-code
;;    "from IPython.core.completerlib import module_completion"
;;    python-shell-completion-module-string-code
;;    "';'.join(module_completion('''%s'''))\n"
;;    python-shell-completion-string-code
;;    "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"))


;; ------------------------------------------------------------
;; para que M-S-down y M-S-up funcionen en org-mode

;; (define-key prelude-mode-map [(meta shift up)] nil)
;; (define-key prelude-mode-map [(meta shift down)] nil)
