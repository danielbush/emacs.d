;;; extra/macosx -- stuff
;;; Commentary:
;;; Code:

(defun me/mac-load-PATH ()
  "Add /usr/local/bin to path for EMACS.

I used home brew to install EMACS and ag.
ag lives in /usr/local/bin.
Run this to ensure helm can access /usr/local/bin."
  (interactive)

  ;; I think this is already there.
  ;; It will mess up node setenv if it runs.
  ;(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))

  ;(setq exec-path (append exec-path '("/usr/local/bin")))
  (setq exec-path (append '("/usr/local/bin") exec-path))
  )


(defun me/copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun me/paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(defun me/load-mac-paste-copy ()
  "Not sure we need this.

See: http://emacs.stackexchange.com/questions/10900/copy-text-from-emacs-to-os-x-clipboard ."
  (interactive)
  (setq interprogram-cut-function 'me/paste-to-osx)
  (setq interprogram-paste-function 'me/copy-from-osx))

(provide 'extra/macosx)
;;; macosx.el ends here
