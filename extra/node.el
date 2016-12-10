;;; package --- some node cli utilities
;;; Commentary:
;;; Code:
(require 'projectile)
(require 'me/utils (concat default-directory "utils.el"))

(defun me/npm/run (command)
  "Run npm run COMMAND and save to a unique buffer."
  (interactive "snpm run: ")
  (let* ((buffer-name (me/make-command-buffer-name (concat "npm run " command))))
    (async-shell-command (concat "TERM=xterm npm run " command) buffer-name)))

(defun me/npm/run/test ()
  "Run npm test and save to a unique buffer."
  (interactive)
  (let* ((buffer-name (me/make-command-buffer-name "npm run test")))
    (async-shell-command "TERM=xterm npm run test" buffer-name)))

(defun me/npm/run/build ()
  "Run npm run build and save to a unique buffer."
  (interactive)
  (let* ((buffer-name (me/make-command-buffer-name "npm run build")))
    (async-shell-command "TERM=xterm npm run build" buffer-name)))

(provide 'me/node)
;;; node.el ends here
