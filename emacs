;; -----------------------------------------------------------------------
;;  vibowit's .emacs file
;; -----------------------------------------------------------------------

;; -----------------------------------------------------------------------
;;  User Interface
;; -----------------------------------------------------------------------
(setq default-frame-alist
      '((wait-for-wm . nil)
        (top . 20)
	(left . 5)
        (width . 120)
	(height . 60)
        (tool-bar-lines . 0)
        (menu-bar-lines . 0)))

;; Interface needs to be minimal...
(put 'scroll-left 'disabled nil)
(scroll-bar-mode -1)
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'blink-cursor-mode) (blink-cursor-mode -1))
(transient-mark-mode t)
(global-hl-line-mode t)
(column-number-mode t)

;; Hide the menu bar
;; cost me anything on OSX.
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))


(show-paren-mode t)


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


;; don't need that. i can remember oryginal shortcuts.
;; (global-set-key (kbd "M-3") 'delete-other-windows)
;; (global-set-key (kbd "M-4") 'split-window-vertically)
;; (global-set-key (kbd "M-$") 'split-window-horizontally)

(global-set-key [(shift home)] '(lambda () (interactive) (other-window -1)))
(global-set-key [(shift end)] '(lambda () (interactive) (other-window 1)))

(global-set-key [C-M-right] 'next-buffer)
(global-set-key [C-M-left]  'previous-buffer)

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
(global-set-key [(tab)] 'smart-tab)
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



;; ----
;; vbs mode
;; ----

(load "~/.emacs.d/visual-basic-mode.el")
(autoload 'visual-basic-mode "visual-basic-mode" "Visual Basic mode." t)
(setq auto-mode-alist (append '(("\\.\\(frm\\|bas\\|cls\\)$" .
                                 visual-basic-mode)) auto-mode-alist))

(setq auto-mode-alist (append '(("\\.\\(frm\\|bas\\|cls\\|rvb\\|vbs\\)$" .
                                 visual-basic-mode)) auto-mode-alist))


;;;; Backup files

;; When you use Emacs to edit a file, it automatically creates a backup of the
;; original file (`make-backup-files'). Backup file have a tilde (<foo~>) at
;; the end. Emacs makes a backup for a file only the first time the file is
;; saved from a buffer. No matter how many times you subsequently save the
;; file, its backup remains unchanged. However, if you kill the buffer and then
;; visit the file again, a new backup file will be made. With <C-u C-x C-s> you
;; can explicitly tell Emacs to backup the version just saved when the file is
;; saved again.

(defvar --user-temporary-directory "~/.emacs.d/backups") ; refers to `auto-save-list-file-prefix'
(if (not (file-exists-p --user-temporary-directory))
    (make-directory --user-temporary-directory t))
(setq backup-directory-alist `(("." . ,--user-temporary-directory)))
(setq make-backup-files t
      version-control t                 ; numbered backups
      delete-old-versions t
      kept-old-versions 4
      kept-new-versions 8
      backup-by-copying t)

;; -----------------------------------------------------------------------
;; Set color-theme
;; -----------------------------------------------------------------------
;; (add-to-list 'load-path "~/.emacs.d/color-theme")
;; (add-to-list 'load-path "~/.emacs.d/color-theme-solarized")
;; (if
;;     (equal 0 (string-match "^24" emacs-version))
;;     ;; it's emacs24, so use built-in theme
;;     (require 'solarized-light-theme)
;;   ;; it's NOT emacs24, so use color-theme
;;   (progn
;;     (require 'color-theme)
;;     (color-theme-initialize)
;;     (require 'color-theme-solarized)
;;     (color-theme-solarized-dark)))


;; Load sas functions
(load "~/.emacs.d/sas_utils")

;; set theme
(add-to-list 'load-path "~/.emacs.d/themes")
(require 'color-theme-zenburn)
(color-theme-zenburn)