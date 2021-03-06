;;; package --- some node cli utilities
;;; Commentary:
;;; Code:

(require 'projectile)
(require 'thingatpt)
(require 'extra/helm)

; https://www.emacswiki.org/emacs/ElispCookbook#toc6
(defun me/chomp (str)
  "Chomp leading and tailing whitespace from STR."
  (replace-regexp-in-string (rx (or (: bos (* (any " \t\n")))
                                    (: (* (any " \t\n")) eos)))
                            ""
                            str))

(defun me/this-dir ()
  (interactive)
  (let* ((filename default-directory)
     ;; (file-name-directory (buffer-file-name))
         )
     (kill-new filename)
     (message filename)
     filename )
  )

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

(defun me/command-this-file (args)
  (interactive "sArgs for command: ")
  (let* (
         (script-name (file-name-nondirectory (buffer-file-name)))
         (buffer-name (me/make-command-buffer-name script-name))
         )
    (async-shell-command (format "TERM=dumb ./%s %s" script-name args) buffer-name))
  )
(defun me/command-dired-this-file (args)
  (interactive "sArgs for command: ")
  (let* (
         (script-name (thing-at-point 'filename))
         (buffer-name (me/make-command-buffer-name script-name))
         )
    (async-shell-command (format "TERM=dumb ./%s %s" script-name args) buffer-name))
  )


(defvar me/run-command-helm-file-projectile-last "")
(defun me/run-command-helm-file-projectile ()
  (interactive)
  (if (projectile-project-root)
      (me/do-helm
       :initial-input me/run-command-helm-file-projectile-last
       :action-fn (lambda (file-name)
                    (let* (
                           (args (read-from-minibuffer "Args: "))
                           ;; (script-name (file-name-nondirectory file-name))
                           (script-name file-name)
                           (buffer-name (me/make-command-buffer-name (concat script-name " " args)))
                           (cmd (format "TERM=dumb cd %s && %s %s" (file-name-directory script-name) script-name args))
                           )
                      (setq me/run-command-helm-file-projectile-last script-name)
                      (message cmd)
                      (async-shell-command cmd buffer-name)
                      ))
       :list-fn (lambda ()
                  (append
                   (split-string
                    (shell-command-to-string
                     (format
                      "find -L %s -type f -executable | egrep -v '/\.git|venv|node_modules'" (projectile-project-root)
                      )))))
       )
    (message "you fail")
    )
  
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

(provide 'extra/utils)
;;; utils.el ends here
