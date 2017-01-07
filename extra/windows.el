;;; package --- utilities for managing windows in a frame
;;;
;;; Commentary:
;;; http://emacs.stackexchange.com/questions/2710/switching-between-window-layouts
;;; looks like a superior approach to using registers.
;;;
;;; Code:

(require 'helm)

(defvar me/windows (make-hash-table :test 'equal :size 10) "Hash of saved window configurations.")

(defun me/windows/reset ()
  (interactive)
  (clrhash me/windows)
)

(defun me/windows/names ()
  (let ((result '()))
    (maphash
     (lambda (key val)
       (progn
         (setq result (cons key result))
         ))
     me/windows)
    result
    ))

(defun me/windows/switch-windows ()
  (interactive)
  (helm :sources
        `((name . "window-layouts: ")
          (candidates . ,(me/windows/names))
          (action . (lambda (key)
                      (message (concat "selected " (princ key)))
                      (let ((window-configuration (gethash key me/windows)))
                        (message "me/windows using register %s for window layout %s"
                                 window-configuration key)
                        (set-window-configuration window-configuration)
                        )))
          (keymap keymap
                  ,(let ((map (make-sparse-keymap)))
                     (define-key map (kbd "C-g") 'helm-keyboard-quit)
                     (define-key map (kbd "C-n") 'helm-next-line)
                     (define-key map (kbd "C-p") 'helm-previous-line)
                     map
                     )
                  )
          ))
  )

(defun me/windows/delete ()
  (interactive)
  (helm :sources
        `((name . "window-layouts: ")
          (candidates . ,(me/windows/names))
          (action . (lambda (key)
                      (message (concat "selected " (princ key)))
                      (let ((window-configuration (gethash key me/windows)))
                        (if window-configuration
                            (remhash key me/windows))
                        )
                      ))
          (keymap keymap
                  ,(let ((map (make-sparse-keymap)))
                     (define-key map (kbd "C-g") 'helm-keyboard-quit)
                     (define-key map (kbd "C-n") 'helm-next-line)
                     (define-key map (kbd "C-p") 'helm-previous-line)
                     map
                     )
                  )
          ))
  )

(defun me/windows/save (name)
  (interactive "sName: ")
  (let ((window-configuration (current-window-configuration)))
    (message (format "me/windows using confgi %s" window-configuration))
    (puthash name window-configuration me/windows)
    ))

(provide 'me/windows)
;;; windows.el ends here
