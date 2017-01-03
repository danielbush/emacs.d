;;; package --- some node cli utilities
;;; Commentary:
;;; Code:
(require 'projectile)
(require 'me/utils (concat default-directory "utils.el"))

(defun me/npm (command)
  "Run npm COMMAND and save to a unique buffer."
  (interactive "snpm: ")
  (let* ((buffer-name (me/make-command-buffer-name (concat "npm " command))))
    (async-shell-command (concat "TERM=dumb npm " command) buffer-name)))

(defun me/npm/run (command)
  "Run npm run COMMAND and save to a unique buffer."
  (interactive "snpm run: ")
  (let* ((buffer-name (me/make-command-buffer-name (concat "npm run " command))))
    (async-shell-command (concat "TERM=dumb npm run " command) buffer-name)))

(defun me/npm/run/test ()
  "Run npm test and save to a unique buffer."
  (interactive)
  (let* ((buffer-name (me/make-command-buffer-name "npm run test")))
    (async-shell-command "TERM=dumb npm run test | sed -e 's/\\\[0G//g'" buffer-name)))

(provide 'me/node)
;;; node.el ends here
