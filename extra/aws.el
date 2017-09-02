;;; package --- some node cli utilities
;;; Commentary:
;;; Code:
(require 'me/utils (concat default-directory "utils.el"))

(defcustom me/aws-cli "/home/danb/venv/aws/bin/aws" "Path to aws cli." :group 'me/aws)

(defun me/aws (cmd)
  (interactive "saws ")
  (async-shell-command
   (format "%s %s | cat" me/aws-cli cmd)
   (me/make-command-buffer-name (format "aws %s" cmd)))
  )

(provide 'me/aws)
;;; aws.el ends here
