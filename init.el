;;; package --- inner init.el file to be used by .emacs.d/init.el
;;; 
;;; Commentary:
;;; Assumes we're in ~/.emacs.d/me
;;; Add this line to ~/.emacs.d/init.el at the bottom:
;;;   (load (concat user-emacs-directory "me/init.el"))
;;; 
;;; Code:

;; This should hopefully load, if not fix.
;; Use M-x me/package-install-my-packages to install my preferred packages.

(load (concat user-emacs-directory "me/packages.el"))

(defun me/load-unsafe ()
  "Stuff that may break in a new EMACS."
  (interactive)
  (load (concat user-emacs-directory "me/settings.el"))
  (load (concat user-emacs-directory "me/bindings.el"))
  (load (concat user-emacs-directory "me/extra/macosx.el"))
  (load (concat user-emacs-directory "me/extra/helm.el"))
  (load (concat user-emacs-directory "me/extra/utils.el"))
  (load (concat user-emacs-directory "me/extra/node.el"))
  (load (concat user-emacs-directory "me/extra/docker.el"))
  (load (concat user-emacs-directory "me/extra/windows.el"))
  (load (concat user-emacs-directory "me/extra/elscreen.el"))
  (load (concat user-emacs-directory "me/extra/frames.el"))
  )

(defun me/load-unsafe-for-domain ()
  (interactive)
  (server-start)
  (me/load-unsafe)
  (me/mac-fonts)
  (me/mac-load-PATH)
  (me/setup-elscreen)
  (me/setup-frames)
  (me/setup-elscreen-alternative-for-domain)
  (me/font-small)
  )


(provide 'me/init)
;;; init ends here
