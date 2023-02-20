
(defalias 'yes-or-no-p 'y-or-n-p)

;; mac keybind
(setq mac-option-modifier 'meta
      mac-command-modifier 'super)
(global-set-key (kbd "s-a") 'mark-whole-buffer)
(global-set-key (kbd "s-c") 'kill-ring-save)
(global-set-key (kbd "s-s") 'save-buffer)
(global-set-key (kbd "s-v") 'yank)
(global-set-key (kbd "s-z") 'undo)
(global-set-key (kbd "s-x") 'kill-region)

;; evil keybind


(provide 'init-keybind)
