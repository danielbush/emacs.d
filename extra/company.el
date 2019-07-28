;;; extra/company.el -- stuff
;;; Commentary:
;;; Code:

(require 'extra/lsp)

;;; Wait for company dropdwon to show, then hit C-: to trigger helm.
(autoload 'helm-company "helm-company") ;; Not necessary if using ELPA package
(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)
     ))

(defun me/use-helm-lsp ()
  "Wait for company dropdwon to show, then hit C-: to trigger helm.
http://melpa.org/#/helm-company"
  (interactive)
  (define-key company-mode-map (kbd "C-:") 'helm-company)
  (define-key company-active-map (kbd "C-:") 'helm-company)
  )

(defun me/company-lsp-setup ()
  "I just want lsp or a small set of things in the dropdown for js.

https://emacs.stackexchange.com/questions/20485/how-to-exclude-a-company-backend-from-autocompleting-without-globally-removing-i"
  (when (boundp 'company-backends)
    (make-local-variable 'company-backends)
    ;; remove
    ;; (setq company-backends (delete 'company-dabbrev company-backends))
    ;; add
    ;; (add-to-list 'company-backends 'company-dabbrev)
    (setq company-backends '(company-lsp company-files))
    ))

(add-hook 'js2-mode-hook
          (lambda ()
            (if me/use-lsp-for-js
                ;; (progn (company-mode) (me/company-lsp-setup))
                (progn (me/company-lsp-setup) (company-mode))
              )))

(provide 'extra/company)
;;; company.el ends here
