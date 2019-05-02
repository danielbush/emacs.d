;;; package --- some node cli utilities
;;; Commentary:
;;; Code:
(require 'extra/utils)

(defcustom me/aws-cli "/home/danb/venv/aws/bin/aws" "Path to aws cli." :group 'me/aws)

(defun me/aws (cmd)
  (interactive "saws ")
  (async-shell-command
   (format "%s %s | cat" me/aws-cli cmd)
   (me/make-command-buffer-name (format "aws %s" cmd)))
  )

(provide 'extra/aws)
;;; aws.el ends here
