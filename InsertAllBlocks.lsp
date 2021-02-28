; Blocks all inserted at 0,0
(defun C:B00 (/ blk blklist)
	(setq BlockInitial (strcase (getstring "\nStart string: ")))
	(while (setq blk (cdadr (tblnext "block" (not blk)))); list of Block names
		(setq blklist (cons (strcase blk) blklist))
	)
	
	(setvar 'cmdecho 0)
	(foreach blk blklist
		(if
			(and
				(not (= (substr blk 1 1) "*")); not Dimension, for instance
				(/= (logand 4 (cdr (assoc 70 (tblsearch "block" blk)))) 4); not Xref
				(not (wcmatch blk "*|*")); not Xref-dependent
				(= BlockInitial (substr blk 1 (strlen BlockInitial)))
			)
				(command "_.insert" blk "_non" "0,0" "" "" "")
		)
	)
(setvar 'cmdecho 1); or save it earlier and restore saved value...
)
