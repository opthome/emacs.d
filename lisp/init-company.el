(use-package company
  :ensure t
  :init (global-company-mode)
  :config
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-align-annotations t)
  (setq company-idle-dalay 0.0)
  (setq company-show-numbers t)
  (setq company-selection-wrap-around t))

(use-package company-box
  :ensure t
  :if window-system
  :hook (company-mode . company-box-mode))

(use-package yasnippet
  :ensure t
  :init (yas-global-mode)
  :hook (prog-mode . yas-minor-mode))

(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)


(provide 'init-company)
