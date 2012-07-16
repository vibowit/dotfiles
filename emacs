;; -*- mode: Emacs-Lisp; -*-
;; -----------------------------------------------------------------------
;;  vibowit's .emacs file
;; -----------------------------------------------------------------------


;; -----------------------------------------------------------------------
;;  User Interface
;; -----------------------------------------------------------------------
(setq default-frame-alist
      '((wait-for-wm . nil)
        (top . 0)
        (width . 80)
        (tool-bar-lines . 0)
        (menu-bar-lines . 0)))

;; Interface needs to be minimal...
(put 'scroll-left 'disabled nil)
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'blink-cursor-mode) (blink-cursor-mode -1))
(transient-mark-mode t)
(global-hl-line-mode t)
(scroll-bar-mode -1)

;; Hide the menu bar
;; cost me anything on OSX.
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq inhibit-startup-message t)


;; -----------------------------------------------------------------------
;; vibowit options
;; -----------------------------------------------------------------------
(show-paren-mode t)
(setq column-number-mode t)

;; -----------------------------------------------------------------------
;; Load paths
;; -----------------------------------------------------------------------
(defvar my-load-path (expand-file-name "~/.emacs.d/plugins"))
;; (defvar yas-load-path (expand-file-name "~/.emacs.d/plugins/yasnippet"))

