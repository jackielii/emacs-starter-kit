; python-mode settings
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(autoload 'python-mode "python-mode" "Python editing mode." t)
;; hooks ------------------------------
(add-hook 'python-mode-hook
          '(lambda ()
             (eldoc-mode 1)
             (linum-mode 1)
             (hl-line-mode 1)) t)

;(require 'ipython)

(require 'comint)
(define-key comint-mode-map [(meta p)]
  'comint-previous-matching-input-from-input)
(define-key comint-mode-map [(meta n)]
  'comint-next-matching-input-from-input)
(define-key comint-mode-map [(control meta n)]
  'comint-next-input)
(define-key comint-mode-map [(control meta p)]
  'comint-previous-input)

;;; no Tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default py-indent-offset 4)

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
(add-hook 'python-mode-hook
	 #'(lambda ()
		 (setq autopair-handle-action-fns
			   (list #'autopair-default-handle-action
					 #'autopair-python-triple-quote-action))))

(require 'yasnippet)
(yas/initialize)
(yas/load-directory (concat dotfiles-dir "snippets"))

(defun py-complete-list ()
  (let ((pymacs-forget-mutability t))
    (if (and (eolp) (not (bolp))
             (not (char-before-blank))
             (not (blank-linep)))
	(let ((py-complete-str
	       (pycomplete--get-all-completions 
                 (py-symbol-near-point)
                 (py-find-global-imports))))
	  py-complete-str))))

(defvar anything-c-pycomplete-sources
  '((name . "Buffers")
    (candidates . py-complete-list )
    (type . buffer)))
;; (anything 'anything-c-pycomplete-sources)

(defun anything-pycomplete ()
  (interactive)
  (anything-other-buffer
   '(anything-c-pycomplete-sources)
   " *pycomplete-anything*"))


;;-----------------------
;; useful functions
(defun py-next-block ()
  "go to the next block.  Cf. `forward-sexp' for lisp-mode"
  (interactive)
  (py-mark-block nil 't)
  (back-to-indentation))

(defun pull-next-line() 
  (interactive)
  (next-line) 
  (join-line))



;;(require 'virtualenv)
(provide 'starter-kit-python)
;; starter-kit-python.el ends here
