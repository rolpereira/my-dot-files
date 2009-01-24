    ;(add-to-list 'load-path
         ;"~/.emacs-teste/ecb-snap")
        ;(require 'ecb)

(setq visible-bell t)
(setq load-path (append '("~/.emacs-teste") load-path))
(require 'tabbar)
(tabbar-mode)
(global-set-key [(control shift left)] 'tabbar-backward)
(global-set-key [(control shift right)] 'tabbar-forward)
(setq load-path (append '("/usr/share/emacs/site-lisp/pydb") load-path))
(add-to-list 'load-path "~/.emacs-teste")
(setq c-default-style "bsd")

; Tabs colocam 4 espacos
(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil)
(setq indent-tans-mode nil)
(setq tab-width 4)
(setq backward-delete-char-untabify nil)
(setq default-tab-width 4)
;;;

(load "psvn.el")

;Alguns modos precisam disto
(setq user-mail-address "finalyugi@sapo.pt")
;;;

; Utilizar o Ipython como interpretador de python
;(add-to-list 'load-path "~/.emacs-teste")
;(require 'ipython)
;(setq ipython-command "/usr/bin/ipython")
;;;

; Mostra so a * mais a direita no org-mode
(setq org-hide-leading-stars t)
;;;

; Mudar a theme do emacs
(require 'color-theme)
(color-theme-initialize)
;(color-theme-ld-dark)
;(color-theme-midnight)
(color-theme-robin-hood)
; Outros themes: midnight, white on black, charcoal black, Calm Forest, Billw,
; Arjen, Clarity and Beauty, Cooper Dark, Comidia, Dark Blue 2, Dark Laptop,
; Deep Blue, Hober, Late Night, Lethe, Linh Dang Dark, Taming Mr Arneson,
; Subtle Hacker, TTY Dark, Taylor,  White On Black
;;;

; Outro coloscheme
;; (set-background-color "black") 
;; (set-foreground-color "lightblue") 

;; (set-face-foreground 'font-lock-string-face  "#123467") ; 
;; (set-face-foreground 'font-lock-comment-face  "#aaaaaa") ;
;; (make-face-italic 'font-lock-comment-face)
 
;; (set-face-foreground 'font-lock-keyword-face  "lemonchiffon") ; 
;; (make-face-bold 'font-lock-keyword-face)

;; (set-face-foreground 'font-lock-string-face   "#ffffff") ; 
;; (set-face-foreground 'font-lock-preprocessor-face "red") ; 
;; (set-face-foreground 'font-lock-constant-face   "green") ; 
  
;; (set-face-foreground 'font-lock-type-face    "lightblue")
;; (make-face-bold 'font-lock-type-face)
    
;; (set-face-foreground 'font-lock-function-name-face "darkcyan")
;; (set-face-foreground 'font-lock-variable-name-face "darkgreen")
  
;; (set-face-foreground 'font-lock-warning-face "yellow")
;; (make-face-bold 'font-lock-warning-face)
;; (make-face-unitalic 'font-lock-warning-face)  
;; (set-face-underline  'font-lock-warning-face nil)
 
;; (set-face-background 'region "#777777")

;; (set-face-foreground 'mode-line "#777777")
;; (set-face-background 'mode-line "#333333")
;;;;;;;;;;;;

;; make C-c C-c and C-c C-u work for comment/uncomment region in all modes 
(global-set-key (kbd "C-c C-c") 'comment-region)
(global-set-key (kbd "C-c C-u") 'uncomment-region)

;; zooming in and zooming out in emacs like in firefox
;; zooming; inspired by http://blog.febuiles.com/page/2/
(defun djcb-zoom (n) (interactive)
  (set-face-attribute 'default (selected-frame) :height 
    (+ (face-attribute 'default :height) (* (if (> n 0) 1 -1) 10)))) 

(global-set-key (kbd "C-+")      '(lambda()(interactive(djcb-zoom 1))))
(global-set-key [C-kp-add]       '(lambda()(interactive(djcb-zoom 1))))
(global-set-key (kbd "C--")      '(lambda()(interactive(djcb-zoom -1))))
(global-set-key [C-kp-subtract]  '(lambda()(interactive(djcb-zoom -1))))

(global-set-key [(control tab)] 'bury-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; time-stamps 
;; when there is a "Time-stamp: <>" in the first 10 lines of the file,
;; emacs will write time-stamp information there when saving the file.
;; see the top of this file for an example... 
(setq 
  time-stamp-active t          ; do enable time-stamps
  time-stamp-line-limit 10     ; check first 10 buffer lines for Time-stamp: <>
  time-stamp-format "%04y-%02m-%02d %02H:%02M:%02S (%u)") ; date format
(add-hook 'write-file-hooks 'time-stamp) ; update when saving
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; turn on autofill for all text-related modes
(toggle-text-mode-auto-fill) 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Elisp
(defun djcb-emacs-lisp-mode-hook ()
  (interactive)
  
  ;; overrides the global f7 for compilation
  (local-set-key (kbd "<f7>") 'eval-buffer)
       
  (set-input-method nil)       ; i don't want accented chars, funny "a etc.
  (setq lisp-indent-offset 2) ; indent with two spaces, enough for lisp

  (font-lock-add-keywords nil 
    '(("\\<\\(FIXME\\|TODO\\|XXX+\\|BUG\\):" 
        1 font-lock-warning-face prepend)))  
  
  (font-lock-add-keywords nil 
    '(("\\<\\(require-maybe\\|add-hook\\|setq\\)" 
        1 font-lock-keyword-face prepend)))  
)
(add-hook 'emacs-lisp-mode-hook 'djcb-emacs-lisp-mode-hook)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; backups  (emacs will write backups and number them)
(setq make-backup-files t ; do make backups
  backup-by-copying t ; and copy them ...
  backup-directory-alist '(("." . "~/.emacs.d/backup/")) ; ... here
  version-control t
  kept-new-versions 2
  kept-old-versions 5
  delete-old-versions t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(add-to-list 'load-path "~/Desktop/emms-latest/lisp")
(require 'emms-setup)
(emms-devel)
(emms-default-players)

;; super key bindings
(global-set-key (kbd "<s-right>") 'hs-show-block)
(global-set-key (kbd "<s-left>")  'hs-hide-block)
(global-set-key (kbd "<s-up>")    'hs-hide-all)
(global-set-key (kbd "<s-down>")  'hs-show-all)
(global-set-key (kbd "s-m")       'magit-status)

; Mostrar linhas lado esquerdo
(require 'linum)
(global-set-key (kbd "<f6>") 'linum-mode)
(linum-mode t)
;;;

; Activar iswitch
(iswitchb-mode t)
;;;

; Display Tip of the Day
; Entra em conflito com o Restaurar sessoes
;(defconst animate-n-steps 3)
;(require 'cl)
;(random t)
;(defun totd ()
  ;(interactive)
  ;(let* ((commands (loop for s being the symbols
                      ;when (commandp s) collect s))
         ;(command (nth (random (length commands)) commands)))
    ;(animate-string (concat ";; Initialization successful, welcome to "
                            ;(substring (emacs-version) 0 16)
                            ;"\n"
                            ;"Your tip for the day is:\n========================\n\n"
                            ;(describe-function command)
                            ;(delete-other-windows)
                            ;"\n\nInvoke with:\n\n"
                            ;(where-is command t)
                            ;(delete-other-windows) 
                            ;)0 0)))

;(add-hook 'after-init-hook 'totd)  
;;;;;


; Utilizar como o Vim
;(setq viper-mode t)
;(require 'viper)
;;;;;

; Activar winner
(winner-mode 1)
;;;

; Colocar o text-mode como default ao abrir um ficheiro e fazer com que o o
; texto so tenha 78 caracteres de largura
(setq default-major-mode 'text-mode)
(setq fill-column 78)
(auto-fill-mode t)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
;;;

; Indicar o tamanho do ficheiro
(size-indication-mode t)
;;;


;; Configuracoes de w3m
(require 'w3m-load)
;(require 'mime-w3m)
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
 ;; optional keyboard short-cut
;(global-set-key "\C-xm" 'browse-url-at-point)
(setq w3m-use-cookies t)

; Activar o AUCTeX
(require 'tex-site)
(load "preview-latex.el" nil t t)
;;;;;

; Gravar sessoes
;(desktop-save-mode 1)
;;;;;

; Dias do calendario traduzidos para PT
(setq european-calendar-style 't)
(setq calendar-week-start-day 1
  calendar-day-name-array
  ["Domingo" "Segunda" "Terça" 
   "Quarta" "Quinta" "Sexta" "Sábado"]
  calendar-month-name-array
  ["Janeiro" "Fevereiro" "Março" "Abril"
   "Maio" "Junho" "Julho" "Agosto" "Setembro"
   "Outubro" "Novembro" "Dezembro"])
;;;;;

; Mostrar imagens do site icanhascheezburger.com
(load "cheezburger.el")
;;;;;

; Fazer highline das palavras TODO e FIXME, entre outras
(load "highlight-fixmes-mode.el")
(highlight-fixmes-mode t)
;;;

; Realcar a linha actual
(require 'highline)
;(highline-mode 1)
;(set-face-foreground 'hl-line nil) ; Nao estragar o syntax highlight
;; To customize the background color
;(set-face-background 'highline-face "#222")

;(global-hl-line-mode t) ; Assim fica a linha amarela
;(setq-default global-highline-mode t)
;(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 ;'(global-highline-mode t))
;;;;;

; Colocar o calendario mais bonito
(setq view-diary-entries-initially t
    mark-diary-entries-in-calendar t
    number-of-diary-entries 7)
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)
;;;;;

;; spellcheck in LaTex mode
(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'tex-mode-hook 'flyspell-mode)
(add-hook 'bibtex-mode-hook 'flyspell-mode)
;;;;;

;; Show line-number and column-number in the mode line
(line-number-mode 1)
(column-number-mode 1)
;;;;;

; Activar Org-Mode
(setq load-path (cons "~/.emacs-teste/org-6.16c/lisp" load-path))
(setq load-path (cons "~/.emacs-teste/org-6.16c/contrib/lisp" load-path))
;;;;;

;; The following lines are always needed. Choose your own keys.
;; (Configuracoes do Org-Mode)
(add-to-list 'auto-mode-alist '("\\.org\\’" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;;;;;

;; Activar font-lock mode para todos os buffers
(global-font-lock-mode 1)
;;;;;

(setq gnus-select-method '(nntp "news.motzarella.org"))

; Ficheiros terminados em .org activam o Org-mode
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;;;;;

;; ============================
;; Setup syntax, background, and foreground coloring
;; ============================

;(set-background-color "Black")
;(set-foreground-color "White")
;(set-cursor-color "LightSkyBlue")
;(set-mouse-color "LightSkyBlue")
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
;;;;;
;; ============================

;; ============================
;; Key mappings
;; ============================

;; use F1 key to go to a man page
(global-set-key [f1] 'man)
;; use F3 key to kill current buffer
(global-set-key [f3] 'kill-this-buffer)
;; use F5 to get help (apropos)
(global-set-key [f5] 'apropos)
;; use F9 to open files in hex mode
;; (global-set-key [f9] 'hexl-find-file)

;; goto line function C-c C-g
; (global-set-key [ (control c) (control g) ] 'goto-line)
;; ============================

;; ============================
;; Mouse Settings
;; ============================

;; mouse button one drags the scroll bar
(global-set-key [vertical-scroll-bar down-mouse-1] 'scroll-bar-drag)
;; ============================

;; ============================
;; DisplaY
;; ============================

;; setup font
;(set-default-font
;  "-Misc-Fixed-Medium-R-Normal--15-140-75-75-C-90-ISO8859-1")

(set-default-font "-adobe-courier-medium-r-normal-*-14-100-*-*-*-*-iso10646-1")

;(set-default-font "DejaVu Sans Mono-11")

;; display the current time
(display-time)

;; alias y to yes and n to no
(defalias 'yes-or-no-p 'y-or-n-p)

;; highlight matches from searches
(setq isearch-highlight t)
(setq search-highlight t)
(setq-default transient-mark-mode t)

(when (fboundp 'blink-cursor-mode)
  (blink-cursor-mode -1))
;; ===========================

;; ===========================
;; Behaviour
;; ===========================

;; Pgup/dn will return exactly to the starting point.
(setq scroll-preserve-screen-position 1)


;; scroll just one line when hitting the bottom of the window
(setq scroll-step 1)
(setq scroll-conservatively 1)

;; format the title-bar to always include the buffer name
(setq frame-title-format "emacs - %b")

;; show a menu only when running within X (save real estate when
;; in console)
; (menu-bar-mode (if window-system 1 -1))

;; turn on word wrapping in text mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; resize the mini-buffer when necessary
(setq resize-minibuffer-mode t)

;; highlight during searching
(setq query-replace-highlight t)

;; highlight incremental search
(setq search-highlight t)
;; ===============================

;; ===========================
;; HTML/CSS stuff
;; ===========================

;; take any buffer and turn it into an html file,
;; including syntax hightlighting
; (require 'htmlize)

;; ===========================


;; ===========================
;; Custom Functions
;; ===========================

;; print an ascii table
(defun ascii-table ()
  (interactive)
  (switch-to-buffer "*ASCII*")
  (erase-buffer)
  (insert (format "ASCII characters up to number %d.\n" 254))
  (let ((i 0))
    (while (< i 254)
      (setq i (+ i 1))
      (insert (format "%4d %c\n" i i))))
  (beginning-of-buffer))
;;;;;


;; ;; indent the entire buffer
;; (defun c-indent-buffer ()
;;   "Indent entire buffer of C source code."
;;   (interactive)
;;   (save-excursion
;;     (goto-char (point-min))
;;     (while (< (point) (point-max))
;;       (c-indent-command)
;;       (end-of-line)
;;       (forward-char 1))))

;; (defun insert-function-header () (interactive)
;;   (insert 
;;     "  /**\n")
;;   (insert "   * \n")
;;   (insert "   * @param: \n")
;;   (insert "   * @return: \n")
;;   (insert "   */"))

;; ; (global-set-key "\C-t\C-g" 'insert-function-header)

;; (defun insert-file-header () (interactive)
;;   (insert "/*////////////////////////////////////*/\n")
;;   (insert "/**\n")
;;   (insert " * \n")
;;   (insert " * Author: Michael Wasilewski\n")
;;   (insert " */\n")
;;   (insert "/*////////////////////////////////////*/\n"))

;; (require 'setnu)

;; resize man page to take up whole screen
(setq Man-notify 'bully)

(require 'tramp)

;; Put autosave files (ie #foo#) in one place, *not*
;; scattered all over the file system!
(defvar autosave-dir
 (concat "~/.emacs.d/autosaves/" (user-login-name) "/"))

(make-directory autosave-dir t)

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat autosave-dir
   (if buffer-file-name
      (concat "#" (file-name-nondirectory buffer-file-name) "#")
    (expand-file-name
     (concat "#%" (buffer-name) "#")))))

;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir (concat "~/.emacs.d/backups/" (user-login-name) "/"))
(setq backup-directory-alist (list (cons "." backup-dir)))

;; (ido-mode t)

; Saltar para onde se estava quando abrir um ficheiro
(require 'saveplace)
(setq-default save-place t)
;;;;;

; Cursor do rato não cobre o texto
(mouse-avoidance-mode 'jump)
;;;;;

; Yasnippet
;(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
;(load "yasnippet.el") ;; not yasnippet-bundle
;(yas/initialize)
;(yas/load-directory "/.emacs.d/plugins/yasnippet/snippets/")
;;;;;
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/notes/teste.org"))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
;; Remove splash screen
(setq inhibit-splash-screen t)
;(calendar)

; Configurar Pymacs
;(autoload 'pymacs-apply "pymacs")
;(autoload 'pymacs-call "pymacs")
;(autoload 'pymacs-eval "pymacs" nil t)
;(autoload 'pymacs-exec "pymacs" nil t)
;(autoload 'pymacs-load "pymacs" nil t)
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))
;;;;;;;;;;;;;;;;;;;;;

; Configurar Rope
;(require 'pymacs)
;(pymacs-load "ropemacs" "rope-")
;;;;;;;;;;;;;;;;;;;;;

;(global-set-key "RET" 'newline-and-indent)

; Enter faz automaticamente o indent do codigo
(define-key global-map (kbd "RET") 'newline-and-indent)
;;;
