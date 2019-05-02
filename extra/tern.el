;;; extra/tern.el --- me/tern
;;; Commentary:
;; https://emacs.cafe/emacs/javascript/setup/2017/05/09/emacs-setup-javascript-2.html

;;; Code:

(require 'company)
(require 'company-tern)
(require 'extra/dumb-jump)

(add-to-list 'company-backends 'company-tern)
(add-hook 'js2-mode-hook (lambda ()
                           (tern-mode)
                           (company-mode)))
                           
;; Disable completion keybindings.
;; If tern loads in js2-mode, this will prevent it from overriding these.
(define-key tern-mode-keymap (kbd "M-.") nil)
(define-key tern-mode-keymap (kbd "M-,") nil)
(define-key tern-mode-keymap (kbd "C-M-.") nil)

(defun me/js2-mode-hook() (me/mode-hook js2-mode-map))
(defun me/groovy-mode-hook() (me/mode-hook groovy-mode-map))

(defun me/mode-hook(mode-map)
   (define-key mode-map (kbd "M-.") 'dumb-jump-go)
   ;; (define-key mode-map (kbd "M-.") 'me/dumb-jump-go-prompt)
   (define-key mode-map (kbd "C-M-.") 'dumb-jump-go-other-window)
   ;; (define-key mode-map (kbd "C-M-.") 'me/dumb-jump-go-prompt-other-window)
   (define-key mode-map (kbd "M-,") 'dumb-jump-back)

   (hs-minor-mode 1)
   (define-key mode-map (kbd "C-c C-f") 'hs-hide-level)
   (define-key mode-map (kbd "C-c C-v") 'hs-show-all)
   (define-key mode-map (kbd "C-c C-b") 'hs-toggle-hiding)
   ;; (define-key mode-map (kbd "C-c C-b") 'hs-show-block)
   ;; (define-key mode-map (kbd "C-c C-h") 'hs-hide-block)
  )

(add-hook
 'js2-mode-hook 'me/js2-mode-hook)

(add-hook
 'groovy-mode-hook 'me/groovy-mode-hook)

(provide 'extra/tern)
;;; tern.el ends here
