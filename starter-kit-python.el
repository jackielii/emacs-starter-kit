; python-mode settings
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(add-hook 'python-mode-hook
          '(lambda () (eldoc-mode 1)) t)



;;; no Tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default py-indent-offset 4)

(defun py-next-block ()
  "go to the next block.  Cf. `forward-sexp' for lisp-mode"
  (interactive)
  (py-mark-block nil 't)
  (back-to-indentation))


;;=================================
;; pycomplete mode
;;=================================
(require 'pycomplete)
(require 'pymacs)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)
(setq ropemacs-guess-project t)

;; Adding hook to automatically open a rope project if there is one
;; in the current or in the upper level directory
(add-hook 'python-mode-hook
		(lambda ()
		  (cond ((file-exists-p ".ropeproject")
				 (rope-open-project default-directory))
				((file-exists-p "../.ropeproject")
				 (rope-open-project (concat default-directory "..")))
				)))

;;=================================

(require 'autopair)
(autopair-global-mode)

(require 'yasnippet)
(yas/initialize)
(yas/load-directory (concat dotfiles-dir "snippets"))

(provide 'starter-kit-python)
;; starter-kit-python.el ends here
