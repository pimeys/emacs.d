;;; simpleclip-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (simpleclip-paste simpleclip-cut simpleclip-copy
;;;;;;  simpleclip-mode simpleclip-set-contents simpleclip-get-contents
;;;;;;  simpleclip-keys simpleclip) "simpleclip" "simpleclip.el"
;;;;;;  (21366 7677 534538 734000))
;;; Generated autoloads from simpleclip.el

(let ((loads (get 'simpleclip 'custom-loads))) (if (member '"simpleclip" loads) nil (put 'simpleclip 'custom-loads (cons '"simpleclip" loads))))

(let ((loads (get 'simpleclip-keys 'custom-loads))) (if (member '"simpleclip" loads) nil (put 'simpleclip-keys 'custom-loads (cons '"simpleclip" loads))))

(autoload 'simpleclip-get-contents "simpleclip" "\
Return the contents of the system clipboard as a string.

\(fn)" nil nil)

(autoload 'simpleclip-set-contents "simpleclip" "\
Set the contents of the system clipboard to STR-VAL.

\(fn STR-VAL)" nil nil)

(defvar simpleclip-mode nil "\
Non-nil if Simpleclip mode is enabled.
See the command `simpleclip-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `simpleclip-mode'.")

(custom-autoload 'simpleclip-mode "simpleclip" nil)

(autoload 'simpleclip-mode "simpleclip" "\
Turn on `simpleclip-mode'.

When called interactively with no prefix argument this command
toggles the mode.  With a prefix argument, it enables the mode
if the argument is positive and otherwise disables the mode.

When called from Lisp, this command enables the mode if the
argument is omitted or nil, and toggles the mode if the argument
is 'toggle.

\(fn &optional ARG)" t nil)

(autoload 'simpleclip-copy "simpleclip" "\
Copy the active region (from BEG to END) to the system clipboard.

\(fn BEG END)" t nil)

(autoload 'simpleclip-cut "simpleclip" "\
Cut the active region (from BEG to END) to the system clipboard.

\(fn BEG END)" t nil)

(autoload 'simpleclip-paste "simpleclip" "\
Paste the contents of the system clipboard at the point.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("simpleclip-pkg.el") (21366 7677 565608
;;;;;;  459000))

;;;***

(provide 'simpleclip-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; simpleclip-autoloads.el ends here
