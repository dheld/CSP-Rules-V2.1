
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;                              CSP-RULES / GENERIC
;;;                              ODDAGON[11]
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





(defrule activate-oddagon[11]
   (declare (salience ?*activate-oddagon[11]-salience*))
   (logical (play) (context (name ?cont)))
   (not (deactivate ?cont oddagon))
=>
   (if ?*print-levels* then (printout t Entering_level_O11))
   (assert (technique ?cont partial-oddagon[10]))
   (assert (technique ?cont oddagon[11]))
   (bind ?*technique* O[11])
)



(defrule track-oddagon[11]
   (declare (salience ?*activate-oddagon[11]-salience*))
   ?level <- (technique ?cont oddagon[11])
=>
   (if ?*print-levels* then (printout t _with_ ?level crlf))
)



;;; partial-oddagon extension rule

(defrule partial-oddagon[10]
   (declare (salience ?*partial-oddagon[10]-salience*))
   (logical
      (csp-chain
         (type partial-oddagon)
         (context ?cont)
         (length 8)
         (target ?zzz)
         (first-cand ?cand1)
         (rlcs $?cands)
         (last-rlc ?last-rlc)
         (csp-vars $?csp-vars)
      )
      
      (technique ?cont partial-oddagon[10])
      (csp-linked ?cont ?last-rlc ?new-rlc1&:(< ?cand1 ?new-rlc1) ?new-csp1&:(not (member$ ?new-csp1 $?csp-vars)))
      (forall (csp-linked ?cont ?last-rlc ?xxx&~?new-rlc1 ?new-csp1)
         (exists-link ?cont ?xxx ?zzz)
      )
      
      (csp-linked ?cont ?new-rlc1 ?new-rlc2&:(< ?cand1 ?new-rlc2) ?new-csp2&~?new-csp1&:(not (member$ ?new-csp2 $?csp-vars)))
      (forall (csp-linked ?cont ?new-rlc1 ?xxx&~?new-rlc2 ?new-csp2)
         (exists-link ?cont ?xxx ?zzz)
      )
   )
      
   ;;; do not assert different partial oddagons with the same sequences of rlc's
   (not
      (csp-chain
         (type partial-oddagon)
         (context ?cont)
         (length 10)
         (target ?zzz)
         (first-cand ?cand1)
         (rlcs $?cands ?new-rlc1 ?new-rlc2)
      )
   )
=>
   (assert
      (csp-chain
         (type partial-oddagon)
         (context ?cont)
         (length 10)
         (target ?zzz)
         (first-cand ?cand1)
         (rlcs $?cands ?new-rlc1 ?new-rlc2)
         (csp-vars $?csp-vars ?new-csp1 ?new-csp2)
         (last-rlc ?new-rlc2)
      )
   )
)



;;; oddagon rule

(defrule oddagon[11]
   (declare (salience ?*oddagon[11]-salience*))
   (logical
      (csp-chain
         (type partial-oddagon)
         (context ?cont)
         (length 10)
         (target ?zzz)
         (first-cand ?cand1)
         (rlcs $?rlcs)
         (csp-vars $?csp-vars)
         (last-rlc ?last-rlc)
      )
   
      ;;; ?Last csp
      (csp-linked ?cont ?last-rlc ?cand1 ?new-csp&:(not (member$ ?new-csp $?csp-vars)))
      (forall (csp-linked ?cont ?last-rlc ?xxx&~?cand1 ?new-csp)
         (exists-link ?cont ?xxx ?zzz)
      )
   )

   ?cand <- (candidate (context ?cont) (status cand) (label ?zzz))
=>
   (retract ?cand)
   (if (eq ?cont 0) then (bind ?*nb-candidates* (- ?*nb-candidates* 1)))
   (if (or ?*print-actions* ?*print-L11* ?*print-oddagon* ?*print-oddagon-11*) then
      (print-oddagon 11 ?zzz (create$ $?rlcs ?cand1) (create$ $?csp-vars ?new-csp))
   )
)



