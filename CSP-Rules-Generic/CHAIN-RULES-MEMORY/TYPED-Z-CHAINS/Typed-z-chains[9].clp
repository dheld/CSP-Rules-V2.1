
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;                              CSP-RULES / GENERIC
;;;                              TYPED-Z-CHAIN[9]
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





(defrule activate-typed-z-chain[9]
   (declare (salience ?*activate-typed-z-chain[9]-salience*))
   (logical (play) (context (name ?cont)))
   (not (deactivate ?cont typed-z-chain))
=>
   (if ?*print-levels* then (printout t Entering_level_TyZ9))
   (assert (technique ?cont typed-z-chain[9]))
   (assert (technique ?cont typed-partial-z-chain[8]))
   (bind ?*technique* typed-z-chain[9])
)



(defrule track-typed-z-chain[9]
   (declare (salience ?*activate-typed-z-chain[9]-salience*))
   ?level <- (technique ?cont typed-z-chain[9])
=>
   (if ?*print-levels* then (printout t _with_ ?level crlf))
)



;;; typed-z-chain elimination rule

(defrule typed-z-chain[9]
   (declare (salience ?*typed-z-chain[9]-salience*))
   (typed-chain
      (type typed-partial-z-chain)
      (csp-type ?csp-type)
      (context ?cont)
      (length 8)
      (target ?zzz)
      (llcs $?llcs)
      (rlcs $?rlcs)
      (csp-vars $?csp-vars)
      (last-rlc ?last-rlc)
   )
   
   ;;; ?new-llc
   (exists-link ?cont ?new-llc&~?zzz&:(not (member$ ?new-llc $?llcs))&:(not (member$ ?new-llc $?rlcs)) ?last-rlc)
   
   (is-typed-csp-variable-for-label (csp-var ?new-csp&:(not (member$ ?new-csp $?csp-vars))) (label ?new-llc) (csp-var-type ?csp-type))
   ;;; because, in a partial typed-z-chain, ?zzz cannot be linked to any candidate in $?rlcs
   ;;; the following condition implies that ?zzz is not linked to ?new-llc by ?new-csp
   ;;; i.e. that ?zzz is not a candidate for ?new-csp
   (forall (typed-csp-linked ?cont ?new-llc ?xxx ?new-csp ?csp-type) (test (linked ?xxx ?zzz)))
   ?cand <- (candidate (context ?cont) (status cand) (label ?zzz))
=>
   (retract ?cand)
   (if (eq ?cont 0) then (bind ?*nb-candidates* (- ?*nb-candidates* 1)))
   (if (or ?*print-actions* ?*print-L9* ?*print-typed-z-chain* ?*print-typed-z-chain-9*) then
      (print-typed-z-chain ?csp-type 9 ?zzz $?llcs $?rlcs $?csp-vars ?new-llc . ?new-csp)
   )
)



;;; extension of an existing typed-partial-z-chain

(defrule typed-partial-z-chain[8]
   (declare (salience ?*typed-partial-z-chain[8]-salience*))
   (logical
      (typed-chain
         (type typed-partial-z-chain)
         (csp-type ?csp-type)
         (context ?cont)
         (length 7)
         (target ?zzz)
         (llcs $?llcs)
         (rlcs $?rlcs)
         (csp-vars $?csp-vars)
         (last-rlc ?last-rlc)
      )
      
      ;;; ?new-llc
      (exists-link ?cont ?new-llc&~?zzz&:(not (member$ ?new-llc $?llcs))&:(not (member$ ?new-llc $?rlcs)) ?last-rlc)
      
      ;;; ?new-rlc and ?new-csp
      (technique ?cont typed-partial-z-chain[8])
      ;;; because typed-z-chains[8] based on ?zzz (if any) have already been eliminated,
      ;;; there is at least one ?new-rlc not linked to ?zzz
      (typed-csp-linked
         ?cont
         ?new-llc
         ?new-rlc&~?zzz&:(not (member$ ?new-rlc $?llcs))&:(not (member$ ?new-rlc $?rlcs))
         ?new-csp&:(not (member$ ?new-csp $?csp-vars))
         ?csp-type
      )
      ;;; the next condition will detect cases when there is only one
   )
   
   ;;; as typed-z-chains[8] have been eliminated (because they have higher salience),
   ;;; the following implies that new-rlc must be the only non-z candidate for new-csp
   (forall (typed-csp-linked ?cont ?new-llc ?xxx&~?new-rlc ?new-csp ?csp-type) (test (linked ?xxx ?zzz)))
   
   ;;; do not assert different partial typed-z-chains with the same sequences of rlc's
   (not
      (typed-chain
         (type typed-partial-z-chain)
         (csp-type ?csp-type)
         (context ?cont)
         (length 8)
         (target ?zzz)
         (rlcs $?rlcs ?new-rlc)
      )
   )
=>
   (assert
      (typed-chain
         (type typed-partial-z-chain)
         (csp-type ?csp-type)
         (context ?cont)
         (length 8)
         (target ?zzz)
         (llcs $?llcs ?new-llc)
         (rlcs $?rlcs ?new-rlc)
         (csp-vars $?csp-vars ?new-csp)
         (last-rlc ?new-rlc)
      )
   )
)



