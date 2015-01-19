(load "~/.emacs.d/better-defaults.el") ;; this should always be at the top of init.el

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes") ;; add themes dir for loading colors
(load-theme 'blackboard t)                                ;; load the blackboard color scheme

(show-paren-mode 1)                 ;; highlighting matching parentheses

(global-linum-mode 1) ;; show line numbers

(column-number-mode 1) ;; show cursor's (x, y) in status bar

(setq make-backup-files nil) ;; nope
(setq auto-save-default nil) ;; ditto

(setq-default tab-width 2) ;; 2-space tabs

(setq-default tab-always-indent 'complete) ;; tab key indents and autocompletes

