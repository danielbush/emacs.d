;;; extra/company.el -- stuff
;;; Commentary:
;;;
;;; Code:

(require 'company) ;; to get company-mode-map
(require 'extra/lsp)

(define-key company-mode-map (kbd "C-:") 'company-complete)

(defun me/disable-company-automatic-idle-completion ()
  "Disable automatic completion because it can be expensive and laggy when on all the time.
Christ only knows why I have to do it this way."
  (interactive)
  (setq company-minimum-prefix-length 1000000)
  )
(defun me/enable-company-automatic-idle-completion ()
  (interactive)
  (setq company-minimum-prefix-length 2)
  )

;;; --------------------------------------------------------------------------------
;;; Shows how we could customise company for js:

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

;; (ignore
 (add-hook 'js2-mode-hook
           (lambda ()
             (if me/use-lsp-for-js
                 (progn
                   (me/company-lsp-setup)
                   (company-mode)
                   )
               )))
 ;; )

;; (ignore
 (eval-after-load 'company
   '(progn
      ;; Assume company-lsp and company-files are set as backends:
      (define-key company-mode-map (kbd "C-:") 'helm-company)
      (define-key company-active-map (kbd "C-:") 'helm-company)
      ;; Remember M-/ already does dabbrev, but here we allow autocomplete.
      ;; Use C-: to trigger helm-company after C-; if you want.
      (define-key company-mode-map (kbd "C-;") 'company-dabbrev-code)
      (define-key company-active-map (kbd "C-;") 'company-dabbrev-code)
      ))
 ;; )

(provide 'extra/company)
;;; company.el ends here
