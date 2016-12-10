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

(defun me/this-file ()
  "Print path of current file or directory and put in kill ring."
  (interactive)
  (let* ((filename (or (buffer-file-name) default-directory)))
    (kill-new filename)
    (message filename)
    filename ))

(defun me/command (command)
  "Run COMMAND with TERM=xterm and save to a unique buffer."
  (interactive "sCommand: ")
  (let* ((buffer-name (me/make-command-buffer-name command)))
    (async-shell-command (concat "TERM=xterm " command) buffer-name)))

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


(provide 'me/utils)
;;; utils.el ends here
