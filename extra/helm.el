;;; package --- some node cli utilities
;;; Commentary:
;;; Code:

(require 'cl)

(defun me/helm-interactive-example (candidate)
  "Using helm-comp-read with a list.  CANDIDATE is passed to us courtesy of (interactive)."
  (interactive
   (progn
     (list
      (helm-comp-read
       "prompt: "
       '("abc def" "123 456")
       :buffer "*me/helm/switch-projects*"
       :persistent-action (lambda (candidate) (message "here!"))
       :fuzzy t
       )))
   )
  (message (format "you're candidate is %s" candidate)))

(defun me/do-helm (&rest cl-keys)
  "Do helm-comp-read to do helm.

CL-KEYS is required by cl--parsing-keywords.
This seems to be the best way to call helm."
  (cl--parsing-keywords
      ((:list-fn (lambda () nil))
       (:action-fn (lambda (candidate) (message (format "stub action for %s" candidate)))))
      nil
    (let ((candidate
           (helm-comp-read
            "prompt: "
            (funcall cl-list-fn)
            :buffer "*me/helm*"
            :persistent-action (lambda (candidate) (message "here!"))
            :fuzzy t
            )))
      (funcall cl-action-fn candidate)
      )))


(defun me/helm/switch-projects ()
  "I'm keeping this just as reference in case I need to use the 'helm' form."
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

(defun me/helm/switch-projects ()
  "Even better version."
  (interactive)
  (me/do-helm
   :action-fn (lambda (file)
                (message (concat "selected " (princ file)))
                (find-file (concat "~/projects/" file)))
   :list-fn (lambda ()
              (append (directory-files "~/projects" nil ".")))
   ))

(defun me/helm/switch-notes ()
  "Even better version."
  (interactive)
  (me/do-helm
   :action-fn (lambda (file)
                (message (concat "selected " (princ file)))
                (find-file (concat "~/notes/" file)))
   :list-fn (lambda ()
              (append (directory-files "~/notes" nil ".")))
   ))

(defun me/helm/switch-logs ()
  "Even better version."
  (interactive)
  (me/do-helm
   :action-fn (lambda (file)
                (message (concat "selected " (princ file)))
                (find-file file))
   :list-fn (lambda ()
              (append
               (split-string
                (shell-command-to-string
                 (concat
                  "find -L $HOME/projects -maxdepth 3 -type d | grep -v '/\.git' | grep -v node_modules"
                  ;"find -L $HOME/projects -maxdepth 3 -printf \"%p\n\" | grep -v '/\.git'"
                  ;"find -L . -type f -path \"" pattern "\" -printf \"%P\n\""
                  ;"find -L . -type f -name \"" pattern "\" -printf \"%P\n\""
                  ;"find -L . -type f -name \"" pattern "\""
                  )))))
   ))

(defun me/helm-ag/find-file ()
  "Use ag to search on filenames (not contents)."
  (interactive)
  (me/do-helm
   :action-fn (lambda (file)
                (message (concat "selected " (princ file)))
                (find-file file))
   :list-fn (lambda ()
              (append
               (split-string
                (shell-command-to-string (concat "ag -l -G . ." ))))))
  )

(provide 'me/helm)
;;; helm.el ends here
