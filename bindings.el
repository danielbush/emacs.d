;;; bindings.el -- stuff
;;; Commentary:
;;; Code:

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'switch-to-buffer)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-c b") 'helm-projectile-switch-to-buffer)
(global-set-key (kbd "C-c C-b") 'helm-projectile-switch-to-buffer)

;;; Multi search open buffers can be useful.
;;; 'helm-multi-swoop-projectile
;;; 'helm-multi-swoop-all
(require 'magit)
;; (global-set-key (kbd "C-c C-c C-b") 'helm-multi-swoop-projectile)
;; (define-key prog-mode-map (kbd "C-c C-c C-b") 'helm-multi-swoop-projectile)
;; (define-key magit-mode-map (kbd "C-c C-c C-b") 'helm-multi-swoop-projectile)
;; (define-key magit-log-mode-map (kbd "C-c C-c C-b") 'helm-multi-swoop-projectile)
;; (define-key magit-status-mode-map (kbd "C-c C-c C-b") 'helm-multi-swoop-projectile)
;; (define-key magit-revision-mode-map (kbd "C-c C-c C-b") 'helm-multi-swoop-projectile)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key
 (kbd "C-x C-b")
 ;; also try: locate-dominating-file
 '(lambda () (interactive) (if (ignore-errors (projectile-project-root)) (call-interactively 'projectile-ibuffer) (call-interactively 'ibuffer))))
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(global-set-key (kbd "C-x c b") 'helm-resume)
(global-set-key (kbd "C-c v") 'helm-projectile-find-file)
(global-set-key (kbd "C-c d") 'helm-projectile-find-dir)
(progn
;;; Aug-2019 helm-projectile-ag no longer respects -G
  (global-set-key (kbd "C-c f") 'helm-projectile-ag)
  (global-set-key (kbd "C-c f") 'helm-do-ag-project-root)
  )
(global-set-key (kbd "C-x p s s") 'helm-do-ag)
(global-set-key (kbd "M-s i") 'helm-multi-swoop-projectile)
(global-set-key (kbd "M-s i") 'helm-swoop)
(global-set-key (kbd "M-s o") 'helm-occur)
(global-set-key (kbd "M-s i") 'helm-swoop)
(global-set-key (kbd "C-x c M-s o") 'occur)

(global-set-key (kbd "C-x C-o") 'helm-elscreen)


(progn
  (global-set-key (kbd "C-1") '(lambda () (interactive) (elscreen-goto 0)))
  (global-set-key (kbd "C-2") '(lambda () (interactive) (elscreen-goto 1)))
  (global-set-key (kbd "C-3") '(lambda () (interactive) (elscreen-goto 2)))

  ;; (global-set-key (kbd "M-c") 'avy-goto-line)
  ;; (global-set-key (kbd "M-c") 'avy-goto-word-or-subword-1)
  (global-set-key (kbd "M-c") 'avy-goto-char)
  (global-set-key (kbd "M-c") 'avy-goto-char-2)
  (global-set-key (kbd "M-c") 'avy-goto-subword-1)
  (global-set-key (kbd "M-c") 'avy-goto-word-1)
  (global-set-key (kbd "M-z") 'ace-swap-window)

  (global-set-key (kbd "C-M-h") 'windmove-left)
  (global-set-key (kbd "C-M-j") 'windmove-down)
  (global-set-key (kbd "C-M-k") 'windmove-up)
  (global-set-key (kbd "C-M-l") 'windmove-right)

  (global-set-key (kbd "C-S-h") 'windmove-left)
  (global-set-key (kbd "C-S-j") 'windmove-down)
  (global-set-key (kbd "C-S-k") 'windmove-up)
  (global-set-key (kbd "C-S-l") 'windmove-right)

  (global-set-key (kbd "C-M-S-h") 'windmove-left)
  (global-set-key (kbd "C-M-S-j") 'windmove-down)
  (global-set-key (kbd "C-M-S-k") 'windmove-up)
  (global-set-key (kbd "C-M-S-l") 'windmove-right)

  (global-set-key (kbd "M-q") 'switch-window)
  ;(global-set-key (kbd "C-1") 'select-window-1)
  ;(global-set-key (kbd "C-2") 'select-window-2)
  ;(global-set-key (kbd "C-3") 'select-window-3)
  ;(global-set-key (kbd "C-4") 'select-window-4)
  ;(global-set-key (kbd "C-5") 'select-window-5)
  ;(global-set-key (kbd "C-6") 'select-window-6)

  ;; fm-*
  ;(global-set-key (kbd "C-M-S-h") 'fm-left-frame)
  ;(global-set-key (kbd "C-M-S-j") 'fm-down-frame)
  ;(global-set-key (kbd "C-M-S-k") 'fm-up-frame)
  ;(global-set-key (kbd "C-M-S-l") 'fm-right-frame)

  ;; For mac osx - 2 monitors
  ;(global-set-key (kbd "M-l") 'fm-right-frame)
  ;(global-set-key (kbd "M-h") 'fm-left-frame)
  ;(global-set-key (kbd "M-q") 'select-frame-by-name)

  (global-set-key (kbd "M-1") '(lambda () (interactive) (select-frame-by-name "1")))
  (global-set-key (kbd "M-C-1") '(lambda () (interactive) (select-frame-by-name "1")))
  (global-set-key (kbd "M-2") '(lambda () (interactive) (select-frame-by-name "2")))
  (global-set-key (kbd "M-C-2") '(lambda () (interactive) (select-frame-by-name "2")))
  (global-set-key (kbd "M-3") '(lambda () (interactive) (select-frame-by-name "3")))
  (global-set-key (kbd "M-C-3") '(lambda () (interactive) (select-frame-by-name "3")))
  (global-set-key (kbd "M-4") '(lambda () (interactive) (select-frame-by-name "4")))
  (global-set-key (kbd "M-C-4") '(lambda () (interactive) (select-frame-by-name "4")))
  )

(global-set-key (kbd "C-c l") 'toggle-truncate-lines)

(global-set-key (kbd "C-c k k")
                  '(lambda () (interactive)
                     (kill-buffer (current-buffer))))

(global-set-key (kbd "C-c C-p") 'switch-to-prev-buffer)
(global-set-key (kbd "C-c p")   'switch-to-prev-buffer)
(global-set-key (kbd "C-c C-n") 'switch-to-next-buffer)
(global-set-key (kbd "C-c n")   'switch-to-next-buffer)
(global-set-key (kbd "C-x h")   'previous-buffer)
(global-set-key (kbd "C-x l")   'next-buffer)


; mac os x pain...
(global-set-key (kbd "C-c C-b") 'other-frame)
(global-set-key (kbd "C-x C-n") 'other-frame)

(global-set-key (kbd "M-C-r")   'helm-recentf)
(global-set-key (kbd "M-r")   'helm-projectile-recentf)

(provide 'bindings)
;;; bindings.el ends here

