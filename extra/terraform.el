
;;; Commentary:

;;; Code:

(defun me/tf-test ()
  "So I can test stuff."
  (interactive)
  (message (me/tf-get-dir))
  )

(defun me/tf-get-dir ()
  "Return nil or directory containing your nearest local friendly terraform.tfstate."
  (projectile-locate-dominating-file (or (buffer-file-name) default-directory) "terraform.tfstate")
  )

(defun me/tf-plan ()
  "Run terraform plan."
  (interactive)
  (me/with-tf-dir "terraform plan"))

(defun me/tf-get ()
  "Run terraform get."
  (interactive)
  (me/with-tf-dir "terraform get"))

(defun me/tf-apply ()
  "Run terraform apply."
  (interactive)
  (me/with-tf-dir "terraform apply"))

(defun me/tf-state (cmd)
  "Run terraform state CMD."
  (interactive "sterraform state ")
  (me/with-tf-dir (format "terraform state %s" cmd)))

(defun me/tf-state-list ()
  "Run terraform state list."
  (interactive)
  (me/with-tf-dir "terraform state list"))

(defun me/tf-cmd (cmd)
  "Run terraform CMD."
  (interactive "sterraform ")
  (me/with-tf-dir (format "terraform %s" cmd)))

(defun me/with-tf-dir (cmd-string)
  "Find dir with terraform.tfstate and run CMD-STRING in a shell there."
  (let ((dir (me/tf-get-dir)))
    (if dir
        (async-shell-command
         (format "cd %s && echo '*** tfstate home: %s' && %s" dir dir cmd-string)
         (format "*%s*" cmd-string))
      (message "Couldn't find a tfstate."))
    )
  )

(provide 'terraform)
;;; terraform.el ends here
