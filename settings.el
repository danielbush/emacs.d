;;; package --- some personal settings, core emacs
;;; Commentary:
;;; 
;; Viper - so that I can use vi keys

;; So I have vi keybindings.
(setq viper-mode t)
(require 'viper)
;; Other - PUT THESE IN ~/.viper:
;(setq viper-expert-level  '5)
;(setq viper-inhibit-startup-message  't)
;(setq viper-want-ctl-h-help t)
;(setq-default viper-no-multiple-ESC t)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; Enable helm across emacs (eg customize-options)
(helm-mode 1)

(show-paren-mode 1)

;; Store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;; windmove so I can move easily
;; - see bindings; windmove looks to be core.

;; Maybe useful if you have floating emacs frames especially if on different monitors.

(defun me/windmove-uses-frames ()
  "Windmove keys will move to frames - works well if frames are on different screens
or cascaded."
  (interactive)
  (require 'cl)
  (require 'framemove)
  (windmove-default-keybindings)
  (setq framemove-hook-into-windmove t))

;; winner so I have window history

(winner-mode 1)

(setq winner-boring-buffers '("*Completions*"
                              "*Compile-Log*"
                              "*inferior-lisp*"
                              "*Fuzzy Completions*"
                              "*Apropos*"
                              "*dvc-error*"
                              "*Help*"
                              "*cvs*"
                              "*Buffer List*"
                              "*Ibuffer*"
                              "*helm*"
                              "*helm find files*"
                              "*helm mini*"
                              "*helm M-x*"
                              ))


(electric-pair-mode 1)

(progn
  (defun me/bg-blue () (interactive) (set-background-color "#001133"))
  (defun me/bg-blue () (interactive) (set-background-color "#003344"))
  (defun me/bg-black () (interactive) (set-background-color "black"))
  (defun me/bg-dark () (interactive) (set-background-color "gray15"))
  (defun me/bg-mid () (interactive) (set-background-color "gray25"))
  (defun me/bg-green () (interactive) (set-background-color "green4"))
  (defun me/bg-green () (interactive) (set-background-color "#002200"))
  (defun me/bg-green () (interactive) (set-background-color "#004444"))
  (defun me/bg-purple () (interactive) (set-background-color "purple4"))
  (defun me/bg-purple () (interactive) (set-background-color "#330033"))
  (defun me/bg-red () (interactive) (set-background-color "brown4"))
  (defun me/bg-red () (interactive) (set-background-color "#550000"))
  (defun me/bg-brown () (interactive) (set-background-color "#4f1800")))


(progn
  (defun me/font-xsmall () (interactive) (set-face-attribute 'default nil :font "Monospace 10" ))
  (defun me/font-small () (interactive) (set-face-attribute 'default nil :font "Monospace 11" ))
  (defun me/font-med   () (interactive) (set-face-attribute 'default nil :font "Monospace 12" ))
  (defun me/font-large () (interactive) (set-face-attribute 'default nil :font "Monospace 13" ))
  (defun me/font-large () (interactive) (set-face-attribute 'default nil :font "Monospace 14" ))
  (defun me/font-xlarge () (interactive) (set-face-attribute 'default nil :font "Monospace 16" ))
  ;; (defun me/font-small () (interactive) (set-face-attribute 'default nil :font "Liberation Mono 10" ))
  ;; (defun me/font-medium () (interactive) (set-face-attribute 'default nil :font "Liberation Mono 12" ))
  ;; (defun me/font-large () (interactive) (set-face-attribute 'default nil :font "Liberation Mono 13" ))
  )

(defun me/mac-fonts ()
  "Fonts for mac os x."
  (interactive)
  (progn
    ;; (defun me/font-x-small () (interactive) (set-face-attribute 'default nil :font "Menlo 9" ))
    ;; (defun me/font-small () (interactive) (set-face-attribute 'default nil :font "Menlo 10" ))
    ;; (defun me/font-med () (interactive) (set-face-attribute 'default nil :font "Menlo 11" ))
    ;; (defun me/font-medium () (interactive) (set-face-attribute 'default nil :font "Menlo 12" ))
    ;; (defun me/font-large () (interactive) (set-face-attribute 'default nil :font "Menlo 14" ))
    ;; (defun me/font-xlarge () (interactive) (set-face-attribute 'default nil :font "Menlo 16" ))


    ;; Based on set-font-frame
    (defun me/font-xsmall () (interactive) (set-frame-font "-*-Menlo-normal-normal-normal-*-10-*-*-*-m-0-iso10646-1" t t) )
    (defun me/font-small () (interactive) (set-frame-font "-*-Menlo-normal-normal-normal-*-11-*-*-*-m-0-iso10646-1" t t) )
    (defun me/font-medium () (interactive) (set-frame-font "-*-Menlo-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1" t t) )
    (defun me/font-med () (interactive) (set-frame-font "-*-Menlo-normal-normal-normal-*-12-*-*-*-m-0-iso10646-1" t t) )
    (defun me/font-large () (interactive) (set-frame-font "-*-Menlo-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1" t t) )
    (defun me/font-xlarge () (interactive) (set-frame-font "-*-Menlo-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1" t t) )
    ))


(require 'helm-projectile)
(require 'helm-ls-git)

; Make js2-mode the default for js.
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))

(set-face-attribute 'region nil :foreground "#777" :background "#ffa")
