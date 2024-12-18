;;; Oxocarbon-theme.el --- Oxocarbon
;;; Version: 1.0
;;; Commentary:
;;; A theme called Oxocarbon
;;; Code:

(deftheme Oxocarbon "DOCSTRING for Oxocarbon")
  (custom-theme-set-faces 'Oxocarbon
   '(default ((t (:foreground "#f2f4f8" :background "#161616" ))))
   '(cursor ((t (:background "#ffffff" ))))
   '(fringe ((t (:background "#262626" ))))
   '(mode-line ((t (:foreground "#f2f4f8" :background "#161616" ))))
   '(region ((t (:background "#525252" ))))
   '(secondary-selection ((t (:background "#393939" ))))
   '(font-lock-builtin-face ((t (:foreground "#78a9ff" ))))
   '(font-lock-comment-face ((t (:foreground "#525252" ))))
   '(font-lock-function-name-face ((t (:foreground "#33b1ff" ))))
   '(font-lock-keyword-face ((t (:foreground "#be95ff" ))))
   '(font-lock-string-face ((t (:foreground "#42be65" ))))
   '(font-lock-type-face ((t (:foreground "#78a9ff" ))))
   '(font-lock-constant-face ((t (:foreground "#f2f4f8" ))))
   '(font-lock-variable-name-face ((t (:foreground "#f2f4f8" ))))
   '(minibuffer-prompt ((t (:foreground "#525252" :bold t ))))
   '(font-lock-warning-face ((t (:foreground "#ee5396" :bold t ))))
   )

;;;###autoload
(and load-file-name
    (boundp 'custom-theme-load-path)
    (add-to-list 'custom-theme-load-path
                 (file-name-as-directory
                  (file-name-directory load-file-name))))
;; Automatically add this theme to the load path

(provide-theme 'Oxocarbon)

;;; Oxocarbon-theme.el ends here
