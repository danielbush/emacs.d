
;;; Commentary:

;;; Code:

(defun me/terraform-test ()
  "So I can test stuff."
  (interactive)
  (message (me/terraform-get-dir))
  )

(defun me/terraform-get-dir ()
  "Return nil or directory containing your nearest local friendly terraform.tfstate."
  (projectile-locate-dominating-file (or (buffer-file-name) default-directory) "terraform.tfstate")
  )

(defun me/terraform-plan ()
  "Run terraform plan."
  (interactive)
  (me/with-terraform-dir "terraform plan"))

(defun me/terraform-get ()
  "Run terraform get."
  (interactive)
  (me/with-terraform-dir "terraform get"))

(defun me/terraform-apply ()
  "Run terraform apply."
  (interactive)
  (me/with-terraform-dir "terraform apply"))

(defun me/terraform-cmd (cmd)
  "Run terraform CMD."
  (interactive "sterraform ")
  (me/with-terraform-dir (format "terraform %s" cmd)))

(defun me/with-terraform-dir (cmd-string)
  "Find dir with terraform.tfstate and run CMD-STRING in a shell there."
  (let ((dir (me/terraform-get-dir)))
    (if dir
        (async-shell-command
         (format "cd %s && echo '*** tfstate home: %s' && %s" dir dir cmd-string)
         (format "*%s*" cmd-string))
      (message "Couldn't find a tfstate."))
    )
  )

(provide 'terraform)
;;; terraform.el ends here
