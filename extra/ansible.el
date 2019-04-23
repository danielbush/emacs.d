
;; You may need something like this to set ansible depending on where it is:
;;
;;   (setenv "PATH"
;;       (concat
;;         (concat (projectile-project-root) ".venv/bin")
;;         ":"
;;         (getenv "PATH")
;;       ))

(defun me/ansible-test ()
  (interactive)
  (message (me/ansible-get-playbooks))
  )

(defun me/ansible-get-playbooks ()
  (projectile-locate-dominating-file (or (buffer-file-name) default-directory) "playbooks")
  )

(defun me/ansible-playbook (cmd-string)
  "Assumes: You set inventory with -i."
  (interactive "sansible-playbook ")
  (let ((dir (me/ansible-get-playbooks)))
    (if dir
        (async-shell-command
         (format "cd %s && ansible-playbook %s" dir cmd-string) "*ansible-playbook*")
      (message "Could not find playbooks/ dir."))
    )
  )

(provide 'me/ansible)
;;; ansible.el ends here
