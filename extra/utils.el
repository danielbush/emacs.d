;;; package --- some node cli utilities
;;; Commentary:
;;; Code:

(require 'projectile)

; https://www.emacswiki.org/emacs/ElispCookbook#toc6
(defun me/chomp (str)
  "Chomp leading and tailing whitespace from STR."
  (replace-regexp-in-string (rx (or (: bos (* (any " \t\n")))
                                    (: (* (any " \t\n")) eos)))
                            ""
                            str))

(defun me/this-dir ()
  (interactive)
  (let* ((filename (file-name-directory (buffer-file-name))))
    (kill-new filename)
    (message filename)
    filename ))

(defun me/this-file ()
  "Print path of current file or directory and put in kill ring."
  (interactive)
  (let* ((filename (or (buffer-file-name) default-directory)))
    (kill-new filename)
    (message filename)
    filename ))

(defun me/command (command)
  "Run COMMAND with TERM env variable and save to a unique buffer."
  (interactive "sCommand: ")
  (let* ((buffer-name (me/make-command-buffer-name command)))
    (async-shell-command (concat "TERM=dumb " command) buffer-name)))

(defun me/command-at-point (args)
  (interactive "sArgs for command: ")
  (let* (
        (script-name (thing-at-point 'filename))
        (buffer-name (me/make-command-buffer-name script-name))
        )
    (async-shell-command (format "TERM=dumb ./%s %s" script-name args) buffer-name)))
    )
)

(defun me/command-this-file (args)
  (interactive "sArgs for command: ")
  (let* (
         (script-name (file-name-nondirectory (buffer-file-name)))
         (buffer-name (me/make-command-buffer-name script-name))
         )
    (async-shell-command (format "TERM=dumb ./%s %s" script-name args) buffer-name))
  )

(defun me/make-command-buffer-name (command)
  "Get project-root for use as name when running COMMAND..

Works well if you also set 'async-shell-command' to replace existing
buffer (to prevent buffer proliferation)."

  (let* ((project-root (or (ignore-errors (projectile-project-root))
                           default-directory))
         (buffer-name
          (if project-root (concat "*command "
                                   command " in " project-root "*")
            (concat "*command* " command))))
    buffer-name))

(defun me/shell-in-dir ()
  "Run m-x shell in current buffer and rename appropriately."
  (interactive)
  (let* ((file (me/this-file)))
    (shell)
    (rename-buffer (concat "*shell " file "*")) ))

(defun me/is-dedicated ()
  (interactive)
  (if (window-dedicated-p (get-buffer-window))
      (message "Dedicated.")
    (message "NOT dedicated.")))

(defun me/toggle-dedicated-window ()
  (interactive)
  (let ((will-dedicate (not (window-dedicated-p (get-buffer-window)))))
    (set-window-dedicated-p (get-buffer-window) will-dedicate)
    (message (format "%sDedicating this window" (if will-dedicate "" "NOT ")))
    ))

(defun me/dedicate ()
  (interactive)
  (set-window-dedicated-p (get-buffer-window) t))

(defun me/undedicate ()
  (interactive)
  (set-window-dedicated-p (get-buffer-window) nil))

(grep-apply-setting
 'grep-find-command
 "find . -type f ! -path './.git/*' ! -path './.venv/*' ! -path './node_modules/*'  ! -path './serve/*' ! -path './coverage/*' -exec grep  -nH -e {} +"
 ;; "find . ! -name \"*~\" ! -name \"#*#\" -type f -print0 | xargs -0 -e grep -nH -e "
 )

(provide 'me/utils)
;;; utils.el ends here
