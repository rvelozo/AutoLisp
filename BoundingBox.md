
```(defun LM:SSBoundingBox ( ss / bb )
  (vl-load-com)
  ;; © Lee Mac 2010
  
  (
    (lambda ( i / e ll ur )
      (while (setq e (ssname ss (setq i (1+ i))))
        (vla-getBoundingBox (vlax-ename->vla-object e) 'll 'ur)

        (setq bb (cons (vlax-safearray->list ur)
                       (cons (vlax-safearray->list ll) bb))
        )
      )
    )
    -1
  )
  (
    (lambda ( data )
      (mapcar
        (function
          (lambda ( funcs )
            (mapcar
              (function
                (lambda ( func ) ((eval func) data))
              )
              funcs
            )
          )
        )
       '((caar cadar) (caadr cadar) (caadr cadadr) (caar cadadr))
      )
    )
    (mapcar
      (function
        (lambda ( operation )
          (apply (function mapcar) (cons operation bb))
        )
      )
     '(min max)
    )
  )
)


(defun c:test ( / ss )
  (vl-load-com)

  (if (setq ss (ssget))
    (vla-put-closed
      (vlax-invoke
        (vlax-get-property (vla-get-ActiveDocument (vlax-get-acad-object))
          (if (= 1 (getvar 'CVPORT)) 'Paperspace 'Modelspace)
        )
        'AddLightWeightPolyline      
        (apply (function append) (LM:SSBoundingBox ss))
      )
      :vlax-true
    )
  )

  (princ)
)```
