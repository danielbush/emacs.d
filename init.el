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


;; (add-to-list 'load-path "~/.emacs.d/me")
;; (add-to-list 'load-path "~/.emacs.d/me/extra")

(load (concat user-emacs-directory "me/packages.el"))

(defun me/load-unsafe ()
  "Stuff that may break in a new EMACS."
  (interactive)
  (server-start)
  (load (concat user-emacs-directory "me/settings.el"))
  (load (concat user-emacs-directory "me/bindings.el"))
  (load (concat user-emacs-directory "me/extra/macosx.el"))
  (load (concat user-emacs-directory "me/extra/helm.el"))
  (load (concat user-emacs-directory "me/extra/utils.el"))
  (load (concat user-emacs-directory "me/extra/node.el"))
  (load (concat user-emacs-directory "me/extra/tern.el"))
  (load (concat user-emacs-directory "me/extra/python.el"))
  (load (concat user-emacs-directory "me/extra/terraform.el"))
  (load (concat user-emacs-directory "me/extra/ansible.el"))
  (load (concat user-emacs-directory "me/extra/docker.el"))
  (load (concat user-emacs-directory "me/extra/windows.el"))
  (load (concat user-emacs-directory "me/extra/elscreen.el"))
  (load (concat user-emacs-directory "me/extra/frames.el"))
  (load (concat user-emacs-directory "me/extra/ibuffer.el"))
  (load (concat user-emacs-directory "me/extra/aws.el"))
  (load (concat user-emacs-directory "me/extra/git.el"))

  (me/setup-elscreen)
  ;; (me/bg-black)
  (me/font-small)

  (select-frame (make-frame))
  (me/setup-elscreen-alternative-for-domain)
  )

(defun me/load-unsafe-for-domain ()
  (interactive)
  (me/load-unsafe)
  (me/mac-fonts)
  (me/mac-load-PATH)
  (me/setup-elscreen)
  (me/setup-frames)
  (me/setup-elscreen-alternative-for-domain)
  (me/font-small)
  )

(custom-set-variables
 '(grep-find-command
   "find . -type f ! -path '*/lib/*' ! -path './.git/*' ! -path './.venv/*' ! -path '*/node_modules/*'  ! -path '*/serve/*' ! -path '*/coverage/*' -exec grep  -nH -i -e {} +")
)

(provide 'me/init)
;;; init ends here
