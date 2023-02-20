
(use-package python
  :defer t
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python3" . python-mode))

(use-package lsp-pyright
  :ensure t
  :config
  :hook
  (python-mode . (lambda ()
		  (require 'lsp-pyright)
		  (lsp-deferred))))

(provide 'init-python)

