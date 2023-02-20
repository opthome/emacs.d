(use-package lsp-mode
  :ensure t
  :init
  (add-hook 'lsp-mode-hook
	    (lambda ()
	      (lsp-enable-which-key-integration)
	      (add-hook 'before-save-hook #'lsp-organize-imports t t)
	      (add-hook 'before-save-hook #'lsp-format-buffer t t)))
  (add-hook 'prog-mode-hook
	    (lambda () 
	      (unless 
		(derived-mode-p 'emacs-lisp-mode 'lisp-mode)(lsp-deferred))))
  (defun lsp-save-actions ()
      "LSP actions before save."
      (add-hook 'before-save-hook #'lsp-organize-imports t t)	
      	(add-hook 'before-save-hook #'lsp-format-buffer t t))

  :hook ((lsp-mode . lsp-enable-which-key-integration) ; which-key integration
	 (lsp-mode . #'lsp-save-actions)
         ((c-mode
           c++-mode
           go-mode
           java-mode
           js-mode
           python-mode
           rust-mode
           web-mode) . lsp-deferred))
  :config
  (setq lsp-auto-guess-root t
	lsp-headerline-breadcrumb-enable nil
	lsp-log-io nil))

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :commands lsp-ui-mode
  :init
  (setq lsp-ui-doc-include-signature t
	lsp-ui-doc-position 'at-point
        lsp-ui-sideline-ignore-duplicate t)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (add-hook 'lsp-ui-mode-hook 'lsp-modeline-code-actions-mode) 
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (setq lsp-ui-doc-position 'top))


(provide 'init-lsp)
