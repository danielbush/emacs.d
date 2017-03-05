;;; package --- some node cli utilities
;;; Commentary:
;;; Code:
(require 'projectile)
(require 'me/utils (concat default-directory "utils.el"))

;(defvar me/node-cmd "/Users/daniel.bush/.nvm/versions/node/v6.9.4/bin/node" )
(defvar me/node-cmd "node" )

;(defvar me/npm-cmd "/Users/daniel.bush/.nvm/versions/node/v6.9.4/bin/npm" )
(defvar me/npm-cmd "npm" )

(setenv "PATH" "/Users/daniel.bush/.nvm/versions/node/v6.9.4/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin")


(defun me/npm (command)
  "Run npm COMMAND and save to a unique buffer."
  (interactive "snpm: ")
  (let* ((buffer-name (me/make-command-buffer-name (concat "npm " command))))
    (async-shell-command (concat "TERM=dumb " me/npm-cmd " " command) buffer-name)
    ;(me/tidy-up-after-finish buffer-name)
    ))

(defun me/npm/run (command)
  "Run npm run COMMAND and save to a unique buffer."
  (interactive "snpm run: ")
  (let* ((buffer-name (me/make-command-buffer-name (concat "npm run " command))))
    (async-shell-command (concat "TERM=xterm " me/npm-cmd " run " command) buffer-name)
    ;(message (concat "TERM=xterm " me/npm-cmd " run " command))
    ;(me/tidy-up-after-finish buffer-name)
    ))

(defun me/npm/run/test ()
  "Run npm test and save to a unique buffer."
  (interactive)
  (let* ((buffer-name (me/make-command-buffer-name "npm run test")))
    (async-shell-command (concat "TERM=xterm " me/npm-cmd " run test") buffer-name)
    ;(me/tidy-up-after-finish buffer-name)
    ))

(defun me/tidy-up-after-finish (buffer-name)
  (me/do-thing-after-buffer-process
   buffer-name
   (lambda ()
     (message (format "Running tidy up because process has stopped."))
     (me/npm/tidy-up-buffer-escape-chars buffer-name)
     )))

(defun me/do-thing-after-buffer-process (buffer-name do-thing &optional -at-time)
  "Run do-thing lambda once a get-buffer-process indicates no more process is running on buffer.

Motivation: cleaning up escape chars after running npm run test and related."
  (let ((at-time (if -at-time -at-time 0)))
    (run-at-time at-time nil
                 (lambda (buffer-name do-thing at-time)
                   (if (not (get-buffer-process buffer-name))
                       (funcall do-thing)
                     (if (> at-time 20)
                         (progn
                           (message "Not calling run-at-time anymore, exceeded time limit."))
                       (me/do-thing-after-buffer-process buffer-name do-thing (+ at-time 0.5)) )
                     )) buffer-name do-thing at-time)))

(defun me/npm/tidy-up-buffer-escape-chars (&optional -buffer-name)
  (interactive)
  (let ((buffer-name (if -buffer-name -buffer-name (buffer-name))))
    (with-current-buffer buffer-name
      (replace-string "[0G" "" nil (point-min) (point-max))
      (replace-string "" "" nil (point-min) (point-max))
      )
    )
  )

;;
(defun me/dumbify-node-shell-output ()
  "See http://stackoverflow.com/questions/13185729/npm-dont-display-prompt-correctly-under-emacs-eshell ."
  (interactive)
  (add-to-list
   'comint-preoutput-filter-functions
   (lambda (output)
     (replace-regexp-in-string "\\[[0-9]+[GKJ]" "" output)))
  )

(defvar me/node "node")

(defun me/node-run-this-file ()
  (interactive)
  (async-shell-command (format "%s %s" me/node (me/this-file)))
  )

;; From http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable .
;; Because of https://github.com/eslint/eslint/issues/1238 .

(require 'flycheck)
(defun me/use-eslint-from-node-modules ()
  "Use locally (npm) installed eslint so that we can use eslintConfig in package.json."
  (message "running eslint hook")
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (message eslint)
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))

(add-hook 'flycheck-mode-hook #'me/use-eslint-from-node-modules)


(provide 'me/node)
;;; node.el ends here
