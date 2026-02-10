!(import! &self ../../../../../PeTTa/lib/lib_he)
!(import! &self ../../../../../PeTTa/lib/lib_spaces)
!(import! &self ../../../../../metta-attention/attention/AttentionParam)
!(import! &self ../../../../../metta-attention/attention-bank/utilities/helper-functions)
!(import! &self ../../../../../metta-attention/attention-bank/attention-value/getter-and-setter)
!(import! &self ../../../../../metta-attention/attention-bank/bank/attention-bank)
!(import! &self ../../../../../metta-attention/attention-bank/utilities/recentVal)
!(import! &self ../../../../../metta-attention/attention-bank/bank/attentional-focus/attentional-focus)
!(import! &self ../../../../../metta-attention/attention-bank/bank/importance-index/importance-index)
!(import! &self ../../../../../metta-attention/attention/Neighbors)
!(import! &self ../../../../../metta-attention/attention/ImportanceDiffusionAgent/ImportanceDiffusionBase/ImportanceDiffusionBase)
!(import! &self ../../../../../metta-attention/attention/ImportanceDiffusionAgent/AFImportanceDiffusionAgent/AFImportanceDiffusionAgent)
!(bind! &data (new-space))
!(bind! &node (new-space))
!(import! &data file)
!(import! &node nodes)
!(updateAttentionParam MAX_AF_SIZE 50.0)

;; Set TV for links and stimulate all nodes in the chain
!(match &data (INHERITANCE_LINK $s $t) 
    (setStv (INHERITANCE_LINK $s $t) (0.5 0.8))
)
!(match &node ($x) (stimulate $x 50))
;; Run 50 cycles to match C++ cycles
(= (run-cycles $num $time)
    (if (== $num 0) (running time is (- (py-call (time.time)) $time))
        (let $x (collapse (AFImportanceDiffusionAgent-Run (TypeSpace)))
        (run-cycles (- $num 1) $time))
    )
)

!(getAv node_0)
!(run-cycles 50 (py-call (time.time)))




;; Verification: Check sample nodes' STI
!(getSti node_0)
!(getSti node_50)
!(getSti node_500)

;; Verification: Check sample links' STI
!(getSti (INHERITANCE_LINK node_0 node_1))
!(getSti (INHERITANCE_LINK node_0 node_2))
!(getSti (INHERITANCE_LINK node_0 node_3))
!(getSti (INHERITANCE_LINK node_400 node_401))
!(getSti (INHERITANCE_LINK node_500 node_502))
!(getSti (INHERITANCE_LINK node_998 node_999))
!(getAfAtoms)
!(diffusion with 50 cycle and 50af)