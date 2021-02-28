;
; Block Batch Command.
; Executes commands to a selection of blocks inserted at 0,0,0
; Available commands: move, copy, stretch, mirror and erase.
; Default selection method: Window, except for Stretch (Crossing)
;
;
; by Ricardo Velozo 8/2013
;
; 2/28/14: Added Mirror
;
(defun C:BBC ( / P1 P2 P3 P4 SSEnts n blk Ncommand)
  
  (initget "Move Copy Stretch mIrror Erase Line")
  (setq Ncommand (getkword "\nCommand to batch execute (Move/Copy/Stretch/mIrror/Erase/Line): "))
  (princ Ncommand)

  (prompt "\nSelect blocks: ")
  (setq SSEnts (ssget '((0 . "INSERT")))) 

  (setq P1 (getpoint "\nStart selection point for block editor: "))
  (initget 32)
  (setq P2 (getcorner P1 "\nEnd point: "))
  (if (/= Ncommand "Erase")
	(progn
		(setq P3 (getpoint "\nStart base point: "))
		(initget 32)
		(setq P4 (getpoint P3 "\nEnd point: "))	
	)
	(progn
		(setq P3 '(1 1 1))
		(setq P4 '(1 1 1))
	)
  )
 
  (setq OldOsmode (getvar "OSMODE"))
  (setvar "OSMODE" 0)
 
  (setq n 0)
  (setq blk (ssname SSEnts n))
    (while (/= blk nil)
    	(setq BlockName (cdr (assoc 2 (entget blk))))
		
		(setq transformVector (cdr (assoc 10 (entget blk))))
		(setq P11 (mapcar '- P1 transformVector))
		(setq P22 (mapcar '- P2 transformVector))
		(setq P33 (mapcar '- P3 transformVector))
		(setq P44 (mapcar '- P4 transformVector))
				
        (ExecuteCommand P11 P22 P33 P44 BlockName Ncommand)
        
		(setq n (1+ n))
        (setq blk (ssname SSEnts n))
  )
  (setvar 'cmdecho 1)
  (setvar "OSMODE" OldOsmode)
  
)

(defun ExecuteCommand (Pa Pb Pc Pd blk Ncommand / )
  (command "_.bedit" blk)
  (cond
    ((= Ncommand "Move")
		(progn
			(command "Move" "w" Pa Pb "" Pc Pd)
		)
	)
    ((= Ncommand "Copy")
		(progn
			(command "Copy" "w" Pa Pb "" Pc Pd)
		)
	)
    ((= Ncommand "Stretch")
		(progn
			(command "Stretch" "c" Pa Pb "" Pc Pd)
		)
	)
	 ((= Ncommand "mIrror")
		(progn
			(command "Mirror" "w" Pa Pb "" Pc Pd "Y")
		)
	)
    ((= Ncommand "Erase")
		(progn
			(command "Erase" "w" Pa Pb "")
		)
	)
    ((= Ncommand "Line")
		(progn
			(command "Line" Pa Pb "")
		)
	)
  )
    (command "_.bclose" "S")
)
(prompt "\n\n - New command: BBC.")
