;;; package --- some node cli utilities
;;; Commentary:
;;; Code:
(require 's)
(require 'projectile)
(require 'me/utils (concat default-directory "utils.el"))

(defconst me/node/orig-exec-path exec-path)
(defconst me/node/orig-PATH (getenv "PATH"))
(defcustom me/node-versions '("6.9.4" "7.10.1" "8.8.1" "8.9.0") "List of node versions.")
;; (defcustom me/node-versions '("8.1.3" "8.9.1") "List of node versions.")
(defcustom me/nvm-home "/Users/daniel.bush/.nvm" "Path to .nvm.  ~/.nvm may not work." :group 'me/node)
(defcustom me/yarn-redirect-toggle nil "Wether to always redirect generae me/yarn(/*) commands." :group 'me/node)

(defun me/nvm-cmd-string (cmdString)
  (format "TERM=xterm sh -c '. %s/nvm.sh; nvm %s'" me/nvm-home cmdString)
  )

(defun me/nvm (cmd)
  (interactive "snvm ")
  (async-shell-command
   (me/nvm-cmd-string cmd)
   (me/make-command-buffer-name (format "nvm %s" cmd)))
  )

;; (defvar me/node-cmd "~/.nvm/versions/node/v6.9.4/bin/node" )
;; (defvar me/node-cmd "~/.nvm/versions/node/v7.8.0/bin/node" )
;; (defvar me/node-cmd "/home/danb/.nvm/versions/node/v8.1.3/bin/node" )
(defvar me/node-cmd "node")

;; (defvar me/npm-cmd "~/.nvm/versions/node/v6.9.4/bin/npm" )
;; (defvar me/npm-cmd "~/.nvm/versions/node/v7.8.0/bin/npm" )
;; (defvar me/npm-cmd "/home/danb/.nvm/versions/node/v8.1.3/bin/npm" )
(defvar me/npm-cmd "npm")

;; (defvar me/yarn-cmd "~/.nvm/versions/node/v7.8.0/bin/yarn")
;; (defvar me/yarn-cmd "/home/danb/.nvm/versions/node/v8.1.3/bin/yarn")
(defvar me/yarn-cmd "npm")

(defvar me/node-path "/usr/local/bin")

(defun me/node/set-path ()
  (interactive)
  (setenv "PATH" (format "%s:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin" me/node-path))
  (setq exec-path (append `(,me/node-path) exec-path))
  )

(defun me/select-node-version ()
  (interactive)
  (me/do-helm
   :action-fn
   (lambda (node-version)
     (message node-version)
     (let ((nvm-bin (format "%s/versions/node/v%s/bin" me/nvm-home node-version)))
       (setq me/node-path (format "%s" nvm-bin))
       (setq me/node-cmd (format "%s/node" nvm-bin))
       (setq me/npm-cmd (format "%s/npm" nvm-bin))
       (setq me/yarn-cmd (format "%s/yarn" nvm-bin))
       (me/node/set-path)
       ))
   :list-fn (lambda () me/node-versions))
  )

(defun me/npm-root ()
  (or
   (locate-dominating-file default-directory "node_modules")
   ;; If node_modules/ not checked in
   (locate-dominating-file default-directory ".git")
   )
)


(defun me/make-npm-command-buffer-name (command)
  "Get project-root for use as name when running COMMAND..

Works well if you also set 'async-shell-command' to replace existing
buffer (to prevent buffer proliferation)."

  (let* ((root (me/npm-root))
         (buffer-name (if root (concat "*command " command " in " root "*")
            (concat "*command* " command))))
    buffer-name))

(defun me/npm (command)
  "Run npm COMMAND and save to a unique buffer."
  (interactive "snpm: ")
  (let* ((buffer-name (me/make-npm-command-buffer-name (concat "npm " command))))
    (async-shell-command (concat "TERM=xterm " me/npm-cmd " " command) buffer-name)
    ;(me/tidy-up-after-finish buffer-name)
    ))



(defun me/npm/publish-prerelease-domain (tag)
  "Run npm publish on a pre-release..."
  (interactive "sDid you set version in package.json [x.y.(z+1)-foo-bar-#issue.n]?  Tag [foo-bar-#issue]: ")
  (let* ((buffer-name (me/make-npm-command-buffer-name (concat "npm publish [prerelease]" tag))))
    (async-shell-command
     (format "TERM=xterm %s publish --tag %s --access restricted"
             me/npm-cmd
             tag)
     buffer-name)
    ))

; This one gives errors, I uses npm version normally.
(defun me/yarn/publish-prerelease-domain (tag)
  "Run yarn publish on a pre-release..."
  (interactive "sDid you set version in package.json [x.y.(z+1)-foo-bar-#issue.n]?  Tag [foo-bar-#issue]: ")
  (let* ((buffer-name (me/make-command-buffer-name (concat "npm publish [prerelease]" tag))))
    (async-shell-command
     (format "TERM=xterm %s publish --tag %s --access restricted"
             "yarn"
             tag)
     buffer-name)
    ))

(defun me/npm/run (command)
  "Run npm run COMMAND and save to a unique buffer."
  (interactive "snpm run: ")
  (let* ((buffer-name (me/make-npm-command-buffer-name (concat "npm run " command))))
    (async-shell-command (concat "TERM=xterm " me/npm-cmd " run " command) buffer-name)
    ;(message (concat "TERM=xterm " me/npm-cmd " run " command))
    ;(me/tidy-up-after-finish buffer-name)
    ))

(defun me/npm/run/test ()
  "Run npm test and save to a unique buffer."
  (interactive)
  (let* ((buffer-name (me/make-npm-command-buffer-name "npm run test")))
    (async-shell-command (format "TERM=xterm %s %s run test" me/node-cmd me/npm-cmd) buffer-name)
    ;(me/tidy-up-after-finish buffer-name)
    ))

(defun me/projectile-run-yarn (command)
  "Run yarn in projectile root.

COMMAND is a shell command string."
  (let* ((buffer-name (me/make-npm-command-buffer-name
                       (format "yarn %s %s" (nth 0 (split-string command)) (nth 1 (split-string command)))))
         ;; (root (ignore-errors (projectile-project-root)))
         (root (me/npm-root))
         )
    (with-temp-buffer
      (if root
          (progn
            (cd root)
            (async-shell-command (concat "TERM=xterm " me/yarn-cmd " " command) buffer-name) )
        (message "Can't find project root.") ))))

(defun me/yarn-no-redirect (command)
  "Run yarn COMMAND and save to a unique buffer."
  ;(interactive "syarn: ")
  (me/projectile-run-yarn command) )

(defun me/yarn-install-with-redirect ()
  (interactive)
  (me/projectile-run-yarn "install --verbose >> /tmp/yarn.log 2>&1")
  (view-file-other-window "/tmp/yarn.log")
  (turn-on-auto-revert-tail-mode)
  )

(defun me/yarn-with-redirect (command)
  "Run me/yarn with COMMAND redirect stdout to a file.

This seems to be a lot less problematic then letting the output go to EMACS."
  ;(interactive "syarn: ")
  (me/projectile-run-yarn (concat command ">> /tmp/yarn.log 2>&1"))
  (view-file-other-window "/tmp/yarn.log")
  (turn-on-auto-revert-tail-mode)
  )

(defun me/yarn/run-no-redirect (command)
  "Run yarn run COMMAND and save to a unique buffer."
  ;(interactive "syarn run: ")
  (me/projectile-run-yarn (concat "run " command)) )

(defun me/yarn/run-with-redirect (command)
  "Run yarn run COMMAND and save to a unique buffer."
  ;(interactive "syarn run: ")
  (me/projectile-run-yarn (concat (concat "run " command) ">> /tmp/yarn.log 2>&1"))
  (view-file-other-window "/tmp/yarn.log")
  (turn-on-auto-revert-tail-mode)
  )

(defun me/yarn/run (command)
  "Run yarn run COMMAND and save to a unique buffer."
  (interactive "syarn run: ")
  (if me/yarn-redirect-toggle
      (me/yarn/run-with-redirect command)
      (me/yarn/run-no-redirect command)
      )
  )

(defun me/yarn (command)
  "Run yarn COMMAND and save to a unique buffer."
  (interactive "syarn: ")
  (if me/yarn-redirect-toggle
      (me/yarn-with-redirect command)
      (me/yarn-no-redirect command)
      )
  )

(defun me/toggle-yarn-redirect ()
  (interactive)
  (setq me/yarn-redirect-toggle (not me/yarn-redirect-toggle))
  (if me/yarn-redirect-toggle
      (message "Redirecting yarn to file.")
    (message "NOT redirecting yarn to file."))
  )

(defun me/yarn-truncate-log ()
  (interactive)
  (shell-command "cat /dev/null >/tmp/yarn.log")
)



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

(defun me/run-this-file ()
  (interactive)
  (let ((cmd (format "%s" (me/this-file))))
    (async-shell-command  cmd (format "*%s*" cmd))
    ))

(defun me/shell-run-this-file ()
  (interactive)
  (let ((cmd (format "%s %s" "bash" (me/this-file))))
    (async-shell-command  cmd (format "*bash-%s*" cmd))
    ))

(defun me/node-run-this-file ()
  (interactive)
  (async-shell-command (format "%s %s" me/node-cmd (me/this-file)))
  )

(defun me/node-run-this-file-with-babel-register ()
  (interactive)
  (let* (
         (filename (buffer-file-name))
         (root (locate-dominating-file filename "node_modules")))
    (with-temp-buffer
      (if root
          (progn
            (async-shell-command (format "cd %s && %s -r @babel/register %s" root me/node-cmd filename)))
        (message "Can't find project root.") ))
    )
  )

;; From http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable .
;; Because of https://github.com/eslint/eslint/issues/1238 .

(require 'flycheck)
(require 'flycheck-flow)

(defun me/kill-all-the-nodes ()
  "May be useful when doing yarn run start because fe-build can be broken."
  (interactive)
  (async-shell-command  "pkill -f node")
  )

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

(defun me/run-with-redirect (cmd)
  "To avoid stupid terminal behaviours (ava)."
  (interactive "syarn ")
  (me/projectile-run-yarn (format "%s >> /tmp/yarn-with-redirect.log 2>&1" cmd))
  (view-file-other-window "/tmp/yarn-with-redirect.log")
  (turn-on-auto-revert-tail-mode)
  )

(defgroup me/lint nil "My lint settings")
(defcustom me/auto-lint nil "Auto lint - a home-rolled attempt - probably should not use." :group 'me/lint)
(defcustom me/use-prettier-js2-hook nil "Whether prettier-js mode will load when js2-mode is loaded.  M-x rjsx-mode after changing this setting." :group 'me/lint)
(defcustom me/use-eslintd-fix-js2-hook t "Whether eslintd-fix mode will load when js2-mode is loaded." :group 'me/lint)

(defun me/load-codesuki-eslint-fix ()
  "Use this with command customized to eslint_d (if eslintd-fix mode is playing up.)"
  (interactive)
  (eval-after-load 'js-mode
    '(add-hook 'js-mode-hook (lambda () (add-hook 'after-save-hook 'eslint-fix nil t))))

  (eval-after-load 'js2-mode
    '(add-hook 'js2-mode-hook (lambda () (add-hook 'after-save-hook 'eslint-fix nil t))))
  )

(defun me/eslint-fix-file ()
  (interactive)
  (let* ((dir (locate-dominating-file default-directory "node_modules"))
         ;; (eslint (concat dir "node_modules/.bin/eslint --fix " (buffer-file-name)))
         (eslint (concat dir "eslintd --fix " (buffer-file-name)))
         ;; (prettier (concat dir "node_modules/.bin/prettier --write --config " dir "package.json " (buffer-file-name)))
         )
    ;; (shell-command (concat eslint " || true"))
    (shell-command (concat eslint " 2 >&1 1>/dev/null"))
    (message (concat "AUTO LINTED AFTER SAVE: " eslint))
    (revert-buffer t t)
    ))

(defun me/eslint-fix-file-and-revert ()
  (if (and me/auto-lint (s-suffix? ".js" (buffer-file-name)))
      (progn
        (me/eslint-fix-file)
        ))
  )

(add-hook 'js2-mode-hook
          (lambda ()
            (add-hook 'after-save-hook #'me/eslint-fix-file-and-revert)))

(defun me/eslint-prettier-toggle-js2-mode ()
  (if me/use-prettier-js2-hook (prettier-js-mode) ))

(defun me/eslintd-fix-toggle-js2-mode ()
  (if me/use-eslintd-fix-js2-hook (eslintd-fix-mode) ))

;; --------------------------------------------------------------------------------
;; Prettier - https://github.com/prettier/prettier-emacs
(require 'prettier-js)
;; (add-hook 'js2-mode-hook 'prettier-js-mode)
;; (add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'js2-mode-hook 'me/eslint-prettier-toggle-js2-mode)
(add-hook 'js2-mode-hook 'me/eslintd-fix-toggle-js2-mode)
(add-hook 'web-mode-hook 'me/eslint-prettier-toggle-js2-mode)
(add-hook 'markdown-mode-hook 'me/eslint-prettier-toggle-js2-mode)
(add-hook 'scss-mode-hook 'me/eslint-prettier-toggle-js2-mode)
(add-hook 'css-mode-hook 'me/eslint-prettier-toggle-js2-mode)

;; (add-hook 'js2-mode-hook 'eslintd-fix-mode)

;; --------------------------------------------------------------------------------


(provide 'me/node)
;;; node.el ends here
