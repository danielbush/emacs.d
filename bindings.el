
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
;(global-set-key (kbd "M-s o") 'helm-swoop)
(global-set-key (kbd "C-x c M-s o") 'occur)

(global-set-key (kbd "C-x o") 'helm-elscreen)


(progn
  (global-set-key (kbd "C-M-h") 'windmove-left)
  (global-set-key (kbd "M-h") 'windmove-left)
  (global-set-key (kbd "C-S-h") 'windmove-left)
  (global-set-key (kbd "C-M-l") 'windmove-right)
  (global-set-key (kbd "M-l") 'windmove-right)
  (global-set-key (kbd "C-S-l") 'windmove-right)
  (global-set-key (kbd "C-M-k") 'windmove-up)
  (global-set-key (kbd "M-k") 'windmove-up)
  (global-set-key (kbd "C-S-k") 'windmove-up)
  (global-set-key (kbd "C-M-j") 'windmove-down)
  (global-set-key (kbd "C-S-j") 'windmove-down)
  )

(global-set-key (kbd "C-c l") 'toggle-truncate-lines)

(global-set-key (kbd "C-c k k")
                  '(lambda () (interactive)
                     (kill-buffer (current-buffer))))
