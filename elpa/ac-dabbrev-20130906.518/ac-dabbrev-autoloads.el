;;; ac-dabbrev-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (ac-dabbrev-get-candidates) "ac-dabbrev" "ac-dabbrev.el"
;;;;;;  (21278 10197 796471 140000))
;;; Generated autoloads from ac-dabbrev.el

(autoload 'ac-dabbrev-get-candidates "ac-dabbrev" "\


\(fn ABBREV)" nil nil)

(defvar ac-source-dabbrev '((candidates lambda nil (all-completions ac-target (ac-dabbrev-get-candidates ac-target))) (candidate-face . ac-dabbrev-menu-face) (selection-face . ac-dabbrev-selection-face)) "\
Source for dabbrev")

;;;***

;;;### (autoloads nil nil ("ac-dabbrev-pkg.el") (21278 10197 813331
;;;;;;  87000))

;;;***

(provide 'ac-dabbrev-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ac-dabbrev-autoloads.el ends here
