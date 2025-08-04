
; this function take atoms from typespace and return atoms found inside the largest bin index

(: getMaxContent (-> List))
(= (getMaxContent)
    (let* (
        ($atombin (typespace))
        ($numbers (collapse (match $atombin ($p $v (Bin $b)) $b)))
        )
    (if (== $numbers ()) (Empty Bin) (
        let* (
        ($max (max-atom $numbers))
        ($content (match (typespace) ($patt $val $max) $patt))
        )

        $content
    )
    )
    )
)


; this function take atoms from typespace and return atoms found inside the smallest bin index

(: getMinContent (-> List))
(= (getMinContent)
    (let* (
        ($atombin (typespace))
        ($numbers (collapse (match $atombin ($p $v $b) $b)))
        )
    (if (== $numbers ()) (Empty Bin) (
        let* (
        ($max (min-atom $numbers))
        ($content (match (typespace) ($patt $val $max) $patt))
        )

        $content
    )
    )
    )
)
; this function takes a bin number and return the number of atoms found in that bin
(= (getSize $binNumber)
    (let* (
        ($atoms (collapse (match (typespace) ($p $v $binNumber) $p)))
    )
        (size-atom $atoms)
    )
)

;Function: binSize
;Description: Calculates the total number of atoms across all bins in &typespace.
;             It retrieves all bin indices and computes the cumulative sum of their sizes.
;Parameters: None.
;Returns: The total number of atoms across all bins.
(: binSize (-> Number))
(= (binSize)
   (let* (
      ($atombin (typespace))
      ($indices (collapse (match $atombin ($p $v $x) $x)))
      ($binsSize (sumSizes $indices)) 
    )
    $binsSize
  )
)

;Function: sumSizes
;Description: Recursively computes the total number of atoms across all bins in a given list of bin indices.
;             It iterates through the list of indices, retrieves the size of each bin, and sums them up.
;Parameters:
;          $indices: A list of bin indices whose sizes should be summed.
;Returns: The cumulative size of all bins in the given list.
(: sumSizes (-> Expression Number))
(= (sumSizes $indices)
   (if (== $indices ())
      0
      (let* (
             ($index (car-atom $indices))
             ($rest (cdr-atom $indices))
             ($remainingSize (sumSizes $rest))
            )
        (+ (getSize $index) $remainingSize)
       )
    )
)

(= (getMaxBin)
    (let $x (match (typespace) ($p $v (Bin $b)) $b) (max-atom $x))
)

(: getRandomAtom (-> Symbol))
(= (getRandomAtom)
    (let* (
            ($l (getMaxBin))
            ($rand (random-int &rng 0 $l))
            ($matched (if (== (getsize $rand) 0) () (collapse (match (typespace) ($p $v (Bin $rand)) $p))) )
          ) (if (== $matched ()) (getRandomAtom) (car-atom $matched))
     
))

