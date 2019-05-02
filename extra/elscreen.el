;;; extra/elscreen.el -- stuff
;;; Commentary:
(require 'elscreen)

;;; Code:

(defun me/elscreen-new (name)
  (interactive "sName: ")
  (elscreen-create)
  (elscreen-screen-nickname name)
  )

(defun me/elscreen-make (name path &optional dont-make)
  (unless dont-make (elscreen-create))
  (elscreen-screen-nickname name)
  (find-file path)
  (delete-other-windows)
  )

(defun me/elscreen-start ()
  (interactive)
  (elscreen-start)
  (elscreen-goto 0) ; need this as well as kill-others
  (elscreen-kill-others)
)

(defun me/setup-elscreen ()
  "Preload some elscreens."
  (interactive)
  (me/elscreen-start)
  (me/elscreen-make "1" "~/projects" t)
  (me/elscreen-make "2" "~/projects")
  (me/elscreen-make "3" "~/projects")
  (me/elscreen-make "4" "~/projects")
  (elscreen-goto 0)
)

(defun me/setup-elscreen-alternative-for-domain ()
  "Preload some elscreens."
  (interactive)
  (me/elscreen-start)
  (me/elscreen-make "1" "~/.emacs.d/me" t)
  (me/elscreen-make "2" "~/notes")
  (me/elscreen-make "3" "~/")
  (me/elscreen-make "4" "~/")
  (elscreen-goto 0)
)

(defun me/elscreen-goto-screen (num)
  "NUM should be an integer."
  (interactive)
  (elscreen-goto num) (message (elscreen-get-screen-nickname num))
  )

(provide 'extra/elscreen)
;;; elscreen.el ends here
