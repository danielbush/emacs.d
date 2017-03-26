
;; from https://www.emacswiki.org/emacs/IbufferMode#toc6

(defun me/ibuffer/filter-groups ()
  (setq ibuffer-saved-filter-groups
        (quote (("default"
                 ("dired" (mode . dired-mode))
                 ("test" (or (filename . "test/")))
                 ("js" (or (mode . rjsx-mode)
                           (mode . json-mode)
                           (mode . js-mode)
                           (mode . js2-mode)
                           (mode . js3-mode)
                           (mode . javascript-mode)
                           ))
                 ("command" (or
                             (name . "^\\*command")
                             (name . "^\\*Async")
                             ))
                 ("magit" (or
                           (name . "^\\*magit")
                           ))
                 ("emacs" (or (filename . ".emacs")))
                 ("rest" (or (name . ".*")))
                 
                 ))))
  )



(defun me/ibuffer/load-groups ()
  "Use \R in ibuffer to load this."
  (interactive)
  (me/ibuffer/filter-groups)
  (add-hook 'ibuffer-mode-hook
            (lambda ()
              (ibuffer-switch-to-saved-filter-groups "default"))) )

