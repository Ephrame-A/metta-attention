; !(import! &self utils)
(= (write_csv_wrapper $afAtoms)
    (let $snapshot
        (collapse (AFsnapshot $afAtoms))
        (eval (recurse $snapshot () $systemPath\metta-attention\experiments\utils\log.csv));replace system path
    )
)

(= (toString $s) (py-call (str $s)))
(= (writeData $file $data) 
   (let* (
   ($pt (toString $file))
   ($dt (toString ($data)))
   ($i (py-call (tuple  ($data))))
   ($processed (py-call (numpy.array $i object))))
   (py-call (numpy.savetxt $pt $processed (toString %s))
   ))
)


(= (as-row $pattern $sti $lti)
   (let $z (py-call (dict
                       ((timestamp (get-time))
                       (pattern $pattern)
                       (sti $sti)
                       (lti $lti))
                       ))
                       (py-call (str $z))))

(= (get-time) (let $t (py-call (time.time)) (py-call (time.ctime $t))))
(= (recurse $afAtoms $holder $path) 
    (if (== $afAtoms ())
        (let* (
                ($x (toString $path))
                ($z (py-call (open $x)))
                ($w (union-atom $z $holder)))
                (writeData $path $w))
    (let* (
            ((($a $s $l) $tail) (decons-atom $afAtoms))
            ($res (as-row $a $s $l))
            ($newH (cons-atom $res $holder)))
            (recurse $tail $newH $path) )))
    
(= (AFsnapshot $afAtoms)
    (if (== $afAtoms ())
        ()
        (let* 
            (
                ($atom (superpose $afAtoms))
                ((AV $s $l $vl) (getAv $atom))
            ) 
            ($atom $s $l) 
        ))
    
)

(= (start_log $attentionParam $file)
    (let $param
        (start_logger $file)
        (let $val (collapse (get-atoms $attentionParam)) (save_params $val))
    )
)


