
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;                              CSP-RULES / GENERIC
;;;                              BIVALUE-CHAIN[2]
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
               ;;;                                                    ;;;
               ;;;              copyright Denis Berthier              ;;;
               ;;;     https://denis-berthier.pagesperso-orange.fr    ;;;
               ;;;             January 2006 - August 2020             ;;;
               ;;;                                                    ;;;
               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



; -*- clips -*-





;;; SPECIAL CASE. DO NOT USE THE AUTOMATIC GENERATOR


(defrule activate-bivalue-chain[2]
	(declare (salience ?*activate-bivalue-chain[2]-salience*))
	(logical (play) (context (name ?cont)))
	(not (deactivate bivalue-chain))
=>
	(if ?*print-levels* then (printout t Entering_level_BC2))
	(assert (technique ?cont bivalue-chain[2]))
	(bind ?*technique* BC[2])
)



(defrule track-bivalue-chain[2]
	(declare (salience ?*activate-bivalue-chain[2]-salience*))
	?level <- (technique ?cont bivalue-chain[2])
=>
	(if ?*print-levels* then (printout t _with_ ?level crlf))
)



(defrule bivalue-chain[2]
	(declare (salience ?*bivalue-chain[2]-salience*))
	(chain
		(type bivalue-chain)
		(context ?cont)
		(length 2)
		(llcs $?llcs)
		(rlcs $?rlcs)
		(csp-vars $?csp-vars)
		(last-rlc ?last-rlc)
	)
	
	(exists-link ?cont ?zzz ?last-rlc)
	(exists-link ?cont ?zzz ?uuu&:(eq ?uuu (first $?llcs)))
	?cand <- (candidate (context ?cont) (status cand) (label ?zzz))
=>
	(retract ?cand)
	(if (eq ?cont 0) then (bind ?*nb-candidates* (- ?*nb-candidates* 1)))
	(if (or ?*print-actions* ?*print-L2* ?*print-bivalue-chain* ?*print-bivalue-chain-2*) then
		(print-bivalue-chain 2 ?zzz $?llcs $?rlcs $?csp-vars)
	)
)



(defrule partial-bivalue-chain[2]
	(declare (salience ?*partial-bivalue-chain[2]-salience*))
	(logical
        ;;; as bivalue chains are reversible, one might think that one can always choose a starting direction
        ;;; But NO, because the next rules extend it only to the right
		;;;; (bivalue ?cont ?llc1 ?rlc1&:(< ?llc1 ?rlc1) ?csp1) ;;; <<<< corrected 2013/08/20
		
        (bivalue ?cont ?llc1 ?rlc1 ?csp1)
		
        (technique ?cont bivalue-chain[2])
        ;;; ?new-llc
		(exists-link ?cont ?new-llc&~?llc1 ?rlc1)
        ;;; ?new-rlc and ?new-csp
        ;;; the following condition implies that new-csp is not a csp variable for llc1 or rlc1
		(bivalue ?cont ?new-llc ?new-rlc&~?llc1&~?rlc1 ?new-csp&~?csp1)
	)
=>
	(assert 
        (chain
			(type bivalue-chain)
			(context ?cont)
			(length 2)
			(llcs ?llc1 ?new-llc)
			(rlcs ?rlc1 ?new-rlc)
			(csp-vars ?csp1 ?new-csp)
			(last-rlc ?new-rlc)
		)
	)
)

