;; python-mode settings
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist(cons '("python" . python-mode)
                             interpreter-mode-alist))
;; path to the python interpreter, e.g.: ~rw/python27/bin/python2.7
(setq py-python-command "python")
(autoload 'python-mode "python-mode" "Python editing mode." t)
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(add-hook 'python-mode-hook
           (lambda ()
             (set (make-variable-buffer-local 'beginning-of-defun-function)
                  'py-beginning-of-def-or-class)
             (setq outline-regexp "def\\|class ")))
			 

;; pymacs settings
(setq pymacs-python-command py-python-command)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")

;; pycomplete setup
(require 'pycomplete)
(define-key (kbd "TAB") py-mode-map 'py-complete)
(define-key (kbd "TAb") py-shell-map 'py-complete)

(setq tab-always-indent 'complete)
(defun py-complete-use-tab ())
 (add-hook 'completion-at-point-functions 'py-complete nil 'local)
(add-hook 'py-mode-map 'py-complete-use-tab)
(add-hook 'py-shell-map 'py-complete-use-tab)


(provide 'starter-kit-python)