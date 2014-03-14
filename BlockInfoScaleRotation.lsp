```
(defun LB ( / b tp SC)
  (setq SC nil)
  (while (/= tp "INSERT")
    (setq b (entsel "\nSelect block: "))
    (setq tp (cdr (assoc 0 (entget (car b)))))
  )
  (while b
    (if b
      (progn
        (prompt (strcat "\n Block name: " (cdr (assoc 2 (entget (car b))))))
	(setq sc (strcat "    Scale: " (rtos 
                                          (cdr 
                                            (assoc 41 
                                              (entget 
                                                (car b)
                                              )
                                            )
                                          )
                                     2 2)
                 )
        )
        (prompt sc)
      )
      (prompt "No block selected.")
    )
    (setq b (entsel "\nSelect block "))
  )
  (princ)
)
```
