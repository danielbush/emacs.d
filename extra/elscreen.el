;;; extra/elscreen.el -- stuff
;;; Commentary:
;;; Code:

(require 'elscreen)

(defun me/elscreen-create-123 ()
  (interactive)
  (elscreen-kill-others)
  (elscreen-create)
  (elscreen-create)
  )

(defun me/with-elscreen-at-index (index fn)
  (elscreen-goto index)
  (funcall fn)
  )

(provide 'extra/elscreen)
;;; elscreen.el ends here
