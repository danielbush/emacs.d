;; https://www.emacswiki.org/emacs/StickyBufferMode
(define-minor-mode sticky-buffer-mode "Make the current window always display
    this buffer."  nil " sticky" nil (set-window-dedicated-p (selected-window)
    sticky-buffer-mode))
