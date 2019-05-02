
(defun me/magit-log-for-paths-BAD ()
  (interactive)
  (let ((paths (read-string "Files or directories: ")))
    ;; (apply 'magit-log nil "--" (split-string paths))
    (apply 'magit-log nil '() (list default-directory))
    ))

(defun me/magit-log-for-paths ()
  (interactive)
  (async-shell-command "git log -p . | cat" "*git file log*")
  ;; (other-window 1)
  ;; (switch-to-buffer "*git file log*")
  ;; (diff-mode)
  )

(defun me/magit-log-for-paths ()
  (interactive)
  (async-shell-command "git log -p . | cat" "*git file log*")
  (sleep-for 0.5)
  (with-current-buffer "*git file log*"
    (funcall 'diff-mode))
  )

(provide 'extra/git)
;;; git.el ends here
