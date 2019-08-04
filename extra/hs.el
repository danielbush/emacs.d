;;; extra/hs -- extra configs
;;; Commentary:
;;; Code:

(require 'js2-mode)
(require 'css-mode) ;; loads scss-mode as well, so we can use css-mode-map, scss-mode-map
(require 'groovy-mode)

(defun me/hs-keys (mode-map)
  (hs-minor-mode 1)
  (define-key mode-map (kbd "C-c C-f") 'hs-hide-level)
  (define-key mode-map (kbd "C-c C-v") 'hs-show-all)
  (define-key mode-map (kbd "C-c C-b") 'hs-toggle-hiding)
  )

(add-hook 'js2-mode-hook (lambda () (me/hs-keys js2-mode-map)))
(add-hook 'css-mode-hook (lambda () (me/hs-keys css-mode-map)))
(add-hook 'scss-mode-hook (lambda () (me/hs-keys scss-mode-map)))
(add-hook 'groovy-mode-hook (lambda () (me/hs-keys groovy-mode-map)))
(add-hook 'emacs-lisp-mode-hook (lambda () (me/hs-keys emacs-lisp-mode-map)))

(provide 'extra/hs)
;;; hs.el ends here
