;;; configuraciones personales de emacs
;;; diego efe *** argentina *** 2014
;;; tw: @eldiegoefe *** fb: el diego efe
;;; em: eldiegoefe@gmail.com

;;; usando prelude, by bbatsov
;;; https://github.com/bbatsov/prelude


;; -----------------------------------------------------------------
;; Tras la última actualización-instalación (2015-04) muestra un
;; cuadro de diálogo con info sobre magit. Esto es para que no
;; aparezca más.
(setq magit-last-seen-setup-instructions "1.4.0")

;; -----------------------------------------------------------------
;; guarda todas las variables y faces de M-x customize en un archivo
;; aparte.
(setq custom-file "~/.emacs.d/personal/my-custom.el")
(load custom-file)


;; -----------------------------------------------------
;; habilita auto-fill-mode para todos los modos de texto

(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; ------------------------------------------------------------
;; Emacs reconoce las oraciones cuando encuentra un punto y dos
;; espacios. para que las reconozca con un solo espacio:
(setq sentence-end-double-space nil)


;; ------------------------------------------------------------------
;; para que funcione el lisp que instalé (sbcl, ver en mi propio blog
;; la entrada "A punto para Lisp").

;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
;; (setq inferior-lisp-program "sbcl")


;; -------------------------------------------------------------------
;; configuracion de org-mode, tambien se incluye el repositorio para
;; agregar los paquetes de contrib
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(load "~/.emacs.d/personal/org-mode-del-diego.el")


(defmacro hook-into-modes (func modes)
  `(dolist (mode-hook ,modes)
     (add-hook mode-hook ,func)))

(if (package-installed-p 'use-package)
    (message "ya esta instalado")
  (package-install 'use-package))

(require 'use-package)
(setq company-show-numbers t)

;; configuracion para erc (chat de irc). mas info en:
;; https://www.gnu.org/software/emacs/manual/html_mono/erc.html y en
;; https://xdev.me/en/article/How_to_use_IRC_in_Emacs

(global-set-key (kbd "s-e") (lambda () (interactive)
                           (erc :server "irc.freenode.net" :port "6667"
                                :nick "eldiegoefe" :password "Z3aAwwfJiKmc")))

(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))


;; dired+ agrega funcionalidades y dired-sort-menu permite ordenar los
;; archivos y directorios según criterios seleccionables desde el menú
;; (nombre, extensión, fecha, etc)

(require 'dired+)
(require 'dired-sort-menu+)


;; Use-Package


(use-package ergoemacs-mode
  :ensure t
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
  :defer t
  :commands (yas-minor-mode yas-expand yas-load-directory)
  :init
  (progn
    ;; (defun company-yasnippet-or-completion ()
    ;;   (interactive)
    ;;   (if (yas/expansion-at-point)
    ;;       (progn (company-abort)
    ;;              (yas/expand))
    ;;     (company-complete-common)))

    ;; (defun yas/expansion-at-point ()
    ;;   "Tested with v0.6.1. Extracted from `yas/expand-1'"
    ;;   (first (yas/current-key)))

    (hook-into-modes #'(lambda () (yas-minor-mode 1))
                     '(org-mode-hook
                       python-mode-hook
                       rst-mode-hook))
    (yas-load-directory "~/.emacs.d/personal/misSnippets")
    ))


;; nuevo modo para guardar el escritorio, desde emacs 24.4
(desktop-save-mode 1)


;; (use-package workgroups2
;;   ;; gestor de sesiones (guarda buffers y ventanas)
;;   :ensure t
;;   :init
;;   (workgroups-mode 1))


;; (use-package smart-mode-line
;;   :ensure t
;;   :config
;;   (progn
;;     (sml/setup)
;;     ;;(sml/apply-theme 'dark)
;;     ;;(sml/apply-theme 'light)
;;     ;;(sml/apply-theme 'respectful)
;;     ;;(sml/apply-theme 'automatic)
;;     (sml/apply-theme 'powerline)))


;; (use-package aggressive-indent
;;   ;; Nuevo modo de indentación (creado por artur malabarba), reemplaza
;;   ;; al modo electric-indent-mode
;;   ensure: t
;;   init:
;;   (global-aggressive-indent-mode))



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


(use-package ace-jump-mode
  :ensure t
  :bind ("C-c SPC" . ace-jump-mode))

(use-package ace-window
  :ensure t
  :bind ("M-o" . ace-window))


;; Inicio el servidor

(server-start)

;; KEYBINDINGS


(global-set-key (kbd "M-a") 'helm-M-x)
(global-set-key (kbd "<M-f12>") 'menu-bar-mode)
(global-set-key (kbd "s-l") 'describe-thing-in-popup)


;; ------------------------------------------------------------------
;; quitar keybindings en algunos modos que tapan funciones habituales

(define-key prelude-mode-map (kbd "M-o") nil)
(define-key org-mode-map (kbd "M-a") nil)



;; -----------------------------------------------------------
;; para company




;; (defun company-abort-y-completar-caracter (mi-char)
;;   (company-abort)
;;   (insert mi-char))

;; (define-key company-active-map (kbd "SPC")
;;   (lambda() (interactive) (company-abort-y-completar-caracter '" ")))

;; (define-key company-active-map [return] 'company-complete-selection)




;; (define-key company-active-map (kbd "M-c") 'company-select-previous-or-abort)
;; (define-key company-active-map (kbd "M-t") 'company-select-next-or-abort)
;; ------------------------------------------------------------
;; para evitar que se molesten los modos de company y yasnippet
;; "\t" se refiere a TAB

;; (define-key company-active-map "\t" 'company-yasnippet-or-completion)




;;(define-key company-active-map "s-d" 'yas-expand)




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
