(require 'ibuffer)

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
                 ("css" (or (mode . css-mode)
                           (mode . scss-mode)
                           ))
                 ("shell" (or
                             (name . "^\\*shell")
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


(defun me/fix-ibuffer-name-size ()
  (interactive)
  ;; https://github.com/purcell/emacs.d/issues/350
  (define-ibuffer-column size-h
    (:name "Size" :inline t)
    (cond
     ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
     ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
     (t (format "%8d" (buffer-size)))))

  (setq ibuffer-formats
        '((mark modified read-only " "
                (name 65 65 :left :nil) " "
                (size-h 9 -1 :right) " "
                (mode 16 16 :left :elide) " "
                filename-and-process)))

  )

(me/fix-ibuffer-name-size)
