;;; package --- Summary
;;; Commentary:

;;; Code:

;; add settings files dir
(add-to-list 'load-path (expand-file-name (concat user-emacs-directory "lisp")))

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; add your private configuration
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file) (load-file custom-file))

;; settings files
(require 'init-basic)
(require 'init-keybind)
(require 'init-elpa)
(require 'init-company)
(require 'init-vertico)
(require 'init-ui)
(require 'init-evil)
(require 'init-treemacs)
(require 'init-lsp)
(require 'init-python)
(require 'init-flycheck)
(require 'init-tools)


(provide 'init)
;;; init.el ends here

