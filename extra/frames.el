
(defun me/setup-frames ()
  "Only run this at the beginning."
  (interactive)

  (me/make-and-name-frame "1" 'me/bg-black t)
  (me/make-and-name-frame "2" 'me/bg-blue)
  (me/make-and-name-frame "3" 'me/bg-dark)
  (me/make-and-name-frame "4" 'me/bg-purple)
  )

(defun me/make-and-name-frame (name colour-fn &optional dont-make)
  (unless dont-make (make-frame-command))
  (funcall colour-fn)
  (set-frame-name name)
  )
