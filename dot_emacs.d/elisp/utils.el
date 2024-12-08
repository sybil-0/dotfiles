;;; utils.el -- General Utility functions.

;;; Commentary:

;;; Code:
(defun auto-comment-file ()
  "Auto-inserts default comments for elisp files."
  (interactive)
  (let* ((bs (buffer-name))
	 (name (file-name-sans-extension bs))
	 (header (format ";;; %s -- Summary\n\n" bs))
	 (footer (format ";;; %s ends here" bs)))
    (insert header)
    (insert ";;; Commentary:\n\n")
    (insert ";;; Code:\n\n")
    (insert (format "(provide '%s)\n\n" name))
    (insert footer)))

(provide 'utils)

;;; utils.el ends here
