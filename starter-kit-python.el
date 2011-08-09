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
             (auto-fill-mode 1)
             (hl-line-mode 1)
             (hs-minor-mode 1)) t)
(require 'highlight-indentation)
(add-hook 'python-mode-hook (lambda () (interactive) (highlight-indentation)))
(require 'column-marker)
(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-1 80)))
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
(require 'pymacs)
(add-hook 'python-mode-hook
          (lambda ()
            (require 'pycomplete)
            (autoload 'pymacs-apply "pymacs")
            (autoload 'pymacs-call "pymacs")
            (autoload 'pymacs-eval "pymacs" nil t)
            (autoload 'pymacs-exec "pymacs" nil t)
            (autoload 'pymacs-load "pymacs" nil t)
            (pymacs-load "ropemacs" "rope-")))

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
  (join-line)
  (py-indent-line))

;;========================
;; auto complete
(require 'auto-complete-config)
(add-to-list 'ac-modes 'python-mode)
(ac-config-default)
(ac-ropemacs-initialize)

;; (ac-define-source nropemacs
;;   '((candidates . ac-source-ropemacs)
;;     (symbol     . "p")))

;; (ac-define-source nropemacs-dot
;;   '((candidates . ac-source-ropemacs)
;;     (symbol     . "p")
;;     (prefix     . c-dot)
;;     (requires   . 0)))

(add-hook 'python-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-ropemacs)))

(define-key ac-complete-mode-map "\t" 'ac-expand)
(define-key ac-complete-mode-map "\r" 'ac-complete)

(ac-set-trigger-key "TAB")
(setq ac-auto-start nil)
(define-key ac-completing-map "\C-n" 'ac-next)
(define-key ac-completing-map "\C-p" 'ac-previous)
(setq ac-dwim t)
(setq ac-ignore-case nil)

(provide 'starter-kit-python)
;; starter-kit-python.el ends here
