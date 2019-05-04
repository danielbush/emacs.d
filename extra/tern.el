;;; extra/tern.el --- me/tern
;;; Commentary:
;; https://emacs.cafe/emacs/javascript/setup/2017/05/09/emacs-setup-javascript-2.html

;;; Code:

(require 'company)
(require 'company-tern)

(add-to-list 'company-backends 'company-tern)
(add-hook 'js2-mode-hook (lambda ()
                           (tern-mode)
                           (company-mode)))
                           
;; Disable completion keybindings.
;; If tern loads in js2-mode, this will prevent it from overriding these.
(define-key tern-mode-keymap (kbd "M-.") nil)
(define-key tern-mode-keymap (kbd "M-,") nil)
(define-key tern-mode-keymap (kbd "C-M-.") nil)

(provide 'extra/tern)
;;; tern.el ends here
