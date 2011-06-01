; python-mode settings
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(add-hook 'python-mode-hook
          '(lambda () (eldoc-mode 1)) t)

(defun py-next-block ()
  "go to the next block.  Cf. `forward-sexp' for lisp-mode"
  (interactive)
  (py-mark-block nil 't)
  (back-to-indentation))

;;=================================
;; autocomplete mode
;;=================================

;;=================================
;; pycomplete mode
;;=================================
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")

(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")

; (require 'pycomplete)
;;=================================


(provide 'starter-kit-python)
;; starter-kit-python.el ends here
