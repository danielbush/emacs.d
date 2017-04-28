;;; package --- some node cli utilities
;;; Commentary:
;;; Code:
(require 'projectile)
(require 'me/utils (concat default-directory "utils.el"))

;(defvar me/node-cmd "~/.nvm/versions/node/v6.9.4/bin/node" )
(defvar me/node-cmd "~/.nvm/versions/node/v7.8.0/bin/node" )
;(defvar me/node-cmd "node" )

;(defvar me/npm-cmd "~/.nvm/versions/node/v6.9.4/bin/npm" )
(defvar me/npm-cmd "~/.nvm/versions/node/v7.8.0/bin/npm" )
;(defvar me/npm-cmd "npm" )

(defvar me/yarn-cmd "yarn" )
(defvar me/node6-path "~/.nvm/versions/node/v6.9.4/bin" )
(defvar me/node7-path "~/.nvm/versions/node/v7.8.0/bin" )
(defvar me/node/orig-exec-path exec-path)
(defvar me/node/orig-PATH (getenv "PATH"))

;(setenv "PATH" "~/.nvm/versions/node/v6.9.4/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin")
(setenv "PATH" (format "%s:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin" me/node7-path ))
(setq exec-path (append '(me/node7-path) exec-path))


(defun me/npm (command)
  "Run npm COMMAND and save to a unique buffer."
  (interactive "snpm: ")
  (let* ((buffer-name (me/make-command-buffer-name (concat "npm " command))))
    (async-shell-command (concat "TERM=xterm " me/npm-cmd " " command) buffer-name)
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
    (async-shell-command (format "TERM=xterm %s %s run test" me/node-cmd me/npm-cmd) buffer-name)
    ;(me/tidy-up-after-finish buffer-name)
    ))

(defun me/projectile-run-yarn (command)
  "Run yarn in projectile root.

COMMAND is a shell command string."
  (let* ((buffer-name (me/make-command-buffer-name
                       (format "yarn %s %s" (nth 0 (split-string command)) (nth 1 (split-string command)))))
         (root (ignore-errors (projectile-project-root))) )
    (with-temp-buffer
      (if root
          (progn
            (cd root)
            (async-shell-command (concat "TERM=xterm " me/yarn-cmd " " command) buffer-name) )
        (message "Can't find project root.") ))))

(defun me/yarn (command)
  "Run yarn COMMAND and save to a unique buffer."
  (interactive "syarn: ")
  (me/projectile-run-yarn command) )

(defun me/yarn/run (command)
  "Run yarn run COMMAND and save to a unique buffer."
  (interactive "syarn run: ")
  (me/projectile-run-yarn (concat "run " command)) )


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

(defun me/shell-run-this-file ()
  (interactive)
  (let ((cmd (format "%s %s" "bash" (me/this-file))))
    (async-shell-command  cmd (format "*bash-%s*" cmd))
    ))

(defun me/node-run-this-file ()
  (interactive)
  (async-shell-command (format "%s %s" me/node-cmd (me/this-file)))
  )

;; From http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable .
;; Because of https://github.com/eslint/eslint/issues/1238 .

(require 'flycheck)
(require 'flycheck-flow)

(defun me/flycheck-flow ()
  "Set up flycheck-flow in addition to eslint and also register it for rjsx-mode.

flycheck-add-next-checker is a mystery - works for me if I set eslint to run after it, BOTH checkers will work.
But I suspect this will break again.
See https://github.com/lbolla/emacs-flycheck-flow/blob/master/flycheck-flow.el .
flycheck-flow uses 'flow check-contents' - see this issue: https://github.com/facebook/flow/issues/2235. "

  (interactive)
  (flycheck-add-mode 'javascript-flow 'rjsx-mode)
  (flycheck-add-mode 'javascript-flow 'web-mode)
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (flycheck-add-next-checker 'javascript-flow 'javascript-eslint )
  )


(defun me/use-eslint-from-node-modules ()
  "Use locally (npm) installed eslint so that we can use eslintConfig in package.json."
  (message "running eslint hook")
  (let* ((root (locate-dominating-file (or (buffer-file-name) default-directory) "node_modules"))
         (eslint (and root (expand-file-name "node_modules/eslint/bin/eslint.js" root))))
    (message eslint)
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))

(defun me/use-script-from-node-modules (node_modules_path)
  "Use locally (npm) installed script so that we can use script.

NODE_MODULES_PATH example: node_modules/eslint/bin/eslint.js."
  (let* ((root (locate-dominating-file (or (buffer-file-name) default-directory) "node_modules"))
         (script (and root (expand-file-name node_modules_path root))))
    (message script)
    (when (and script (file-executable-p script))
      (setq-local flycheck-javascript-flow-executable script))))

(add-hook 'flycheck-mode-hook #'me/use-eslint-from-node-modules)
(add-hook 'flycheck-mode-hook #'(lambda () (me/use-script-from-node-modules "node_modules/.bin/flow")))


(provide 'me/node)
;;; node.el ends here
