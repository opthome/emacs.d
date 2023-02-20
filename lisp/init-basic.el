
;; gc settins
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)
(setq make-backup-files nil)
(setq ring-bell-function 'ignore)

(global-auto-revert-mode t)
(global-hl-line-mode 1)

(global-company-mode 1)
(completion-ignore-case t)

;; edit
(electric-pair-mode t)

(add-hook 'prog-mode-hook #'show-paren-mode)
(add-hook 'prog-mode-hook #'hs-minor-mode)

;; ui
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(toggle-scroll-bar -1)

(global-display-line-numbers-mode 1)
(column-number-mode t)


(provide 'init-basic)

