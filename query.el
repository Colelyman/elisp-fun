;;; query.el --- A collection of query functions -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(require 'subr-x) ;; used for `string-trim'

(defun query-replace-from-file (replace-file target-file &optional delim)
  "Perform query and replace on TARGET-FILE using REPLACE-FILE.

The REPLACE-FILE should be formatted such that each query/replacement pair is on
a new line and the query is separated from the replacement by DELIM. DELIM is
whitespace by default, and should be a regexp."
  (interactive "fFile with query and replace: \nfTarget file: ")
  (let ((split-pos 0)
        (query "")
        (replace "")
        (more-lines t))
    (find-file target-file)
    (goto-char 1)
    (set-buffer (find-file replace-file))
    (goto-char 1)
    ;; Iterate over each line in replace-file
    (while more-lines
      (set-buffer (find-file replace-file))
      ;; Find the delimiter
      (re-search-forward (or (regexp-quote delim) "[[:space:]]") nil t)
      (setq split-pos (1- (point)))
      ;; Set the query variable
      (beginning-of-line)
      (setq query (string-trim
                   (buffer-substring-no-properties (point) split-pos)))
      ;; Set the replace variable
      (end-of-line)
      (setq replace (string-trim
                     (buffer-substring-no-properties split-pos (point))))

      ;; Replace the text in the target-file
      (with-current-buffer (find-file target-file)
        (goto-char 1)
        (while (and (not (equal "" query))
                    (re-search-forward (regexp-quote query) nil t))
          (replace-match replace))
        (save-buffer))
      ;; Go to the next line
      (set-buffer (find-file replace-file))
      (setq more-lines (= 0 (forward-line))))))

(provide 'query)
;;; query.el ends here
