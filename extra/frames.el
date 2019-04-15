
(defun me/setup-frames ()
  "Only run this at the beginning."
  (interactive)
  (set-frame-name "1")
  ;; (me/bg-black)
  (make-frame-command)
  (set-frame-name "2")
  (make-frame-command)
  (set-frame-name "3"))
