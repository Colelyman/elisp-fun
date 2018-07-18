;;; math.el --- description -*- lexical-binding: t; -*-
;;; Commentary:
;;; A collection of mathematical functions.

;;; Code:

(defun sum-to-n (i n &optional val)
  "Return the sum from I..N (VAL is used to pass the sum down the recursion)."
  (let ((val (or val 0)))
    (if (= i n)
      val
    (sum (1+ i) n (+ i val)))))

(provide 'math)
;;; math.el ends here
