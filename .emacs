; Time-stamp: <2009-02-13 18:38:32 (rolando)>

;; Load CEDET
(load-file "~/.emacs-teste/cedet-1.0pre4/common/cedet.el")
;(global-ede-mode t)

; Load Emacs Code Browser
(add-to-list 'load-path "~/.emacs-teste/ecb-snap")
(require 'ecb)

(add-to-list 'load-path "~/.emacs-teste/emacs-chess")
(require 'chess)

(setq visible-bell t)
(setq load-path (append '("~/.emacs-teste") load-path))

(setq load-path (append '("/usr/share/emacs/site-lisp/pydb") load-path))
(add-to-list 'load-path "~/.emacs-teste")
(setq c-default-style "bsd")

(setq require-final-newline t)                ; Always newline at end of file

; Mostrar os espacos vazios no final das linhas
(setq show-trailing-whitespace t)

;; (defconst animate-n-steps 50)
;; (defun emacs-reloaded ()
;;   (animate-string (concat ";; Initialization successful, welcome to "
;;                     (substring (emacs-version) 0 16)
;;                     ".")
;;     0 0)
;;   (newline-and-indent)  (newline-and-indent))
;; (add-hook 'after-init-hook 'emacs-reloaded)

(when window-system
  (global-unset-key "\C-z"))            ; iconify-or-deiconify-frame (C-x C-z)

(setq ispell-dictionary "portugues")             ; Set ispell dictionary

(require 'column-marker)
(column-marker-1 80)


(setq frame-title-format "%b - emacs")
; Tabs colocam 4 espacos
(setq-default c-basic-offset 4
  tab-width 4
  indent-tabs-mode nil)
(setq indent-tans-mode nil)
(setq tab-width 4)
(setq backward-delete-char-untabify nil)
(setq default-tab-width 4)
;;;

; Coisas SVN
(load "psvn.el")
;;

;Alguns modos precisam disto
(setq user-mail-address "finalyugi@sapo.pt")
(setq user-full-name "Rolando Pereira")
;;;

; Activar Org-Mode
(setq load-path (cons "~/.emacs-teste/org-6.16c/lisp" load-path))
(setq load-path (cons "~/.emacs-teste/org-6.16c/contrib/lisp" load-path))
;;;;;

; Mostra so a * mais a direita no org-mode
(setq org-hide-leading-stars t)
;;;

;; The following lines are always needed. Choose your own keys.
;; (Configuracoes do Org-Mode)
(add-to-list 'auto-mode-alist '("\\.org\\’" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;;;;;

; Ficheiros terminados em .org activam o Org-mode
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;;;;;

; Activar flymake-mode para o python usando o pyflakes
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                        'flymake-create-temp-inplace))
            (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
      (list "pyflakes" (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
    '("\\.py\\'" flymake-pyflakes-init)))

(add-hook 'find-file-hook 'flymake-find-file-hook)
;;;

; Flymake settings
(defun my-flymake-show-next-error()
  (interactive)
  (flymake-goto-next-error)
  (flymake-display-err-menu-for-current-line)
  )

(global-set-key [f4] 'my-flymake-show-next-error)
;; '(flymake-errline ((((class color)) (:underline "OrangeRed"))))
;; '(flymake-warnline ((((class color)) (:underline "yellow"))))


; Activar folding no Python
(defun my-python-mode-hook ()
  (hs-minor-mode 1)
  (local-set-key "\C-zm" 'hs-hide-all)
  (local-set-key "\C-zC-z" 'hs-show-block)
  (local-set-key "\C-zz" 'hs-hide-block)
  (local-set-key "\C-zr" 'hs-show-all))

(add-hook 'python-mode-hook 'my-python-mode-hook)

;Configurações para o C#
;; Import C# mode
(autoload 'csharp-mode "csharp-mode-0.7.0" "Major mode for editing C# code." t)
(setq auto-mode-alist
  (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))


;; C/C++/Java/C# Mode
(defun my-c-mode-common-hook ()
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'statement-cont 4)
  (c-set-offset 'topmost-intro-cont 0)
  (c-set-offset 'block-open 0)
  (c-set-offset 'arglist-intro 4)
  (c-set-offset 'arglist-cont-nonempty 4)
  (flymake-mode t))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; (defun my-csharp-mode-hook ()
;;   (progn
;;    (turn-on-font-lock)
;;    (auto-fill-mode)
;;    (setq tab-width 4)
;;    (define-key csharp-mode-map "\t" 'c-tab-indent-or-complete)))
;; (add-hook 'csharp-mode-hook 'my-csharp-mode-hook)


; Mudar a theme do emacs
(when window-system
  (require 'color-theme)
  (require 'color-theme-tango)
  (color-theme-initialize)
;(color-theme-robin-hood)
;  (color-theme-goldenrod)
  (color-theme-tango)
  )
; Outros themes: midnight, white on black, charcoal black, Calm Forest, Billw,
; Arjen, Clarity and Beauty, Cooper Dark, Comidia, Dark Blue 2, Dark Laptop,
; Deep Blue, Hober, Late Night, Lethe, Linh Dang Dark, Taming Mr Arneson,
; Subtle Hacker, TTY Dark, Taylor,  White On Black, Robin Hood
;;;

; Add colors to shell
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;;

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
  (setq lisp-indent-offset 2)  ; indent with two spaces, enough for lisp

  (font-lock-add-keywords nil
    '(("\\<\\(FIXME\\|TODO\\|XXX+\\|BUG\\):"
        1 font-lock-warning-face prepend)))

  (font-lock-add-keywords nil
    '(("\\<\\(require-maybe\\|add-hook\\|setq\\)"
        1 font-lock-keyword-face prepend)))
  (custom-set-faces
    ;; custom-set-faces was added by Custom.
    ;; If you edit it by hand, you could mess it up, so be careful.
    ;; Your init file should contain only one such instance.
    ;; If there is more than one, they won't work right.
    '(show-paren-match ((((class color) (background dark)) (:background "grey20")))))
  (show-paren-mode 1)
  (setq show-paren-style 'expression)

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

;; super key bindings
;; (global-set-key (kbd "<s-right>") 'hs-show-block)
;; (global-set-key (kbd "<s-left>")  'hs-hide-block)
;; (global-set-key (kbd "<s-up>")    'hs-hide-all)
;; (global-set-key (kbd "<s-down>")  'hs-show-all)
;; (global-set-key (kbd "s-m")       'magit-status)

; Activar Folding
(global-set-key (kbd "C-z") 'hs-toggle-hiding)
;;

; Mostrar linhas lado esquerdo
(require 'linum)
(linum-mode t)
(global-set-key (kbd "<f2>") 'linum-mode)
;;;

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
(cond ((= emacs-major-version 23)
    (add-to-list 'load-path "~/.emacs-teste/emacs-w3m")
    (require 'w3m-load)))

(require 'w3m)
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(setq w3m-use-cookies t)

;; Mudar keybindings
(eval-after-load 'w3m
  '(progn
     (define-key w3m-mode-map "q" 'w3m-previous-buffer)
     (define-key w3m-mode-map "w" 'w3m-next-buffer)
     (define-key w3m-mode-map "x" 'w3m-delete-buffer)))

;; Gravar sessions
(cond ((= emacs-major-version 22)
        (require 'w3m-session)
        (setq w3m-session-file "~/.emacs.d/w3m-session")
        (setq w3m-session-save-always t)
        (setq w3m-session-load-always t)
        (setq w3m-session-autosave-period 30)
        (setq w3m-session-duplicate-tabs 'always)))

;; Utitilizar numeros para saltar para links
;; http://emacs.wordpress.com/2008/04/12/numbered-links-in-emacs-w3m/
(require 'w3m-lnum)
(defun jao-w3m-go-to-linknum ()
  "Turn on link numbers and ask for one to go to."
  (interactive)
  (let ((active w3m-link-numbering-mode))
    (when (not active) (w3m-link-numbering-mode))
    (unwind-protect
      (w3m-move-numbered-anchor (read-number "Anchor number: "))
      (when (not active) (w3m-link-numbering-mode)))))

(define-key w3m-mode-map "f" 'jao-w3m-go-to-linknum)
;;;;;;


;Activar o AUCTeX
(require 'tex-site)
(load "preview-latex.el" nil t t)
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

; Colocar o calendario mais bonito
(setq view-diary-entries-initially t
    mark-diary-entries-in-calendar t
    number-of-diary-entries 7)
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)
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

;; spellcheck in LaTex mode
(add-hook 'latex-mode-hook 'flyspell-mode)
(add-hook 'tex-mode-hook 'flyspell-mode)
(add-hook 'bibtex-mode-hook 'flyspell-mode)
;;;;;

;; Show line-number and column-number in the mode line
(line-number-mode 1)
(column-number-mode 1)
;;;;;

;; Activar font-lock mode para todos os buffers
(global-font-lock-mode 1)
;;;;;

;; ============================
;; Setup syntax, background, and foreground coloring
;; ============================
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
(if (>= emacs-major-version 23)
  (set-default-font "Bitstream Vera Sans Mono-14")
  (set-default-font "-adobe-courier-medium-r-normal-*-14-100-*-*-*-*-iso10646-1"))


;; display the current time
(setq display-time-24hr-format t)
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

; See the commands I'm writing
(setq echo-keystrokes 0.1)

;; Pgup/dn will return exactly to the starting point.
(setq scroll-preserve-screen-position 1)

; Display various non-editing buffers in their own frames
(setq special-display-buffer-names
  (nconc '("*Backtrace*" "*VC-log*" "*compilation*" "*grep*")
    special-display-buffer-names))

; Display those special buffer frames without a tool bar
;(add-to-list 'special-display-frame-alist '(tool-bar-lines . 0))

;Define mnemonic key bindings for moving to 'M-x compile' and 'M-x grep' matches
(global-set-key "\C-cn" 'next-error)
(global-set-key "\C-cp" 'previous-error)

; Don't bother entering search and replace args if the buffer is read-only
(defadvice query-replace-read-args (before barf-if-buffer-read-only activate)
  "Signal a 'buffer-read-only' error if the current buffer is read-only."
  (barf-if-buffer-read-only))

;; scroll just one line when hitting the bottom of the window
(setq scroll-step 1)
(setq scroll-conservatively 1)

;; format the title-bar to always include the buffer name
(setq frame-title-format "emacs - %b")

;; show a menu only when running within X (save real estate when
;; in console)
;(menu-bar-mode (if window-system 1 -1))

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
(require 'htmlize)

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

; resize man page to take up whole screen
(setq Man-notify 'bully)
;;

; SSH, etc.
(require 'tramp)
;;

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

;; Auto-Completation on files
;; http://emacs-fu.blogspot.com/2009/02/switching-buffers.html
(require 'ido)                      ; ido is part of emacs
(ido-mode t)                        ; for both buffers and files
(setq
   ido-ignore-buffers               ; ignore these guys
   '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "\*scratch\*")
   ido-work-directory-list '("~/" "~/Desktop" "~/Documents")
   ido-case-fold  t                 ; be case-insensitive
   ido-use-filename-at-point nil    ; don't use filename at point (annoying)
   ido-use-url-at-point nil         ;  don't use url at point (annoying)
   ido-enable-flex-matching t       ; be flexible
   ido-max-prospects 6              ; don't spam my minibuffer
   ido-confirm-unique-completion t) ; wait for RET, even with unique completion
;;

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
 '(ecb-options-version "2.33beta2")
 '(org-agenda-files (quote ("~/notes/teste.org"))))
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(show-paren-match ((((class color) (background dark)) (:background "grey20")))))

; Remove splash screen
(setq inhibit-splash-screen t)
;;;

; Enter faz automaticamente o indent do codigo
(define-key global-map (kbd "RET") 'newline-and-indent)
;;;

;(set-face-background 'region "gray80")

; Detaching the custom-file
; http://www.emacsblog.org/2008/12/06/quick-tip-detaching-the-custom-file/
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

(defun djcb-term-start-or-switch (prg &optional use-existing)
  "* run program PRG in a terminal buffer. If USE-EXISTING is non-nil "
  " and PRG is already running, switch to that buffer instead of starting"
  " a new instance."
  (interactive)
  (let ((bufname (concat "*" prg "*")))
    (when (not (and use-existing
                 (let ((buf (get-buffer bufname)))
                   (and buf (buffer-name (switch-to-buffer bufname))))))
      (ansi-term prg prg))))

(defmacro djcb-program-shortcut (name key &optional use-existing)
  "* macro to create a key binding KEY to start some terminal program PRG;
    if USE-EXISTING is true, try to switch to an existing buffer"
  `(global-set-key ,key
     '(lambda()
        (interactive)
        (djcb-term-start-or-switch ,name ,use-existing))))

;; terminal programs are under Shift + Function Key
(djcb-program-shortcut "zsh"   (kbd "<S-f1>") t)  ; the ubershell
(djcb-program-shortcut "mutt"  (kbd "<S-f2>") t)  ; mail client
(djcb-program-shortcut "slrn"  (kbd "<S-f3>") t)  ; nttp client
(djcb-program-shortcut "htop"  (kbd "<S-f4>") t)  ; my processes
(djcb-program-shortcut "mc"    (kbd "<S-f5>") t)  ; midnight commander
(djcb-program-shortcut "raggle"(kbd "<S-f6>") t)  ; rss feed reader
(djcb-program-shortcut "irssi" (kbd "<S-f7>") t)  ; irc client
;;;;;;;;

;; Mostrar em que funcao estamos
;; http://emacs-fu.blogspot.com/2009/01/which-function-is-this.html
(load "which-func")
(which-func-mode t)

(delete (assoc 'which-func-mode mode-line-format) mode-line-format)
(setq which-func-header-line-format
              '(which-func-mode
                ("" which-func-format
                 )))

(defadvice which-func-ff-hook (after header-line activate)
  (when which-func-mode
    (delete (assoc 'which-func-mode mode-line-format) mode-line-format)
    (setq header-line-format which-func-header-line-format)))
;;;;

;; Mover para as janelas usando o ALT+setas
;; http://www.emacsblog.org/2008/05/01/quick-tip-easier-window-switching-in-emacs/
(require 'windmove)
(windmove-default-keybindings 'meta)
;;

;; Highlight symbols on a buffer
;(require 'light-symbol)
;(light-symbol-mode t)
;;
