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

(provide 'me/utils)
;;; utils.el ends here
