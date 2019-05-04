;;; frames.el -- stuff
;;; Commentary:

(require 'settings)
(require 'extra/elscreen)

;;; Code:

(defun me/setup-frames ()
  "Only run this at the beginning."
  (interactive)
  (set-frame-name "0")
  (me/font-small)

  (select-frame (make-frame '((name . "3"))))
  (me/bg-purple)
  (me/setup-elscreen-admin)

  (select-frame (make-frame '((name . "2"))))
  (me/bg-blue)
  (me/setup-elscreen)

  (select-frame (make-frame '((name . "1"))))
  (me/bg-dark)
  (me/setup-elscreen)

  (select-frame-by-name "0")
  (delete-frame)
)

(provide 'extra/frames)
;;; frames.el ends here
