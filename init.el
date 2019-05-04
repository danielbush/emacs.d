;;; init.el --- inner init.el file to be used by .emacs.d/init.el
;;; 
;;; Commentary:
;;; Assumes we're in ~/.emacs.d/me
;;; Add this line to ~/.emacs.d/init.el at the bottom:
;;;   (load (concat user-emacs-directory "me/init.el"))
;;; 
;;; Code:

;; This should hopefully load, if not fix.
;; Use M-x me/package-install-my-packages to install my preferred packages.


(add-to-list 'load-path "~/.emacs.d/me")

(require 'packages)

(defun me/load-unsafe ()
  "Stuff that may break in a new EMACS."
  (interactive)
  (server-start)
  (require 'settings)
  (require 'bindings)
  (require 'extra/macosx)
  (require 'extra/helm)
  (require 'extra/utils)
  (require 'extra/find-grep)
  (require 'extra/node)
  ;; (require 'extra/tern)
  (require 'extra/python)
  (require 'extra/terraform)
  (require 'extra/ansible)
  (require 'extra/docker)
  (require 'extra/windows)
  (require 'extra/elscreen)
  (require 'extra/frames)
  (require 'extra/ibuffer)
  (require 'extra/aws)
  (require 'extra/git)
  (require 'extra/dumb-jump)
  (require 'extra/hs)


  ;; (select-frame (make-frame))
  ;; (me/setup-elscreen-alternative-for-domain)
  ;; (me/bg-dark)
  (me/setup-frames)
  )

(defun me/load-unsafe-for-domain ()
  (interactive)
  (me/load-unsafe)
  (me/mac-fonts)
  (me/mac-load-PATH)
  (select-frame-by-name "3")
  (me/setup-elscreen-alternative-for-domain)
  (me/font-med)
  ;; (me/font-small)
  )

(provide 'init)
;;; init ends here
