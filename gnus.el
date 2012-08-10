(setq user-mail-address "vibowit@vibowit.com")
(setq user-full-name "vibowit")

(custom-set-variables
 '(gnus-select-method
   (quote (nntp "bull"
                (nntp-address "bull")
                (nntp-via-address "vibowit.homeip.net")
                (nntp-via-user-name "vibowit")
                (nntp-via-rlogin-command "ssh")
                (nntp-via-rlogin-command-switches ("-C"))
                (nntp-open-connection-function nntp-open-via-rlogin-and-netcat)))))

(defun my-message-mode-setup ()
  (setq fill-column 72)
  (turn-on-auto-fill))

(add-hook 'message-mode-hook 'my-message-mode-setup)
