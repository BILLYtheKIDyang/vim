;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(setq package-archives '
  (
   ("GNU ELPA" .  "http://elpa.emacs-china.org/gnu/")
   ("MELPA" .  "http://elpa.emacs-china.org/melpa/")
   ("MELPA Stable" .  "http://elpa.emacs-china.org/melpa-stable/")
   ("Marmalade" .  "http://elpa.emacs-china.org/marmalade/")
   ("Org" .  "http://elpa.emacs-china.org/org/")
   ("Sunrise Commander ELPA" .  "http://elpa.emacs-china.org/sunrise-commander/")
   ("user42 ELPA" .  "http://elpa.emacs-china.org/user42/")
   ))

(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (paredit sly-hello-world sly-quicklisp eacl w3m company sly elpl csharp-mode vimrc-mode magit htmlize))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(defun csharp-repl ()
  "Open a new side-by-side window and start CSharpRepl in it."
  (interactive)
  (split-window)
  (other-window 1)
  (comint-run "csi"))
(require 'server)
(or (server-running-p)
    (server-start))
