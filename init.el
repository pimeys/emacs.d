;; First a dirty, but cheap way to get .emacs.d subfolders into the load path,
;; and then return us to the user home directory, for find-file etc.
(progn (cd "~/.emacs.d/") (normal-top-level-add-subdirs-to-load-path) (cd "~"))

                                        ;(add-to-list 'package-archives
;  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
("marmalade" . "http://marmalade-repo.org/packages/")
;; ("melpa" . "http://melpa.milkbox.net/packages/")
))

(add-to-list 'default-frame-alist '(font . "Inconsolata-13"))

;; -- Path -----------------------------------------------------------------------------------------------
;; find XCode and RVM command line tools on OSX (cover the legacy and current XCode directory structures.)
(when (eq system-type 'darwin)
  (when (file-exists-p "/Developer/usr/bin")
    (setq exec-path (append '("/Developer/usr/bin") exec-path)))
  (when (file-exists-p "/Applications/Xcode.app/Contents/Developer/usr/bin")
    (setq exec-path (append '("/Applications/Xcode.app/Contents/Developer/usr/bin") exec-path)))
  (when (file-exists-p "~/.rvm/bin")
    (setq exec-path (append '("~/.rvm/bin") exec-path)))
  (when (file-exists-p "/usr/local/bin/")
    (setq exec-path (append '("/usr/local/bin") exec-path)))
  (when (file-exists-p "/usr/local/share/npm/bin")
    (setq exec-path (append '("/usr/local/share/npm/bin") exec-path))))

(add-to-list 'exec-path "~/bin")

(add-to-list 'load-path "~/.emacs.d/evil")

(add-to-list 'load-path "~/.emacs.d/plugins/tabbar")

; Org mode
;(add-to-list 'load-path "~/.emacs.d/elpa/org-20130826")
(add-to-list 'load-path "~/.emacs.d/org-mode/lisp")
(add-to-list 'load-path "~/.emacs.d/org-mode/contrib/lisp")
;(setq org-export-backends (cons 'md org-export-backends))
(require 'ox-md)
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
; Setup org mode for dropbox sync
;; Set to the location of your Org files on your local system
(setq org-directory "~/Dropbox/Todo/org/")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Dropbox/Todo/org/todos.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

(setq tramp-default-method "ssh")

; we want a couple of languages in Babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)(ruby . t)(sh . t)(R . t)(C . t)(scala . t)(clojure . t)(lisp . t) (sql . t) (js . t) (sqlite . t) (emacs-lisp . t) (css . t) (sass . t) (objc . t)))

;; turn off toolbar.
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;; menu bar mode only on OS X, just because it's pretty much out of
;; the way, as opposed to sitting right there in the frame.
(if  (and (window-system) (eq system-type 'darwin))
    (menu-bar-mode 1)
  (menu-bar-mode -1)
)

;; Ruby mode
(autoload 'ruby-mode "ruby-mode" "Ruby mode" t )
(setq auto-mode-alist (cons '("\\.rb\\'" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.rake\\'" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Gemfile" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("Rakefile" . ruby-mode) auto-mode-alist))
(add-hook 'ruby-mode-hook '(lambda () (font-lock-mode 1)))

(setq frame-title-format '("%b %I %+%@%t%Z %m %n %e"))

(setq x-select-enable-clipboard t)
(global-set-key [mouse-2] 'mouse-yank-primary)

;; Explicitly require libs that autoload borks
;; Include common lisp:
(require 'cl) ;; one day can remove this...
(require 'cl-lib)
(require 'dash)
(require 's)
(require 'f)
(require 'ag)
(require 'multiple-cursors)
(require 'helm)
(require 'git-gutter-fringe+)

;; Modes init (things that need more than just a require.)
(when (string-match "Emacs 24" (version))
  ;; Only run elpa on E24
  (require 'init-elpa)
)

;; -------------------------------------------------------------------------------------------------
;; Additional requires
;; -------------------------------------------------------------------------------------------------
;;; Convenience and completion
(require 'auto-complete-config)        ;; Very nice autocomplete.
(ac-config-default)

(require 'switch-window)               ;; Select windows by number.
(require 'resize-window)               ;; interactively size window
(require 'highlight-indentation)       ;; visual guides for indentation
(require 'squeeze-view)                ;; squeeze view, give yourself a write-room/typewriter like writing page
(require 'hexrgb)
(require 'kill-buffer-without-confirm) ;; yes, I really meant to close it.
(require 'scroll-bell-fix)             ;; a small hack to turn off the buffer scroll past top/end bell.
(require 'dabbrev)
(require 'ac-dabbrev)

;; no scrolblars
(scroll-bar-mode -1)

;; conditional - add your own init-marmalade or just login manually
(load-library "marmalade")
(when (file-readable-p "modes-init/init-marmalade.el")
  (load-file "modes-init/init-marmalade.el"))

;; Turn on things that auto-load isn't doing for us...
;(yas-global-mode t)

;; Autopair alternative
(flex-autopair-mode t)

;; Rainbow mode for css automatically
(add-hook 'css-mode-hook 'rainbow-mode)

;; Rainbow delimiters for all prog modes
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; Smoother scrolling (no multiline jumps.)
;(setq redisplay-dont-pause t
;  scroll-margin 1
;  scroll-step 1
;  scroll-conservatively 10000
;  scroll-preserve-screen-position 1)

;; show paren mode
(show-paren-mode 1)
(setq show-paren-delay 0)

;; use y / n instead of yes / no
(fset 'yes-or-no-p 'y-or-n-p)

;; allow "restricted" features
(put 'set-goal-column           'disabled nil)
(put 'erase-buffer              'disabled nil)
(put 'downcase-region           'disabled nil)
(put 'upcase-region             'disabled nil)
(put 'narrow-to-region          'disabled nil)
(put 'narrow-to-page            'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)


;; -------------------------------------------------------------------------------------------------
;; Highlight TODO/FIXME/BUG/HACK/REFACTOR & THE HORROR in code - I'm hoping the last one will catch on.
;(add-hook 'prog-mode-hook
 ;              (lambda ()
  ;              (font-lock-add-keywords nil
   ;              '(("\\<\\(NOTE\\|FIXME\\|TODO\\|BUG\\|HACK\\|REFACTOR\\|THE HORROR\\)" 1 font-lock-warning-face t)))))
;
;; -------------------------------------------------------------------------------------------------
;; use aspell for ispell
(when (file-exists-p "/usr/local/bin/aspell")
  (set-variable 'ispell-program-name "/usr/local/bin/aspell"))

;; -------------------------------------------------------------------------------------------------
;; JavaScript/JSON special files
(dolist (pattern '("\\.jshintrc$" "\\.jslint$"))
  (add-to-list 'auto-mode-alist (cons pattern 'json-mode)))

(require 'simple-httpd)

;; Conditional start of Emacs Server
(setq server-use-tcp t)
(server-start)

;; -------------------------------------------------------------------------------------------------

;; -----------------------------------------------------------------------------------------------
;; Custom stuff from me.
;; -----------------------------------------------------------------------------------------------
(require 'powerline)
(powerline-default-theme)
(require 'visual-progress-mode)

;; No tabs, only 2 spaces, as default
(setq-default indent-tabs-mode nil)
(setq tab-width 2)

;; Kill the welcome buffer
(setq inhibit-startup-message t)

;; Disable splash screen
(setq inhibit-splash-screen t)

;; Highlight current line

;; Highlight indent, for python, maybe more
(defun setup-indentation-mode ()
  (interactive)
  (require 'highlight-indentation)
  (require 'indent-guide)
  (highlight-indentation-mode)
  (indent-guide-mode)
  )
(add-hook 'python-mode-hook 'setup-indentation-mode)

;; Shortcurt for selecting lispy ranges
(defun evil-select-lisp-form ()
  (interactive)
  (evil-visual-char)
  (evil-jump-item)
  )
(global-set-key (kbd "C-5") 'evil-select-lisp-form)


(setq make-backup-files nil) ; stop creating those backup~ files
(setq auto-save-default nil) ; stop creating those #autosave# files

(recentf-mode 1) ; keep a list of recently opened files


;; Load evil
(require 'init-evil)

(evil-leader/set-key "m" 'minimap-toggle)
(evil-leader/set-key "n" 'new-buffer)

(evil-leader/set-key "t" 'switch-to-previous-buffer)
(evil-leader/set-key "y" 'x-clipboard-yank)
(evil-leader/set-key "P" 'x-clipboard-kill-region)

(evil-leader/set-key "re" 'recentf-open-files)
(evil-leader/set-key "rl" 'revert-buffer)

(evil-leader/set-key "l" 'buffer-list-in-window)

(evil-leader/set-key "i" 'imenu)

(evil-leader/set-key "c" 'delete-window)
(evil-leader/set-key "p" 'switch-to-prev-buffer)
(evil-leader/set-key ":" 'helm-complex-command-history)

(evil-leader/set-key "f" 'projectile-find-file)
(evil-leader/set-key "a" 'ag-project)
(evil-leader/set-key "q" 'align-regexp)

(evil-leader/set-key "gs" 'magit-status)
(evil-leader/set-key "gb" 'magit-blame)
(evil-leader/set-key "gr" 'magit-branch-manager)

(evil-leader/set-key "rr" 'rspec-verify)
(evil-leader/set-key "ra" 'rspec-verify-all)

(evil-leader/set-key "/" 'evilnc-comment-or-uncomment-lines)
(evil-leader/set-key "r" 'insert-binding-pry)

; evil extension for html tag selection like matchit
                                        ; doesn't work yet: http://blog.binchen.org/?p=775
(require 'smartparens)
(require 'matchit)
;; {{ evil-matchit
(defun my-evil-jump-item-enhanced-for-html ()
  (interactive)
  (if (or (eq major-mode 'html-mode)
          (eq major-mode 'xml-mode)
          (eq major-mode 'nxml-mode)
          (eq major-mode 'web-mode)
          )
      (progn
        (if (not (my-sp-select-next-thing 1)) (exchange-point-and-mark))
        (deactivate-mark)
        )
    (progn
      (evil-jump-item)
      )
    )
  )
(define-key evil-normal-state-map "%" 'my-evil-jump-item-enhanced-for-html)
;; }}

(require 'my-functions)

(require 'custom-keys)

; load evil surround
(require 'surround)
(global-surround-mode 1)

;; Run emacs in server mode, so that we can connect from commandline
(server-start)

(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

;; Support for expand region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


;; http://stackoverflow.com/questions/6344474/how-can-i-make-emacs-highlight-lines-that-go-over-80-chars
;; free of trailing whitespace and to use 80-column width, standard indentation
(setq whitespace-style '(trailing lines space-before-tab
                                  indentation space-after-tab)
      whitespace-line-column 80)

;; After startup, show the recent open files
(recentf-open-files)

(helm-mode 1)
(global-set-key (kbd "s-.") 'helm-complete-file-name-at-point)
(global-linum-mode 0)
(global-git-gutter+-mode t)
(electric-indent-mode t)

(modify-syntax-entry ?_ "w")

(require 'init-hideshowvis)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(add-to-list (quote default-frame-alist))
 '(ansi-color-names-vector ["#14191f" "#d15120" "#81af34" "#deae3e" "#7e9fc9" "#a878b5" "#7e9fc9" "#dcdddd"])
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes (quote ("1f3304214265481c56341bcee387ef1abb684e4efbccebca0e120be7b1a13589" "9ea054db5cdbd5baa4cda9d373a547435ba88d4e345f4b06f732edbc4f017dc3" "e9a1226ffed627ec58294d77c62aa9561ec5f42309a1f7a2423c6227e34e3581" "91b5a381aa9b691429597c97ac56a300db02ca6c7285f24f6fe4ec1aa44a98c3" "e26780280b5248eb9b2d02a237d9941956fc94972443b0f7aeec12b5c15db9f3" "9bcb8ee9ea34ec21272bb6a2044016902ad18646bd09fdd65abae1264d258d89" "dc46381844ec8fcf9607a319aa6b442244d8c7a734a2625dac6a1f63e34bc4a6" "33c5a452a4095f7e4f6746b66f322ef6da0e770b76c0ed98a438e76c497040bb" "7d4d00a2c2a4bba551fcab9bfd9186abe5bfa986080947c2b99ef0b4081cb2a6" "c7359bd375132044fe993562dfa736ae79efc620f68bab36bd686430c980df1c" "90b5269aefee2c5f4029a6a039fb53803725af6f5c96036dee5dc029ff4dff60" "0ebe0307942b6e159ab794f90a074935a18c3c688b526a2035d14db1214cf69c" "a774c5551bc56d7a9c362dca4d73a374582caedb110c201a09b410c0ebbb5e70" "cbd44e03f1dc3fa451320627c2f42cd21f1f44a4d398d933e29cc4e69d8ad8c9" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8f6537eb6f9d66b060c736f5f680f5c661e0a6b311b86defa293bc5ba104a030" "3bd9497fb8f39c28ab58a9e957152ba2dc41223c23c5520ef10fc7bd6b222384" "1278386c1d30fc24b4248ba69bc5b49d92981c3476de700a074697d777cb0752" "fa189fcf5074d4964f0a53f58d17c7e360bb8f879bd968ec4a56dc36b0013d29" "47583b577fb062aeb89d3c45689a4f2646b7ebcb02e6cb2d5f6e2790afb91a18" "5ce9c2d2ea2d789a7e8be2a095b8bc7db2e3b985f38c556439c358298827261c" "383806d341087214fd44864170161c6bf34a41e866f501d1be51883e08cb674b" "a68fa33e66a883ce1a5698bc6ff355b445c87da1867fdb68b9a7325ee6ea3507" "7fa9dc3948765d7cf3d7a289e40039c2c64abf0fad5c616453b263b601532493" "fa29856e364e2b46254503f913637ef6561faadae62668609cc671ecfcf1c3d2" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "c377a5f3548df908d58364ec7a0ee401ee7235e5e475c86952dc8ed7c4345d8e" default)))
 '(fci-rule-character-color "#202020")
 '(fci-rule-color "#192028")
 '(fringe-mode 4 nil (fringe))
 '(global-linum-mode t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-tail-colors (quote (("#eee8d5" . 0) ("#B4C342" . 20) ("#69CABF" . 30) ("#69B7F0" . 50) ("#DEB542" . 60) ("#F2804F" . 70) ("#F771AC" . 85) ("#eee8d5" . 100))))
 '(httpd-port 8187)
 '(magit-diff-use-overlays nil)
 '(main-line-color1 "#1E1E1E")
 '(main-line-color2 "#111111")
 '(main-line-separator-style (quote chamfer))
 '(org-agenda-files (quote ("~/Dropbox/Todo/org/todos.org")))
 '(powerline-color1 "#1E1E1E")
 '(powerline-color2 "#111111")
 '(safe-local-variable-values (quote ((encoding . utf-8))))
 '(send-mail-function (quote mailclient-send-it))
 '(syslog-debug-face (quote ((t :background unspecified :foreground "#2aa198" :weight bold))))
 '(syslog-error-face (quote ((t :background unspecified :foreground "#dc322f" :weight bold))))
 '(syslog-hour-face (quote ((t :background unspecified :foreground "#859900"))))
 '(syslog-info-face (quote ((t :background unspecified :foreground "#268bd2" :weight bold))))
 '(syslog-ip-face (quote ((t :background unspecified :foreground "#b58900"))))
 '(syslog-su-face (quote ((t :background unspecified :foreground "#d33682"))))
 '(syslog-warn-face (quote ((t :background unspecified :foreground "#cb4b16" :weight bold))))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map (quote ((20 . "#dc322f") (40 . "#CF4F1F") (60 . "#C26C0F") (80 . "#b58900") (100 . "#AB8C00") (120 . "#A18F00") (140 . "#989200") (160 . "#8E9500") (180 . "#859900") (200 . "#729A1E") (220 . "#609C3C") (240 . "#4E9D5B") (260 . "#3C9F79") (280 . "#2aa198") (300 . "#299BA6") (320 . "#2896B5") (340 . "#2790C3") (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list (quote (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496"))))

 ; set different linum color
; and cua mode for copy / paste
(cua-mode)

(setq evil-default-cursor t)
(set-cursor-color "#ffffff")

; Terminal
(require 'init-term)

; Multicursor
(require 'init-multicursor)

;(require 'multi-web-mode)



; http://stackoverflow.com/questions/683425/globally-override-key-binding-in-emacs
(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map (kbd "C-.") 'execute-extended-command)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(my-keys-minor-mode 1)

; do not do this in minibuffer
(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

; Simple clip makes it possible to not overwrite clipboard during yanking
; https://github.com/rolandwalker/simpleclip
(require 'simpleclip)
(simpleclip-mode 1)

; add s-n for opening a new window
(global-set-key (kbd "s-n") 'new-frame)

                                        ; file browser (useful especially for scala stuff with the huge directory tree)
(require 'direx)
(require 'popwin)
(push '(direx:direx-mode :position left :width 25 :dedicated t)
      popwin:special-display-config)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)

; Also, we want to move windows around
(require 'buffer-move)
(global-set-key (kbd "<C-s-up>")     'buf-move-up)
(global-set-key (kbd "<C-s-down>")   'buf-move-down)
(global-set-key (kbd "<C-s-left>")   'buf-move-left)
(global-set-key (kbd "<C-s-right>")  'buf-move-right)

; Setup mail in emacs
(require 'init-mail)

; my task mode
;(require 'task-mode)
; and set up leaders for it
;(evil-leader/set-key-for-mode 'task-mode "d" 'task-mode-todo-task)
;(evil-leader/set-key-for-mode 'task-mode "a" 'task-mode-archive-done)
;(evil-leader/set-key-for-mode 'task-mode "c" 'task-mode-new-todo)

;(setq linum-format "%4d")
(ac-linum-workaround)

(require 'tabbar)

(require 'projectile)
(projectile-global-mode)
(setq projectile-completion-system 'grizzl)

; quick hacked function for quick rest client
; testing
(defun testrest ()
  (interactive)
  (with-current-buffer (get-buffer "restrest")
    (restclient-http-send-current-raw)
    )
  )

(global-set-key (kbd "s-r") 'testrest)

; Font lock mode variations to maybe speed up scrolling
;(setq font-lock-support-mode 'fast-lock-mode ; lazy-lock-mode  / jit-lock-mode
;(setq jit-lock-defer-time 0.05) ; http://tsengf.blogspot.de/2012/11/slow-scrolling-speed-in-emacs.html
; http://stackoverflow.com/questions/3631220/fix-to-get-smooth-scrolling-in-emacs
(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 10000
  scroll-preserve-screen-position 1
  jit-lock-defer-time 0.05
  font-lock-support-mode 'jit-lock-mode)
(setq-default scroll-up-aggressively 0.01 scroll-down-aggressively 0.01)

;If you never expect to have to display bidirectional scripts, like
;Arabic, you can make that the default:
(setq-default bidi-paragraph-direction 'left-to-right)

; TODO Emacs:
; - das  terminal wenn am rand, wackelt so schlimm
; - org mode doku downloaden und irgendwo hinterlegen
; - den simple task mode bei github hinterlegen und dann ueber elpa laden
; - completion im terminal tuts noch immer nicht
; - get objective-c completion working
; - better CSS completion
; - better python mode, still sucks a bit
; - integrate ace-jump into the vim workflow, maybe with ,f ?
; - flex-autopair causes wrong html >< insertions
; - in custom-keys I have (global-set-key [(control tab)] 'completion-at-point) but that opens in buffer, what opens that in menu?
; - What does 'load-library do? What am I supposed to load there?
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))


(add-hook 'go-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (setq tab-width 2)))

(setq auto-indent-on-visit-file t)
(auto-indent-global-mode)

(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.blade\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist
'("/\\(views\\|html\\|theme\\|templates\\)/.*\\.php\\'" . web-mode))

; Clojure..
; docs: https://github.com/clojure-emacs/cider
; C-c C-m : invoke macro-expand at point
; repl M-p M-n back forth history
; repl C-j new line-indent
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)
(setq cider-repl-pop-to-buffer-on-connect t)
(setq cider-auto-select-error-buffer t)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)


(setq git-gutter-fr+-side 'right-fringe)
(setq-default right-fringe-width 20)


(eval-after-load 'web-mode
  '(progn
     (defun prelude-web-mode-defaults ()
       ;; Disable whitespace-mode when using web-mode
       (whitespace-mode -1)
       ;; Customizations
       (setq web-mode-markup-indent-offset 4)
       (setq web-mode-css-indent-offset 2)
       (setq web-mode-code-indent-offset 4)
       (setq web-mode-disable-autocompletion t)
       (local-set-key (kbd "RET") 'newline-and-indent))
     (setq prelude-web-mode-hook 'prelude-web-mode-defaults)

     (add-hook 'web-mode-hook (lambda ()
                                (run-hooks 'prelude-web-mode-hook)))))

(add-hook 'ruby-mode-hook
          (lambda () (modify-syntax-entry ?_ "w")))
