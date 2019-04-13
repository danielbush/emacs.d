;; https://emacs.cafe/emacs/javascript/setup/2017/05/09/emacs-setup-javascript-2.html

(require 'company)
(require 'company-tern)

;;; Code:

(add-to-list 'company-backends 'company-tern)
(add-hook 'js2-mode-hook (lambda ()
                           (tern-mode)
                           (company-mode)))
                           
;; Disable completion keybindings, as we use xref-js2 instead
;; (define-key tern-mode-keymap (kbd "M-.") nil)
;; (define-key tern-mode-keymap (kbd "M-,") nil)