(add-to-list 'load-path my-load-path)
;; (add-to-list 'load-path yas-load-path)
(setq byte-compile-warnings nil)


;; -----------------------------------------------------------------------
;; Color theme
;; -----------------------------------------------------------------------
(require 'color-theme-zenburn)
(color-theme-zenburn)


;; -----------------------------------------------------------------------
;; Personal Keybindings
;; -----------------------------------------------------------------------
;; (global-set-key '[f3] 'select-vc-status)
;;;;;;; DO NOT USE [f9], [f10], [f11], OR [f12]. They're taken by the
;;;;;;; OS on OSX for the Expose stuff.

;; setting the PC keyboard's various keys to
;; Super or Hyper
(setq w32-pass-lwindow-to-system nil 
      w32-pass-rwindow-to-system nil 
      w32-pass-apps-to-system nil 
      w32-lwindow-modifier 'super ; Left Windows key 
      w32-rwindow-modifier 'super ; Right Windows key 
      ;;w32-apps-modifier 'hyper) ; Menu key
      )

(global-set-key "\C-x\M-f" 'find-file-at-point)
(global-set-key "\M-gc" 'goto-char)

;;; Unbind the stupid minimize that I always hit.
(global-unset-key "\C-z")

(global-set-key (kbd "M-3") 'delete-other-windows)
(global-set-key (kbd "M-4") 'split-window-vertically)
(global-set-key (kbd "M-$") 'split-window-horizontally)
(global-set-key [(shift home)] '(lambda () (interactive) (other-window -1)))
(global-set-key [(shift end)] '(lambda () (interactive) (other-window 1)))


;; Setup hippie-expand (we're going to have to make an eval-after-load
;; section later)
(defun hippie-expand-case-sensitive (arg)
  "Do case sensitive searching so we deal with gtk_xxx and GTK_YYY."
  (interactive "P")
  (let ((case-fold-search nil))
    (hippie-expand arg)))

(global-set-key "\M-/" 'hippie-expand-case-sensitive)
(global-set-key (kbd "M-SPC") 'hippie-expand-case-sensitive)

;; (setq hippie-expand-try-functions-list
;;       '(try-expand-dabbrev
;;         try-complete-file-name-partially
;;         try-complete-file-name
;;         try-expand-all-abbrevs
;;         try-expand-list
;;         try-expand-dabbrev-all-buffers
;;         try-expand-dabbrev-from-kill))

;; smart tab
;; (global-set-key [(tab)] 'smart-tab)
(defun smart-tab ()
  "This smart tab is minibuffer compliant: it acts as usual in
    the minibuffer. Else, if mark is active, indents region. Else if
    point is at the end of a symbol, expands it. Else indents the
    current line."
  (interactive)
  (if (minibufferp)
      (unless (minibuffer-complete)
        (dabbrev-expand nil))
    (if mark-active
        (indent-region (region-beginning)
                       (region-end))
      (if (looking-at "\\_>")
          (dabbrev-expand nil)
        (indent-for-tab-command)))))

;; change behaviour of beggining of line
(defun smart-beginning-of-line()
  "Move point to first non-whitespace character or beginning-of-line

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
	 (beginning-of-line))))

(global-set-key [home] 'smart-beginning-of-line)
(global-set-key "\C-a" 'smart-beginning-of-line)


;; -----------------------------------------------------------------------
;; Set up coding system.
;; -----------------------------------------------------------------------
(prefer-coding-system 'utf-8)


;; -----------------------------------------------------------------------
;; auto-mode-alist
;; -----------------------------------------------------------------------
(setq auto-mode-alist
      (append '(("\\.[Cc][Xx][Xx]$" . c++-mode)
                ("\\.[Cc][Pp][Pp]$" . c++-mode)
                ("\\.[Hh][Xx][Xx]$" . c++-mode)
                ("\\.[Tt][Cc][Cc]$" . c++-mode)
                ("\\.h$" . c++-mode)
                ("\\.i$" . c++-mode)    ; SWIG
                ("\\.mm?$" . objc-mode)
                ("_emacs" . lisp-mode)
                ("\\.el\\.gz$" . lisp-mode)
                ("\\.mak$" . makefile-mode)
                ("\\.conf$" . conf-mode)
                ("\\.go$" .  go-mode)
                ("Doxyfile.tmpl$" . makefile-mode)
                ("Doxyfile$" . makefile-mode)
                ("\\.uncompressed$" . hexl-mode)
                ("\\.ke$" . kepago-mode)
                ("\\.markdown$" . markdown-mode)
                ("\\.md$" . markdown-mode)
                ("\\.txt$" . markdown-mode)
                ("\\.textile$" . textile-mode)
                ("\\.kfn$" . kfn-mode)
                ("\\.rb$" . ruby-mode)
                ("\\.cml$" . xml-mode)
                ("\\.cg$" . cg-mode)
                ("\\.y$" . bison-mode)
                ("\\.yy$" . bison-mode)
                ("\\.l$" . flex-mode)
                ("\\.ll$" . flex-mode)
                ("\\.lua$" . lua-mode)
                ("\\.org$" . org-mode)
                ("\\.scons$" . python-mode)
                ("SCons\\(cript\\|truct\\)" . python-mode)
                ("\\.gclient$" . python-mode)
                ("/mutt" . mail-mode)
                ) auto-mode-alist))

(setq interpreter-mode-alist
      (append '(("ruby" . ruby-mode))
              interpreter-mode-alist))

;; Ignore haskell interface files.
(add-to-list 'completion-ignored-extensions ".hi")


;; -----------------------------------------------------------------------
;; Startup variables
;; -----------------------------------------------------------------------
(setq user-full-name "Boguslaw Witkowski"
      user-mail-address "vibowit@vibowit.com"

      enable-local-variables :safe
      inhibit-startup-message t
      default-major-mode 'text-mode
      require-final-newline t
      default-tab-width 4
      default-fill-column 79
      truncate-partial-width-windows nil
      frame-title-format (concat user-login-name "@" system-name))

(add-hook 'suspend-hook 'do-auto-save) ;; Auto-Save on ^Z

(setq-default echo-keystrokes 2
              next-screen-context-lines 4
              compilation-scroll-output t
              indent-tabs-mode nil
              tags-revert-without-query t)

(put 'eval-expression 'disabled nil)
(fset 'yes-or-no-p 'y-or-n-p) ;; Make all yes-or-no questions as y-or-n


;; -----------------------------------------------------------------------
;; Modules loaded at startup (and their configuration)
;; -----------------------------------------------------------------------
;; ------------------------------------------------------ [ haskell-mode ]
;; (load "/usr/share/emacs/site-lisp/haskell-mode/haskell-site-file.el")


;; --------------------------------------------------- [ yasnippets-mode ]
;; (require 'yasnippet) ;; not yasnippet-bundle
;; (yas/global-mode 1)
;; (setq yas/trigger-key "<C-tab>") ;; make sure this is before yas/initialize
;; (yas/initialize)
;; (yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")


;; CO TO?
;; (require 'ido)
;; (ido-mode t)
;; (setq ido-default-file-method 'selected-window)
;; (setq ido-default-buffer-method 'selected-window)

;; ---------------------------------------------------------- [ diminish ]
;; Makes minor mode names in the modeline shorter.
;; (require 'diminish)

;; (eval-after-load "filladapt"
;;   '(diminish 'filladapt-mode "Fill"))
;; (eval-after-load "abbrev"
;;   '(diminish 'abbrev-mode "Ab"))
;; (eval-after-load "doxymacs"
;;   '(diminish 'doxymacs-mode "dox"))
;; (eval-after-load "yasnippet"
;;     '(diminish 'yas/minor-mode "Y"))

;; ------------------------------------------------- [ autocomplete-mode ]
;; (require 'auto-complete)
;; (global-auto-complete-mode 1)
;; (load "auto-complete-haskell.el")

;; -------------------------------------------------------- [ backup-dir ]
;; Changes the location where backup files are placed. Instead of
;; being spread out all over the filesystem, they're now placed in one
;; location.
(if (file-accessible-directory-p (expand-file-name "~/.Trash"))
    (add-to-list 'backup-directory-alist
                 (cons "." (expand-file-name "~/.Trash/emacs-backups/"))))

;; ----------------------------------------------------- [ midnight-mode ]
(require 'midnight)

;; Never clean up these files. I will probably always have my .emacs file open.
(add-to-list 'clean-buffer-list-kill-never-buffer-names "emacs")

;; Clean up these buffers more often
(add-to-list 'clean-buffer-list-kill-buffer-names "*Annotate ")

;; ------------------------------------------------------------- [ pager ]
;;; from: http://user.it.uu.se/~mic/pager.el
;; (require 'pager)
;; (global-set-key "\C-v"     'pager-page-down)
;; (global-set-key [next]     'pager-page-down)
;; (global-set-key "\ev"      'pager-page-up)
;; (global-set-key [prior]    'pager-page-up)
;; (global-set-key '[M-up]    'pager-row-up)
;; (global-set-key '[M-kp-8]  'pager-row-up)
;; (global-set-key '[M-down]  'pager-row-down)
;; (global-set-key '[M-kp-2]  'pager-row-down)

;; -------------------------------------------------- [ browse-kill-ring ]
;; Select something that you put in the kill ring ages ago.
(autoload 'browse-kill-ring "browse-kill-ring" "Browse the kill ring." t)
(global-set-key (kbd "C-c k") 'browse-kill-ring)
(eval-after-load "browse-kill-ring"
  '(progn
     (setq browse-kill-ring-quit-action 'save-and-restore)))

;; ------------------------------------------------------------- [ shell ]
(eval-after-load "shell"
  '(progn
     (ansi-color-for-comint-mode-on)))

;; ------------------------------------------------------------ [ ispell ]
(eval-after-load "ispell"
  '(progn
     ;; Use the -C option when running aspell, which will
     ;; ConsiderCamelCaseToBeCorrect
     (setq ispell-extra-args '("-C"))))

;; ------------------------------------------------------------- [ tramp ]
(eval-after-load "tramp"
  '(add-to-list 'tramp-default-method-alist
                '(".*\\.umich\\.edu\\'" "" "ssh")))
(cond  ((eq window-system 'w32)
        (setq tramp-default-method "plink")))

;; ----------------------------------------------------------- [ flymake ]
;; Mostly stolen from http://www.emacswiki.org/cgi-bin/emacs-en/FlymakeRuby
(eval-after-load "flymake"
  '(progn
     (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
     (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

     (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3)
           flymake-err-line-patterns)

     (set-face-background 'flymake-errline "red4")
     (set-face-background 'flymake-warnline "dark slate blue")))

;; ----------------------------------------------------------- [ ibuffer ]
;; *Nice* buffer switching
;; replace standard buffer list
(defalias 'list-buffers 'ibuffer)

(setq ibuffer-show-empty-filter-groups nil)
(setq ibuffer-saved-filter-groups
      '(("default"
         ("version control" (or (mode . svn-status-mode)
                    (mode . svn-log-edit-mode)
                    (name . "^\\*svn-")
                    (name . "^\\*vc\\*$")
                    (name . "^\\*Annotate")
                    (name . "^\\*git-")
                    (name . "^\\*vc-")))
         ("emacs" (or (name . "^\\*scratch\\*$")
                      (name . "^\\*Messages\\*$")
                      (name . "^TAGS\\(<[0-9]+>\\)?$")
                      (name . "^\\*Help\\*$")
                      (name . "^\\*info\\*$")
                      (name . "^\\*Occur\\*$")
                      (name . "^\\*grep\\*$")
                      (name . "^\\*Compile-Log\\*$")
                      (name . "^\\*Backtrace\\*$")
                      (name . "^\\*Process List\\*$")
                      (name . "^\\*gud\\*$")
                      (name . "^\\*Man")
                      (name . "^\\*WoMan")
                      (name . "^\\*Kill Ring\\*$")
                      (name . "^\\*Completions\\*$")
                      (name . "^\\*tramp")
                      (name . "^\\*shell\\*$")
                      (name . "^\\*compilation\\*$")))
         ("emacs source" (or (mode . emacs-lisp-mode)
                             (filename . "/Applications/Emacs.app")
                             (filename . "/bin/emacs")))
         ("agenda" (or (name . "^\\*Calendar\\*$")
                       (name . "^diary$")
                       (name . "^\\*Agenda")
                       (name . "^\\*org-")
                       (name . "^\\*Org")
                       (mode . org-mode)
                       (mode . muse-mode)))
         ("latex" (or (mode . latex-mode)
                      (mode . LaTeX-mode)
                      (mode . bibtex-mode)
                      (mode . reftex-mode)))
         ("dired" (or (mode . dired-mode))))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

;; Order the groups so the order is : [Default], [agenda], [emacs]
(defadvice ibuffer-generate-filter-groups (after reverse-ibuffer-groups ()
                                                 activate)
  (setq ad-return-value (nreverse ad-return-value)))

;; ---------------------------------------------------------- [ org-mode ]
;; (require 'org)
(add-to-list 'load-path (expand-file-name "~/git/org-mode/lisp"))
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(require 'org-install)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cb" 'org-iswitchb)
(define-key global-map "\C-co" 'org-jump-to-project-todo)


(setq org-agenda-files (quote ("~/git/org")))

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE"))))

(setq org-use-fast-todo-selection t)
(setq org-log-done t)

(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "opera")

;; (setq org-use-fast-todo-selection t)
;; (setq org-mobile-inbox-for-pull "~/from-mobile.org")
;; (setq org-agenda-custom-commands
;;       '(("w" todo "WAITING" nil)
;;         ("n" todo "NEXT" nil)
;;         ("d" "Agenda + Next Actions" ((agenda) (todo "NEXT"))))
;;       )

;; (defun gtd()
;;   (interactive)
;;   (find-file (car org-agenda-files))
;;   )

 ;; (cond  ((eq window-system 'w32)
 ;;        (setq org-agenda-files (quote ("d:/Files/Settings/Vibowit/Dropbox/Gtd/mygtd.org")))
 ;;        (setq org-mobile-directory "d:/Files/Settings/Vibowit/Dropbox/MobileGTD")
 ;;        (setq org-directory "d:/Files/Settings/Vibowit/Dropbox/GTD"))
 ;;       (t
 ;;        '(progn
 ;;           ;; Add all org files in the org directory to the agenda
 ;;           (mapcar
 ;;            (lambda (file)
 ;;              (add-to-list 'org-agenda-files file))
 ;;            (directory-files (expand-file-name "~/org/") t "\\.org")))
 ;;        ))


;; -----------------------------------------------------------------------
;; Utility Methods
;; -----------------------------------------------------------------------
(defun insert-date () "Inserts standard date time string." 
  (interactive)
  (insert (format-time-string "%d.%m.%Y")))

;; (global-set-key "\C-x\M-d" 'insert-date)


;; IDO mode
(require 'ido)


;; -----------------------------------------------------------------------
;; Helper Functions (used in mode startup)
;; -----------------------------------------------------------------------
;; --------------------------------------------- [ start-programing-mode ]
(defun start-programing-mode()
  (interactive)

  ;; Display column numbers only in code.
  (column-number-mode t)

  ;; Setup flyspell to make me not look like an idiot to my coworkers
  ;; and Haeleth and whoever else reads my code.
  ;; (flyspell-prog-mode)

  ;; All trailing whitespace needs to be highlighted so it can die.
  (setq show-trailing-whitespace t)

  ;; Highlight matching parenthesis (and other bracket likes)
  (show-paren-mode t)

  ;; (autopair-mode t) 
  ;; (setq autopair-autowrap t) ;; attempt to wrap selection
)

;; ------------------------------------------- [ my-start-scripting-mode ]
(defun my-start-scripting-mode (file-extension hash-bang)
  ;; All scripting languages are programming languages
  (start-programing-mode)

  (local-set-key "\C-css" 'insert-script-seperator-line)
  (local-set-key "\C-csh" 'insert-script-section-header)
  (local-set-key "\C-csb" 'insert-script-big-header)

  ;; Build a startup template for this mode.
  (my-start-autoinsert)
  (tempo-define-template (concat file-extension "startup")
                         (list (concat hash-bang "\n\n")))
  (push (cons (concat "\\." file-extension "$")
              (intern (concat "tempo-template-" file-extension "startup")))
        auto-insert-alist)

  ;; Make the script executable on save
  (add-hook 'after-save-hook
            'executable-make-buffer-file-executable-if-script-p
            nil t))

;; ----------------------------------------------- [ my-start-autoinsert ]
(defun my-start-autoinsert ()
  "Helper function called from anything that puts in a template
from an empty file."
  (interactive)
  (require 'autoinsert)
  (add-hook 'find-file-hooks 'auto-insert)
  (setq auto-insert-alist '())
  (setq auto-insert-query nil)
  (require 'tempo))

;; -----------------------------------------------------------------------
;;  Mode Hooks (aka the other way to make emacs fast)
;; -----------------------------------------------------------------------
;; ----------------------------------------------- [ Compilation startup ]
(defun my-compilemode-startup ()
  "I want to be able to treat compilation windows like part of the current
project, so if I'm in the compilation buffer, [f3] and [f5] work properly."
  ;; TODO: This causes recursion and thus breaks all compile-mode
  ;; commands. Investigate this further later.
  ;; (setup-project-for-local-buffer)
)

(add-hook 'compilation-mode-hook 'my-compilemode-startup)

;; -------------------------------------------------- [ Org Mode startup ]
(defun my-org-mode-startup ()
  "Setup org mode so its useful."
  (setq org-log-done t)
  (setq org-odd-levels-only t)
  (setq org-hide-leading-stars t))

(add-hook 'org-mode-hook 'my-org-mode-startup)

;; --------------------------------------------------- [ Haskell startup ]
;; (defun my-haskell-startup ()
;;   "Change the default haskell environment."
;;   (interactive)
;;   (start-programing-mode)

;;   ;; (ftf-add-filetypes '("*.hs"))

;;   (turn-on-haskell-doc-mode)
;;   (turn-on-haskell-indent)
;;   ;; (turn-on-haskell-indentation)
;;   (turn-on-haskell-decl-scan))

;; (add-hook 'haskell-mode-hook 'my-haskell-startup)

;; ---------------------------------------------- [ Shell script startup ]
(defun my-shellscript-startup ()
  "Setup shell script mode."
  (interactive)
  (my-start-scripting-mode "sh" "#!/bin/bash"))

(add-hook 'sh-mode-hook 'my-shellscript-startup)

;; ---------------------------------------------------- [ Python startup ]
(defun my-python-startup ()
  "Setup Python style."
  (interactive)
  (local-set-key '[f8] 'pdb)
  (setq tab-width 2)
  (setq indent-tabs-mode nil)  ; Autoconvert tabs to spaces
  (setq python-indent 2)
  (setq python-continuation-offset 2)
  (setq py-smart-indentation nil)
  (my-start-scripting-mode "py" "#!/usr/bin/python"))

(add-hook 'python-mode-hook 'my-python-startup)

;; ------------------------------------------------------ [ Ruby startup ]
(defun my-ruby-startup ()
  "Setup Ruby."
  (interactive)
  (local-set-key '[f8] 'rubydb)

  (my-start-scripting-mode "rb" "#!/bin/ruby")

  ;; Ruby uses flymake for the win.
  ;;(setup-ruby-flymake)

  ;;(setq ri-ruby-script
  ;;      (expand-file-name "~/.elliot-unix/bin/ri-emacs.rb"))
  ;;(autoload 'ri "ri-ruby.el" nil t)
  )

(add-hook 'ruby-mode-hook 'my-ruby-startup)

;; ------------------------------------------------ [ Emacs Lisp Startup ]
(defun my-elisp-startup ()
  (interactive)
  (start-programing-mode)

  ;; (ftf-add-filetypes '("*.el"))

  ;; Byte compile this file as soon as its saved.
  (setq byte-compile-warnings nil)
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook
        '(lambda () (byte-compile-file buffer-file-name))
        nil t)

  ;; When editing elisp code, we want hippie expand to reference emacs
  ;; lisp symbols. (Note: We are shifting this onto the front of the
  ;; list, so put this so -partially is called first)
  (make-local-variable 'hippie-expand-try-functions-list)
  (add-to-list 'hippie-expand-try-functions-list
               'try-complete-lisp-symbol)
  (add-to-list 'hippie-expand-try-functions-list
               'try-complete-lisp-symbol-partially)

  ;; Define lisp key macros
  (local-set-key "\C-css" 'insert-elisp-seperator-line)
  (local-set-key "\C-csh" 'insert-elisp-section-header)
  (local-set-key "\C-csb" 'insert-elisp-big-header))

(add-hook 'emacs-lisp-mode-hook 'my-elisp-startup)

;; --------------------------------------------- [ Markdown Mode Startup ]
(defun my-markdown-startup ()
  (interactive)
  (longlines-mode t)
  (put 'downcase-region 'disabled nil))

(add-hook 'markdown-mode-hook 'my-markdown-startup)

;; ------------------------------------------------- [ Text Mode Startup ]
(defun my-textmode-startup ()
  (interactive)
  ;;(filladapt-mode t)
  ;;(flyspell-mode t)
  (local-set-key "\C-css" 'insert-text-seperator-line))

(add-hook 'text-mode-hook 'my-textmode-startup)


;; -----------------------------------------------------------------------
;; Final settings
;; -----------------------------------------------------------------------
; (setq initial-major-mode 'text-mode)
(switch-to-buffer "*scratch*")
(insert-string "Ready to serve.\n")

;; for emacsclient
; (server-start)
