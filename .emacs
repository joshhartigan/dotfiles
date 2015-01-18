(blink-cursor-mode 1)             ;; blink cursor
(setq initial-scratch-message "") ;; remove scratch buffer message
(setq inhibit-startup-message t)  ;; remove startup message
(setq ring-bell-function 'ignore) ;; prevent alarms
(scroll-bar-mode 0)               ;; nobody uses scroll bars
(tool-bar-mode 0)                 ;; remove tool bar

(add-to-list 'load-path "~/.emacs.d/plugins") ;; this is where i keep plugins
(add-to-list 'load-path "~/.emacs.d/themes")  ;; this is where i keep themes

(load "hjkl-mode.el")
(load "monokai-theme.el")
