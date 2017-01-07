
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(global-set-key (kbd "C-x c b") 'helm-resume)
(global-set-key (kbd "C-c v") 'helm-projectile-find-file)
(global-set-key (kbd "C-c d") 'helm-projectile-find-dir)
(global-set-key (kbd "C-c f") 'helm-projectile-ag)
(global-set-key (kbd "C-c p p") 'helm-projectile-switch-project)
(global-set-key (kbd "C-x p s s") 'helm-do-ag)
(global-set-key (kbd "M-s o") 'helm-occur)
(global-set-key (kbd "M-s o") 'helm-swoop)
(global-set-key (kbd "C-x c M-s o") 'occur)

(global-set-key (kbd "C-x C-o") 'helm-elscreen)


(progn
  (global-set-key (kbd "C-1") '(lambda () (interactive) (me/elscreen-goto-screen 0)))
  (global-set-key (kbd "C-2") '(lambda () (interactive) (me/elscreen-goto-screen 1)))
  (global-set-key (kbd "C-3") '(lambda () (interactive) (me/elscreen-goto-screen 2)))
  (global-set-key (kbd "C-4") '(lambda () (interactive) (me/elscreen-goto-screen 3)))
  (global-set-key (kbd "C-5") '(lambda () (interactive) (me/elscreen-goto-screen 4)))
  (global-set-key (kbd "C-6") '(lambda () (interactive) (me/elscreen-goto-screen 5)))
  (global-set-key (kbd "C-7") '(lambda () (interactive) (me/elscreen-goto-screen 6)))
  (global-set-key (kbd "C-8") '(lambda () (interactive) (me/elscreen-goto-screen 7)))
  (global-set-key (kbd "C-9") '(lambda () (interactive) (me/elscreen-goto-screen 8)))
  (global-set-key (kbd "C-0") '(lambda () (interactive) (me/elscreen-goto-screen 9)))

  (global-set-key (kbd "M-p") 'avy-goto-word-or-subword-1)

  (global-set-key (kbd "C-M-h") 'windmove-left)
  (global-set-key (kbd "C-M-j") 'windmove-down)
  (global-set-key (kbd "C-M-k") 'windmove-up)
  (global-set-key (kbd "C-M-l") 'windmove-right)

  (global-set-key (kbd "C-S-h") 'windmove-left)
  (global-set-key (kbd "C-S-j") 'windmove-down)
  (global-set-key (kbd "C-S-k") 'windmove-up)
  (global-set-key (kbd "C-S-l") 'windmove-right)

  (global-set-key (kbd "M-q") 'switch-window)
  ;(global-set-key (kbd "C-1") 'select-window-1)
  ;(global-set-key (kbd "C-2") 'select-window-2)
  ;(global-set-key (kbd "C-3") 'select-window-3)
  ;(global-set-key (kbd "C-4") 'select-window-4)
  ;(global-set-key (kbd "C-5") 'select-window-5)
  ;(global-set-key (kbd "C-6") 'select-window-6)

  (global-set-key (kbd "C-M-S-h") 'fm-left-frame)
  (global-set-key (kbd "C-M-S-j") 'fm-down-frame)
  (global-set-key (kbd "C-M-S-k") 'fm-up-frame)
  (global-set-key (kbd "C-M-S-l") 'fm-right-frame)


  ;; For mac osx - 2 monitors
  (global-set-key (kbd "M-l") 'fm-right-frame)
  (global-set-key (kbd "M-h") 'fm-left-frame)
  ;(global-set-key (kbd "M-q") 'select-frame-by-name)
  (global-set-key (kbd "M-1") '(lambda () (interactive) (select-frame-by-name "1")))
  (global-set-key (kbd "M-2") '(lambda () (interactive) (select-frame-by-name "2")))
  (global-set-key (kbd "M-3") '(lambda () (interactive) (select-frame-by-name "3")))
  (global-set-key (kbd "M-4") '(lambda () (interactive) (select-frame-by-name "4")))
  )

(global-set-key (kbd "C-c l") 'toggle-truncate-lines)

(global-set-key (kbd "C-c k k")
                  '(lambda () (interactive)
                     (kill-buffer (current-buffer))))

; mac os x pain...
(global-set-key (kbd "C-c C-b") 'other-frame)
(global-set-key (kbd "C-c C-n") 'other-frame)
(global-set-key (kbd "C-x C-n") 'other-frame)
