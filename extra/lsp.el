;;; lsp.el -- configure lsp mostly for js stuff for now
;;; Commentary:
;;; Code:

(require 'lsp-mode)
(defcustom me/use-lsp-for-js
  t
  "Whether lsp-mode (which may include lsp-ui) and company-lsp will be enabled when js2-mode loads."
  :type 'boolean
  :group 'me/js)

;; (add-hook 'prog-mode-hook #'lsp)
(add-hook 'js2-mode-hook
          (lambda ()
            (if me/use-lsp-for-js (progn (lsp) (flymake-mode -1)))))

(require 'company)
(require 'company-lsp)
;; (push 'company-lsp company-backends)
(add-to-list 'company-backends 'company-lsp)

(provide 'extra/lsp)
;;; lsp.el ends here
