;;; frames.el -- configure my frames and initial windows.
;;; Commentary:
;;; Code:

(require 'settings)
(require 'extra/elscreen)

(defun me/setup-frames ()
  "Only run this at the beginning."
  (interactive)
  (set-frame-name "0")
  (me/font-small)

  (select-frame (make-frame '((name . "3"))))
  (me/bg-purple)
  (me/elscreen-create-123)
  (me/with-elscreen-at-index 0 (lambda () (find-file "~/.emacs.d/me")))
  (me/with-elscreen-at-index
   1
   (lambda ()
     (cond
      ((file-exists-p "~/todos") (find-file "~/todos"))
      ((file-exists-p "~/notes") (find-file "~/notes"))
      (t (find-file "~"))
      )
     ))
  (me/with-elscreen-at-index 2 (lambda () (find-file "~/")))
  (elscreen-goto 0)

  (select-frame (make-frame '((name . "2"))))
  (me/bg-blue)

  (select-frame (make-frame '((name . "1"))))
  (me/bg-dark)
  (me/elscreen-create-123)
  (me/with-elscreen-at-index 0 (lambda () (find-file "~/projects")))
  (me/with-elscreen-at-index 1 (lambda () (find-file "~/projects")))
  (me/with-elscreen-at-index 2 (lambda () (find-file "~/projects")))
  (elscreen-goto 0)

  (select-frame-by-name "0")
  (delete-frame)
)

(provide 'extra/frames)
;;; frames.el ends here
