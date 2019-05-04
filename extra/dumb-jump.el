;;; extra/dumb-jump -- extra configs
;;; Commentary:
;;; Code:
(require 'thingatpt)
(require 'dumb-jump)
(require 'js2-mode)
(require 'groovy-mode)

(defun me/dumb-jump-keys (mode-map)
  (define-key mode-map (kbd "M-.") 'dumb-jump-go)
  (define-key mode-map (kbd "C-M-.") 'dumb-jump-go-other-window)
  (define-key mode-map (kbd "M-,") 'dumb-jump-back)

  ;; (define-key mode-map (kbd "M-.") 'me/dumb-jump-go-prompt)
  ;; (define-key mode-map (kbd "C-M-.") 'me/dumb-jump-go-prompt-other-window)
  )

(add-hook 'js2-mode-hook (lambda () (me/dumb-jump-keys js2-mode-map)))
(add-hook 'groovy-mode-hook (lambda () (me/dumb-jump-keys groovy-mode-map)))

;;; --------------------------------------------------------------------------------
;;; Experiment

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
  ))

;;; --------------------------------------------------------------------------------
;;; Experiment

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


(provide 'extra/dumb-jump)
;;; dumb-jump.el ends here
