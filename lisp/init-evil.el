(use-package evil
  :ensure t
  :init (evil-mode))



(use-package evil-leader
  :init (global-evil-leader-mode)
  :custom (evil-leader/leader "SPC")
  :config
  (evil-leader/set-key
    "c" 'compile
    "ff" 'find-file
    "bb" 'consult-buffer
    "ob" 'consult-buffer-other-window
    "x" 'consult-mode-command
    "gl" 'consult-line
    "gg" 'consult-grep

    "tt" 'treemacs
    "st" 'treemacs-select-window

    "<" 'centaur-tabs-backward
    ">" 'centaur-tabs-forward
    
    "0" 'select-window-0
    "1" 'select-window-1
    "2" 'select-window-2
    "3" 'select-window-3
    "4" 'select-window-4
    "8" 'cfw:open-calendar-buffer
    "9" 'calendar
    ))



(provide 'init-evil)
