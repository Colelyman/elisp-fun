;;; query.el --- A collection of query functions -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(require 'subr-x) ;; used for `string-trim'

(defun query-and-replace-from-file (replace-file target-file)
  "Perform query and replace on TARGET-FILE using the whitespace delimited query and replacement in REPLACE-FILE."
  (interactive "fFile with search and replace: \nfTarget file: ")
  (let ((split-pos 0)
        (query "")
        (replace "")
        (more-lines t))
    (find-file target-file)
    (goto-char 1)
    (set-buffer (find-file replace-file))
    (goto-char 1)
    (while more-lines
      (set-buffer (find-file replace-file))
      (re-search-forward "[:space:]" nil t)
      (setq split-pos (1- (point)))
      (beginning-of-line)
      (setq query (string-trim (buffer-substring-no-properties (point) split-pos)))

      (end-of-line)
      (setq replace (string-trim (buffer-substring-no-properties split-pos (point))))

      (message "Query: %s replace: %s\n" query replace)

      ;; Replace the text in the target-file
      (with-current-buffer (find-file target-file)
        (goto-char 1)
        (while (re-search-forward query nil t)
          (replace-match replace))
        (save-buffer))
      (set-buffer (find-file replace-file))
      (setq more-lines (= 0 (forward-line))))))

(provide 'query)
;;; query.el ends here
