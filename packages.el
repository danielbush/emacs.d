;; 25-Sep-2016 Packaging taken from http://stackoverflow.com/questions/14836958/updating-packages-in-emacs

(setq me/packages
      '(

        yasnippet

        helm
        helm-ag
        projectile
        helm-projectile
        helm-swoop
        helm-ls-git

        switch-window
        avy
        ace-window
        window-numbering
        framemove

        elscreen
        elscreen-persist

        magit
        flycheck
        helm-flycheck
        editorconfig
        wgrep
        wgrep-helm

        zenburn-theme
        monokai-theme
        golden-ratio
        markdown-mode

        paredit
        yaml-mode
        js2-mode
        rjsx-mode
        json-mode
        flow-mode
        flycheck-flow
        php-mode
        web-mode
        ruby-mode
        ruby-additional
        rspec-mode
        inf-ruby
        rvm
        tidy

        js2-mode
        rjsx-mode
        nvm
        web-mode
        flow-mode
        company-flow

        php-mode

        ruby-mode
        ruby-additional
        rspec-mode
        inf-ruby
        rvm

        csharp-mode
        haskell-mode

        docker
        dockerfile-mode
        docker-tramp

        auto-complete
        ac-helm
        ac-dabbrev
        ))

(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))

(defun me/package-install-my-packages ()
  "Install any packages in me/packages, if they are not installed already."
  (interactive)
  (let ((refreshed nil))
    (package-refresh-contents)
    (dolist (pkg me/packages)
      ;(message (symbol-name pkg))
      (when (not (package-installed-p pkg))
        (message (concat "installing " (symbol-name pkg)))
        (package-install pkg)))))

(defun me/package-list-unaccounted-packages ()
  "Like `package-list-packages', but shows only the packages that
  are installed and are not in `me/packages'.  Useful for
  cleaning out unwanted packages."
  (interactive)
  (package-show-package-list
   (remove-if-not (lambda (x) (and (not (memq x me/packages))
                                   (not (package-built-in-p x))
                                   (package-installed-p x)))
                  (mapcar 'car package-archive-contents))))
