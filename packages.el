;; 25-Sep-2016 Packaging taken from http://stackoverflow.com/questions/14836958/updating-packages-in-emacs

(setq me/packages
      '(

        s ;https://stackoverflow.com/questions/22403751/check-if-a-string-ends-with-a-suffix-in-emacs-lisp
        yasnippet

        helm
        helm-ag
        projectile
        helm-projectile
        helm-swoop
        helm-ls-git
        swiper
        swiper-helm

        switch-window
        avy
        ace-window
        window-numbering
        ;; framemove

        elscreen
        ;; elscreen-persist

        magit
        flycheck
        prettier-js ;; npm i -g prettier; M-x customize-option prettier-js-args
        helm-flycheck
        editorconfig
        wgrep
        wgrep-helm
        all
        evil

        zenburn-theme
        monokai-theme
        dracula-theme
        golden-ratio
        markdown-mode

        paredit
        yaml-mode
        hcl-mode
        json-mode
        ;; tidy

        js2-mode
        rjsx-mode
        graphql-mode
        nvm
        web-mode
        ;; flow-mode
        flow-minor-mode
        flycheck-flow
        company-flow

        groovy-mode

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
        ;; ac-dabbrev
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
