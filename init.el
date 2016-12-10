
;; This should hopefully load, if not fix.
;; Use M-x me/package-install-my-packages to install my preferred packages.

(load (concat user-emacs-directory "me/packages.el"))

(defun me/load-unsafe ()
  "Stuff that may break in a new emacs."
  (interactive)
  (load (concat user-emacs-directory "me/settings.el"))
  (load (concat user-emacs-directory "me/bindings.el"))
  (load (concat user-emacs-directory "me/extra/helm.el"))
  (load (concat user-emacs-directory "me/extra/utils.el"))
  (load (concat user-emacs-directory "me/extra/node.el"))
  )
