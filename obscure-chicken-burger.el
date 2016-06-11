
(defvar *chicken-burger* ())
(defun chicken-burger-ify ()
  (interactive)
  (let ((word (thing-at-point 'word t)))           ;
    (if word
        (progn
          (push word *chicken-burger*)
          (message "%s haz become chicken" word)))))

(defvar *dirty-stuff* "/home/fabian/.emacs.d/dirty-stuff")

(defvar *dirty-lines* ())

(defvar *rand-numbers* ())

(defun read-lines (filePath)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

(defun transform-word (mundane)
  (let ((num (random (length *dirty-lines*))))
    (if (null (find num *rand-numbers*))
        (progn
            (push num *rand-numbers*)
            (elt *dirty-lines* num)
        )
        (transform-word mundane)
      )))

(defun show-the-might-of-the-tofu-burger ()
  (interactive)
  (set '*rand-numbers* ())
  (set '*dirty-lines* (read-lines *dirty-stuff*))
  (let ((burgers (mapcar #'transform-word *chicken-burger*)))
    (loop for i from 0 below (length burgers) do
          (message "index %d: %s to %s" i (elt *chicken-burger* i) (elt burgers i))
          (beginning-of-buffer)
          (replace-string (elt *chicken-burger* i) (elt burgers i) t nil nil))))
