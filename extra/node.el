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
    (async-shell-command (concat "TERM=xterm npm run " command) buffer-name) ))

(defun me/npm/run/test ()
  "Run npm test and save to a unique buffer."
  (interactive)
  (let* ((buffer-name (me/make-command-buffer-name "npm run test")))
    ;(async-shell-command "TERM=xterm npm run test | sed -e 's/\\\[0G//g'" buffer-name)
    (async-shell-command "TERM=xterm npm run test" buffer-name)
    ;(start-process "npm run test" buffer-name "npm" "run" "test")
    (dotimes (i 6)
      (1+ i) (run-at-time i nil
                          `(lambda ()
                             (progn
                               (message (format "running tidy up with i=%s" ,i))
                               (me/npm/tidy-up-buffer-escape-chars ,buffer-name)))))
    ))

(defun waith-for-process-to-finish ()
  (interactive)
  (catch 'break
      (while t
        (if (get-buffer-process buffer-name)
            (sleep-for 0.5)
          (progn (message "here!!!") (throw 'break nil)))))
)

(defun me/npm/tidy-up-buffer-escape-chars (&optional buffer-name)
  (interactive)
  (let ((buffer-nm (if buffer-name buffer-name (buffer-name))))
    (with-current-buffer buffer-nm
      (replace-string "[0G" "" nil (point-min) (point-max))
      (replace-string "" "" nil (point-min) (point-max))
      )
    )
  )

(provide 'me/node)
;;; node.el ends here
