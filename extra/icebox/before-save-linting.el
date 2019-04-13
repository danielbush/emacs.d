;; https://github.com/rubocop-hq/rubocop-emacs/pull/29/files
;; https://emacs.stackexchange.com/questions/41102/replacing-buffer-content-without-losing-point
;; https://github.com/prettier/prettier-emacs
;; https://github.com/SamVerschueren/vscode-linter-xo/issues/48  << might be why I can't run cli


(defun me/replace-current-buffer-text (new-text)
  (let ((old-point (point)))
    (erase-buffer)
    (insert new-text)
    (goto-char old-point))
  )

(defun me/lint-fix-buffer ()
  (interactive)
  (let (
        (buffer-string (buffer-substring-no-properties (point-min) (point-max)))
        )
    )
  
  )

(defun me/before-save-lint-hook ()
  (interactive)
  (add-hook 'before-save-hook 'me/lint-fix-buffer nil t)
  )

