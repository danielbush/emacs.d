;;; extra/find-grep.el -- projectile find-grep and related
;;; Commentary:
;;; Code:

(require 'projectile)

(defun me/-find-grep-cmd (search ignore-case)
  "SEARCH IGNORE-CASE."
  (format
   (concat
    "find . -type f "
    "! -path './lib/*' " ;; top-level
    "! -path './2br-*lib/*' "
    "! -path '*build/*' " ;; any level
    "! -path '*serve/*' "
    "! -path '*test/e2e/report*' "
    "! -path '*.git/*' "
    "! -path '*.venv/*' "
    "! -path '*.nyc_output/*' "
    "! -path '*node_modules/*' "
    "! -path '*package-lock.json*' "
    "! -path '*yarn.lock*' "
    "! -path './coverage/*' "
    "-exec egrep %s -nH -e \"%s\" {} +"
    )
   (if ignore-case "-i" "")
   search
   )
  )

(ignore
 (custom-set-variables
  '(grep-find-command
    "find . -type f ! -path '*/lib/*' ! -path './.git/*' ! -path './.venv/*' ! -path '*/node_modules/*'  ! -path '*/serve/*' ! -path '*/coverage/*' -exec grep  -nH -i -e {} +")
  )

 ;; "find . ! -name \"*~\" ! -name \"#*#\" -type f -print0 | xargs -0 -e grep -nH -e "
 )


(grep-apply-setting 'grep-find-command (me/-find-grep-cmd "" nil))


;;; --------------------------------------------------------------------------------
;;; For reading user search input.

(defun me/-find-grep-read ()
  "This seems like a good way to read from minibuffer."
  (read-from-minibuffer "Search: " nil nil nil
                        'minibuffer-history
                        (or (thing-at-point 'word) "") ;; M-n to produce it
                        )
  )

(defun me/-find-grep-read-helm (buffer-name)
  "Helm way to read from minibuffer, but I had issues with with search inputs that used [ etc."
  (helm-comp-read
   "Search: "
   minibuffer-history
   :initial-input (thing-at-point 'symbol)
   :buffer buffer-name
   )
  )

;;; --------------------------------------------------------------------------------
;;; me/-find-grep and me/-projectile-find-grep

(defun me/-find-grep (search &optional ignore-case)
  (find-grep
   (me/-find-grep-cmd search ignore-case)))

(defun me/-projectile-find-grep (search &optional ignore-case)
  (cd (projectile-project-root))
  (find-grep
   (me/-find-grep-cmd search ignore-case))
  (if (get-buffer "*grep*")
      (progn
        (message "here")
        (with-current-buffer "*grep*"
          (let ((name (concat  "*grep:" search "*")))
            (if (get-buffer name) (kill-buffer name))
            (rename-buffer name))
          )
        )
    )

  )

;;; --------------------------------------------------------------------------------
;;; Interface

(defun me/find-grep ()
  "Use C-c C-y to copy existing candidate into minibuffer if you want to modify it."
  (interactive)
  (let (
        (search (me/-find-grep-read))
        ;; (search (me/-find-grep-read-helm "*me/helm/find-grep*"))
        )
    (me/-find-grep search))
  )

(defun me/find-igrep ()
  "Use C-c C-y to copy existing candidate into minibuffer if you want to modify it."
  (interactive)
  (let ((search (me/-find-grep-read)))
    (me/-find-grep search t))
)

(defun me/projectile-find-grep ()
  "Use C-c C-y to copy existing candidate into minibuffer if you want to modify it."
  (interactive)
  (let ((search (me/-find-grep-read)))
    (me/-projectile-find-grep search))
)

(defun me/projectile-find-igrep ()
  "Use C-c C-y to copy existing candidate into minibuffer if you want to modify it."
  (interactive)
  (let ((search (me/-find-grep-read)))
    (me/-projectile-find-grep search t))
  )

;;; Experiments

(defun me/projectile-find-grep--read-string (search)
  (interactive (list (read-string "Search: " (thing-at-point 'symbol))))
  (me/-projectile-find-grep search)
)

(provide 'extra/find-grep)
;;; find-grep.el ends here
