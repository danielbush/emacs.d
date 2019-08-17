;;; css-in-js --- Use polymode to do css-in-js

;;; Commentary:
;;; https://polymode.github.io/defining-polymodes/

;;; Code:

(require 'polymode)
(require 'rjsx-mode)
(require 'css-mode)

(define-hostmode poly-cssjs-hostmode
  :mode 'rjsx-mode)

(define-innermode poly-cssjs-css-innermode
  :mode 'css-mode
  :head-matcher "css\`"
  :tail-matcher "\`.*\n"
  :head-mode 'host
  :tail-mode 'host)

(define-polymode poly-cssjs-mode
  :hostmode 'poly-cssjs-hostmode
  :innermodes '(poly-cssjs-css-innermode ))

(provide 'extra/css-in-js)
;;; css-in-js.el ends here
