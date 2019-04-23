(require 'thingatpt)
(require 'dumb-jump)

;; Jumping on foo.|bar() doesn't behave the same as jumping on foo.|bar in js.
;; Actually "Dumb Jump Ignore Context" = on will fix this problem.
;; However, this is another workaround - because prompt doesn't have context either.

(defun me/dumb-jump-go-prompt ()
  (interactive)
  (dumb-jump-go nil nil (read-from-minibuffer "Jump to: " (thing-at-point 'symbol))))

(defun me/dumb-jump-go-prompt-other-window ()
  (interactive)
  (let ((dumb-jump-window 'other)
        (input (read-from-minibuffer "Jump to: " (thing-at-point 'symbol))))
    (dumb-jump-go nil nil input)
    )
  )


(provide 'me/dumb-jump)
;;; dumb-jump.el ends here
