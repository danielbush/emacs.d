;;; package --- some node cli utilities
;;; Commentary:
;;; Code:

(defun me/helm/switch-projects ()
  "Better version."
  (interactive)
  (helm :sources
        `((name . "projects: ")
          (candidates . ,(append (directory-files "~/projects" nil ".")))
          (action . (lambda (file)
                      (message (concat "selected " (princ file)))
                      (find-file (concat "~/projects/" file))))
          (keymap keymap
                  ,(let ((map (make-sparse-keymap)))
                     (define-key map (kbd "C-g") 'helm-keyboard-quit)
                     (define-key map (kbd "C-n") 'helm-next-line)
                     (define-key map (kbd "C-p") 'helm-previous-line)
                     map
                     )
                  )
          ))
  )

(defun me/helm/switch-log ()
  (interactive)
  (helm :sources
        `((name . "log files: ")
          (candidates . ,(append
                          (split-string
                           (shell-command-to-string
                            (concat
                             "find -L $HOME/todos/logs -maxdepth 3 -printf \"%p\n\" | grep -v '/\.git'"
                             ;; "find -L . -type f -path \"" pattern "\" -printf \"%P\n\""
                             ;; "find -L . -type f -name \"" pattern "\" -printf \"%P\n\""
                             ;; "find -L . -type f -name \"" pattern "\""
                             )))))
          (action . (lambda (file)
                      (message (concat "selected " (princ file)))
                      (find-file file)))
          (keymap keymap
                  ,(let ((map (make-sparse-keymap)))
                     (define-key map (kbd "C-g") 'helm-keyboard-quit)
                     (define-key map (kbd "C-n") 'helm-next-line)
                     (define-key map (kbd "C-p") 'helm-previous-line)
                     map
                     )
                  )
          ))
  
  )

(provide 'me/helm)
;;; helm.el ends here
