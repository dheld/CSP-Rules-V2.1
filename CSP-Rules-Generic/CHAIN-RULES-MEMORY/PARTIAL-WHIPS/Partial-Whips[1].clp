
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;                              CSP-RULES / GENERIC
;;;                              PARTIAL-WHIP[1]
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


(defrule partial-whip[1]
	(declare (salience ?*partial-whip[1]-salience*))
	(logical
        ;;; ?llc1
        (exists-link ?cont ?llc1 ?zzz)
        ;;; the following condition implies that, in case t-whips are active,
        ;;; the fact that the solution (or part of it) is known will not be used to restrict the targets
        (or (t-Whips)
            (test (not (known-to-be-in-solution ?zzz)))
        )

		(technique ?cont partial-whip[1])
		(csp-linked ?cont ?llc1 ?rlc1&~?zzz ?csp1)
	)
	
    ;;; the following condition implies that ?csp1 is not a csp variable for ?zzz
    ;;; as there is no whip[1] for ?zzz, it also implies that ?rlc1 is not linked to ?zzz
	(forall (csp-linked ?cont ?llc1 ?xxx&~?rlc1 ?csp1) (test (linked ?xxx ?zzz)))

    ;;; do not assert different partial whips with the same sequences of rlc's
	(not
		(chain
            (type partial-whip)
            (context ?cont)
            (length 1)
			(target ?zzz)
            (rlcs ?rlc1)
		)
	)
=>
	(assert 
		(chain
            (type partial-whip)
            (context ?cont)
            (length 1)
			(target ?zzz)
			(llcs ?llc1)
            (rlcs ?rlc1)
            (csp-vars ?csp1)
            (last-rlc ?rlc1)
		)
	)
)


