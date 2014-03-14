```
(defun LB ( / b tp SC)
  (setq SC nil)
  (while (/= tp "INSERT")
    (setq b (entsel "\nSelecione o bloco: "))
    (setq tp (cdr (assoc 0 (entget (car b)))))
  )
  (while b
    (if b
      (progn
        (prompt (strcat "\n Bloco: " (cdr (assoc 2 (entget (car b))))))
	(setq sc (strcat "    Escala: " (rtos 
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
      (prompt "Nenhum bloco foi selecionado.")
    )
    (setq b (entsel "\nSelecione o bloco: "))
  )
  (princ)
)
```
