
(elpy-enable)
(with-demoted-errors
  "jedi:install-server error: %S"
  (jedi:install-server) ;; install to .emacs.d/**
  )

;; - https://avilpage.com/2015/05/automatically-pep8-your-python-code.html
;;   - shows how you might prettify on save
;;   - except we can just call (elpy-format-code)
(defcustom me/prettify-python t "Whether to call elpy-format-code on save like prettify in js.")
(eval-after-load 'python
  '(add-hook
    'before-save-hook
    (lambda () (if me/prettify-python (elpy-format-code)))))

(provide 'me/python)
;;; python.el ends here
