;;; math.el --- description -*- lexical-binding: t; -*-
;;; Commentary:
;;; A collection of mathematical functions.

;;; Code:

(defun sum-to-n (i n &optional val)
  "Return the sum from I..N (VAL is used to pass the sum down the recursion)."
  (let ((val (or val 0)))
    (if (= i n)
      val
    (sum-to-n (1+ i) n (+ i val)))))

(defun factorial (n &optional i val)
  "Return the factorial of N (I and VAL are used for the recursion).
This is only useful for small numbers of N, because of overflow."
  (let ((i (or i 1))
        (val (or val 1)))
    (if (> i n)
        val
      (factorial n (1+ i) (* i val)))))

(provide 'math)
;;; math.el ends here
