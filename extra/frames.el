
(defun me/setup-frames ()
  "Only run this at the beginning."
  (interactive)
  (set-frame-name "1")
  (me/bg-dark)
  (make-frame-command)
  (set-frame-name "2")
  (make-frame-command)
  (set-frame-name "3"))

(provide 'me/frames)
;;; frames.el ends here
