!(import! &self ../../../../PeTTa/lib/lib_he)
!(import! &self ../../../../PeTTa/lib/lib_spaces)
!(import! &self ../../../../metta-attention/attention/AttentionParam)
!(import! &self ../../../../metta-attention/attention-bank/utilities/helper-functions)
!(import! &self ../../../../metta-attention/attention-bank/bank/importance-index/importance-index)
!(import! &self ../../../../metta-attention/attention-bank/attention-value/getter-and-setter)
!(import! &self ../../../../metta-attention/attention-bank/bank/attention-bank)
!(import! &self ../../../../metta-attention/experiments/logger)
!(import! &self "../../../../metta-attention/experiments/utils/logger.py")
!(import! &self ../../../../metta-attention/attention-bank/bank/attentional-focus/attentional-focus)
!(import! &self ../../../../metta-attention/attention-bank/utilities/recentVal)
!(import! &self ../../../../metta-attention/attention/Neighbors)
!(import! &self ../../../../metta-attention/attention/HebbianCreationAgent/HebbianCreationAgent)

!(bind! &d (new-space))
!(import! &d data)
(= (count) 50)
!(updateAttentionParam MAX_AF_SIZE (count))
; !(bind! 900.0.0 900.0.0)
; Populate the AtomSpace with the example atoms




; Stimulate the atoms in the AttentionalFocus with a stimulus of 200
(= (runner $time)
        (let $x (collapse (HebbianCreationAgent-Run (TypeSpace)))
        (running time is (- (py-call (time.time)) $time))
    )
)

!(match &d ($pattern) (stimulate $pattern 50.0))
!(runner (py-call (time.time)))
;Confirm that 105*(105-1) = 10920 AsymmetricHebbianLinks were formed,
;indicating that none incorrectly include "slimy" nor the dummy atoms
!(let $afAtoms
    (getAfAtoms)
    (test (size-atom $afAtoms) (count))
)

; !(collapse (match (TypeSpace) ((ASYMMETRIC_HEBBIAN_LINK $x $y) $value) (ASYMMETRIC_HEBBIAN_LINK $x $y)))

!(test   
    (let $atoms (collapse 
                    (match (TypeSpace) ((ASYMMETRIC_HEBBIAN_LINK $x $y) $value) 
                            (ASYMMETRIC_HEBBIAN_LINK $x $y))) (size-atom $atoms))
    (* (count) (- (count) 1))
)
!(test (size-atom (collapse (match (TypeSpace) ((ASYMMETRIC_HEBBIAN_LINK Node1 $v) $val) $v))) (- (count) 1))