
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;                              CSP-RULES / GENERIC
;;;                              BIVALUE-CHAIN[12]
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





(defrule activate-bivalue-chain[12]
   (declare (salience ?*activate-bivalue-chain[12]-salience*))
   (logical (play) (context (name ?cont)))
   (not (deactivate ?cont bivalue-chain))
=>
   (if ?*print-levels* then (printout t Entering_level_BC12))
   (assert (technique ?cont bivalue-chain[12]))
   (bind ?*technique* BC[12])
)



(defrule track-bivalue-chain[12]
   (declare (salience ?*activate-bivalue-chain[12]-salience*))
   ?level <- (technique ?cont bivalue-chain[12])
=>
   (if ?*print-levels* then (printout t _with_ ?level crlf))
)



;;; bivalue-chain elimination rule

(defrule bivalue-chain[12]
   (declare (salience ?*bivalue-chain[12]-salience*))
   (chain
      (type bivalue-chain)
      (context ?cont)
      (length 12)
      (llcs $?llcs)
      (rlcs $?rlcs)
      (csp-vars $?csp-vars)
      (last-rlc ?last-rlc)
   )
   
   (exists-link ?cont ?zzz ?last-rlc)
   (exists-link ?cont ?zzz ?uuu1&:(eq ?uuu1 (first $?llcs)))
   ?cand <- (candidate (context ?cont) (status cand) (label ?zzz))
=>
   (retract ?cand)
   (if (eq ?cont 0) then (bind ?*nb-candidates* (- ?*nb-candidates* 1)))
   (if (or ?*print-actions* ?*print-L12* ?*print-bivalue-chain* ?*print-bivalue-chain-12*) then
      (print-bivalue-chain 12 ?zzz $?llcs $?rlcs $?csp-vars)
   )
)



;;; extension of an existing bivalue-chain with a pair of candidates

(defrule partial-bivalue-chain[12]
   (declare (salience ?*partial-bivalue-chain[12]-salience*))
   (logical
      (chain
         (type bivalue-chain)
         (context ?cont)
         (length 11)
         (llcs $?llcs)
         (rlcs $?rlcs)
         (csp-vars $?csp-vars)
         (last-rlc ?last-rlc)
      )
      
      (technique ?cont bivalue-chain[12])
      ;;; ?new-llc
      (exists-link ?cont ?new-llc&:(not (member$ ?new-llc $?llcs))&:(not (member$ ?new-llc $?rlcs)) ?last-rlc)
      ;;; ?new-rlc and ?new-csp
      ;;; the following condition implies that new-csp is not a csp variable for zzz or any of the previous rlcs
      (bivalue
         ?cont
         ?new-llc
         ?new-rlc&:(not (member$ ?new-rlc $?llcs))&:(not (member$ ?new-rlc $?rlcs))
         ?new-csp&:(not (member$ ?new-csp $?csp-vars))
      )
   )
=>
   (assert
      (chain
         (type bivalue-chain)
         (context ?cont)
         (length 12)
         (llcs $?llcs ?new-llc)
         (rlcs $?rlcs ?new-rlc)
         (csp-vars $?csp-vars ?new-csp)
         (last-rlc ?new-rlc)
      )
   )
)



