;;; me/packages.el -- my packages
;;; Commentary:
;; 25-Sep-2016 Packaging taken from http://stackoverflow.com/questions/14836958/updating-packages-in-emacs

;;; Code:

(require 'cl)

(defvar me/packages
      '(

        hemisu-theme
        dakrone-theme
        bubbleberry-theme
        moe-theme
        ample-theme
        solarized-theme
        spacemacs-theme
        color-theme-sanityinc-tomorrow  ;; https://pawelbx.github.io/emacs-theme-gallery/
        darkburn-theme ;; better zenburn
        clues-theme
        zenburn-theme
        ;; monokai-theme
        ;; dracula-theme

        ;; https://stackoverflow.com/questions/22403751/check-if-a-string-ends-with-a-suffix-in-emacs-lisp
        s


        ;; ------------------------------------------------------------
        ;; Core

        helm
        helm-ag
        helm-ls-git
        helm-swoop ;; oocur
        loccur

        projectile
        helm-projectile

        avy ;; jump to lines
        ace-window ;; swap windows
        switch-window
        window-numbering ;; switch window M-1,2...
        ;; framemove
        elscreen
        ;; elscreen-persist
        golden-ratio
        beacon

        ;; Remove?
        swiper
        swiper-helm

        ;; ------------------------------------------------------------
        ;; Git

        magit
        ;; Replaces https://github.com/vermiculus/magithub .
        ;; https://emacsair.me/2018/12/19/forge-0.1/
        forge

        ;; ------------------------------------------------------------
        ;; Linting

        flycheck
        helm-flycheck
        editorconfig
        
        ;; ------------------------------------------------------------
        ;; Editing

        all ;; edit all lines, alternative to occur + 'e'
        wgrep
        wgrep-helm
        yasnippet
        evil ;; alternative to viper

        ;; ------------------------------------------------------------
        ;; Tagging, jumping, cross referencing, autocomplete, intellisense

        ;; https://www.emacswiki.org/emacs/JumpToDefinition
        ;; https://github.com/jacktasia/dumb-jump
        dumb-jump

        ;;; 4-May-2019 - Haven't figured xref / xref-js2 out.
        ;; xref-js2 helm-xref


        ;; https://emacs.stackexchange.com/questions/712/what-are-the-differences-between-autocomplete-and-company-mode
        company ;; probably favour company over auto-complete
        company-flow
        helm-company

        ;; company-tern ;; npm i -g tern

        ;;; lsp-mode
        ;;;
        ;;; READING
        ;;; - "you can use typescript to parse and infer types for js"
        ;;;   - https://medium.com/front-end-weekly/including-typescript-definitions-in-a-non-typescript-project-using-visual-studio-code-vsc-eac62765fd
        ;;;     - you can use typescript support in js
        ;;;     - NOTE: it uses "typings", use @types/<package> instead now
        ;;;   - https://www.reddit.com/r/emacs/comments/68zacv/using_tidemode_to_typecheck_javascript/
        ;;;     - "the latest release of typescript supports parsing and inferring types for js"
        ;;;     - introduces jsconfig.json (cf tsconfig.json)
        ;;;       - this seems to imply tide is hooking into lsp (vscode)?
        ;;; - "add a package (eg @types/<package-name> without modifying project)"
        ;;;   - https://github.com/yarnpkg/yarn/issues/1743
        ;;; - "completion after dot"
        ;;;   - https://github.com/emacs-eclim/emacs-eclim/issues/10
        ;;;   - doesn't wfm - company-lsp needs tweaking?
        ;;; - tide - for js as well as ts
        ;;;   - https://github.com/ananthakumaran/tide
        ;;;   - https://www.reddit.com/r/emacs/comments/68zacv/using_tidemode_to_typecheck_javascript/
        ;;;
        ;;; PROCEDURE
        ;;; - Install js code:
        ;;;   https://github.com/emacs-lsp/lsp-mode/#configuration
        ;;;   - npm i -g javascript-typescript-langserver
        ;;;   ? npm i -g typescript-language-server; npm i -g typescript
        ;;;     - I think this is for actual typescript
        ;;;   - install typescript types; if you don't do this lsp ui will show
        ;;;     error "Cannot find module 'react'" etc.
        ;;;     - npm i @types/react --save-dev|--no-save # similarly @types/react-dom
        ;;;     - yarn add --no-lockfile @types/react ; yarn remove @types/react
        ;;; - Add jsconfig.json file to root of project for lsp-mode
        ;;;   https://code.visualstudio.com/docs/languages/jsconfig
        ;;;   {
        ;;;     "compilerOptions": {
        ;;;       "target": "es2017",
        ;;;       "allowSyntheticDefaultImports": true,
        ;;;       "noEmit": true,
        ;;;       "checkJs": true,
        ;;;       "jsx": "react",
        ;;;       "lib": [ "dom", "es2017" ]
        ;;;     }
        ;;;   }
        ;;;   - this configures the language server for javascript
        ;;;   - M-x magit status; 'i', 'p' (.git/info/exclude)
        ;;; - customize-group company
        ;;;   - I delete all the backends
        ;;;   - add "company-lsp" (option "D")
        ;;; - M-x lsp ; in project buffer; starts "javascript-typescript-stdio" process
        ;;; - Restarting
        ;;;   - M-x lsp-restart-workspace
        ;;;   - pkill -f javascript-typescript-stdio # kill it
        ;;; - M-x customize-group lsp-ui
        ;;;   - disable sideline - sideline is the annoying one that clutters the screen
        ;;;   - enable flycheck

        lsp-mode
        lsp-ui ;;; will load automatically if lsp-mode is enabled
        ;; lsp-javascript-flow       ;; DONT NEED - this is now built-in to lsp-mode
        ;; lsp-javascript-typescript ;; DONT NEED - this is now built-in to lsp-mode
        company-lsp

        auto-complete ;; ac-*
        ac-helm
        ;; ac-dabbrev

        ;; ------------------------------------------------------------
        ;; Useful modes

        paredit
        yaml-mode
        hcl-mode
        json-mode
        ;; tidy
        markdown-mode
        web-mode
        graphql-mode
        docker
        dockerfile-mode
        docker-tramp

        ;; ------------------------------------------------------------
        ;; js
        ;;
        ;; 13-Apr-19
        ;; - https://emacs.cafe/emacs/javascript/setup/2017/05/09/emacs-setup-javascript-2.html
        ;;   - tern (company, company-tern backend), xref-js2, tide
        ;;   - indium - browser + node debugging

        js2-mode
        rjsx-mode

        nvm
        pug-mode
        ;; flow-mode
        flow-minor-mode
        flycheck-flow

        ;; ------------------------------------------------------------
        ;; js / linting

        prettier-js ;; npm i -g prettier; M-x customize-option prettier-js-args

        ;; To do: eslint --fix in emacs.
        ;; https://github.com/aaronjensen/eslintd-fix (required: npm i -g eslint_d)
        ;; (Uses: https://github.com/mantoni/eslint_d.js/ .)
        ;; Other options:
        ;; https://github.com/codesuki/eslint-fix/ - looks simpler probably slower
        ;; https://gist.github.com/ustun/73321bfcb01a8657e5b8 - a gist that does similar

        eslintd-fix ;; seems to corrupt fe-pa-listing-details files

        ;; TIP: set command to use eslint_d instead of eslint to make
        ;; it fast - not sure if we need to start eslint_d up first,
        ;; it's possible eslintd-fix starts eslint_d with all the
        ;; correct settings, but eslintd-fix seems to corrupt my files
        ;; atm.
        eslint-fix

        ;; ------------------------------------------------------------
        ;; Python
        elpy
        ;; https://elpy.readthedocs.io/en/latest/introduction.html
        ;; (elpy-config) ;; for configuration
        ;; https://stackoverflow.com/questions/12184846/where-should-virtualenvs-be-created
        ;; - Uses virtualenvwrapper which uses ~/.virtualenvs/<name>.
        ;; - (pyvenv-create)
        ;; - (pyvenv-workon) RET <name> RET - to select a virtualenv
        ;; - M-& pip install yapf autopep8 flake8 jedi # to install in a virtualenv
        ;; (elpy-format-code) ;; for prettify + lint
        jedi
        ;; - elpy uses "jedi" as a backend (for autocomplete and xref).
        ;; - Backend, "C-c ." go to definition etc
        ;; - seems to work without company-jedi

        ;; ------------------------------------------------------------
        ;; Other languages

        groovy-mode

        php-mode

        ruby-mode
        ruby-additional
        rspec-mode
        inf-ruby
        rvm

        csharp-mode
        haskell-mode

        ;; ------------------------------------------------------------
        ;; frivolous

        chess

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
  "Like `package-list-packages', but show only the packages that are installed and are not in `packages'.
Useful for cleaning out unwanted packages."
  (interactive)
  (package-show-package-list
   (remove-if-not (lambda (x) (and (not (memq x me/packages))
                                   (not (package-built-in-p x))
                                   (package-installed-p x)))
                  (mapcar 'car package-archive-contents))))

(provide 'packages)
;;; packages.el ends here
