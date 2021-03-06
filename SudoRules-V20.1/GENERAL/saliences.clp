
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;                              CSP-RULES / SUDORULES
;;;                              SALIENCES
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
               ;;;                                                    ;;;
               ;;;              copyright Denis Berthier              ;;;
               ;;;     https://denis-berthier.pagesperso-orange.fr    ;;;
               ;;;            January 2006 - August 2020              ;;;
               ;;;                                                    ;;;
               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



; -*- clips -*-





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; NO CONFLUENCE RULES
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; Rules for uniqueness
;;; Non uniqueness of a solution should be detected as soon as possible
;;; but in a way compatible with all the other constraints

(defglobal ?*ur1-salience* = 0)
(defglobal ?*ur2-salience* = 0)
(defglobal ?*ur2b-salience* = 0)
(defglobal ?*ur3-salience* = 0)
(defglobal ?*ur4-salience* = 0)
(defglobal ?*ur4b-salience* = 0)
(defglobal ?*hur-salience* = 0)
(defglobal ?*bug-salience* = 0)
(defglobal ?*uniqueness-salience* = 0)

;;; Rules for sk-loops

(defglobal ?*cross-salience* = 0)
(defglobal ?*belt4-salience* = 0)
(defglobal ?*belt4-identify-salience* = 0)
(defglobal ?*belt4-elim-rows-salience* = 0)
(defglobal ?*belt4-elim-columns-salience* = 0)
(defglobal ?*belt4-elim-blocks-salience* = 0)
;;; for testing if the x2y2 version is broader:
(defglobal ?*x2y2-segment-salience* = 0)
(defglobal ?*chainable-x2y2-segments-salience* = 0)
(defglobal ?*x2y2-salience* = 0)

(defglobal ?*belt6-salience* = 0)
(defglobal ?*belt6-identify-salience* = 0)
(defglobal ?*belt6-elim-rows-salience* = 0)
(defglobal ?*belt6-elim-columns-salience* = 0)
(defglobal ?*belt6-elim-blocks-salience* = 0)
(defglobal ?*x2y2-belt6-salience* = 0)


(deffunction define-no-confluence-saliences ()
    ;;; Rules for uniqueness
    (bind ?*ur1-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*ur2-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*ur2b-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*ur3-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*ur4-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*ur4b-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*hur-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*bug-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*uniqueness-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    ;;; Rules for sk-loops
    (bind ?*cross-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*belt4-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*belt4-identify-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*belt4-elim-rows-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*belt4-elim-columns-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*belt4-elim-blocks-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    ;;; for testing if the x2y2 version is broader:
    (bind ?*x2y2-segment-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*chainable-x2y2-segments-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*x2y2-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    (bind ?*belt6-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*belt6-identify-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*belt6-elim-rows-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*belt6-elim-columns-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*belt6-elim-blocks-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*x2y2-belt6-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; SUBSETS
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defglobal ?*one-step-candidate-salience* = 0)

(defglobal ?*naked-pairs-salience* = 0)
(defglobal ?*hidden-pairs-salience* = 0)
(defglobal ?*super-hidden-pairs-salience* = 0)
(defglobal ?*x-wing-salience* = 0)
(defglobal ?*finned-x-wing-salience* = 0)

(defglobal ?*activate-z-pairs-salience* = 0)
(defglobal ?*z-pairs-salience* = 0)
(defglobal ?*activate-g-pairs-salience* = 0)
(defglobal ?*g-pairs-salience* = 0)


(defglobal ?*naked-triplets-salience* = 0)
(defglobal ?*hidden-triplets-salience* = 0)
(defglobal ?*super-hidden-triplets-salience* = 0)
(defglobal ?*swordfish-salience* = 0)
(defglobal ?*finned-swordfish-salience* = 0)

(defglobal ?*activate-z-triplets-salience* = 0)
(defglobal ?*z-triplets-salience* = 0)
(defglobal ?*activate-g-triplets-salience* = 0)
(defglobal ?*g-triplets-salience* = 0)


(defglobal ?*activate-cyclic-quads-salience* = 0)
(defglobal ?*naked-cyclic-quads-salience* = 0)
(defglobal ?*hidden-cyclic-quads-salience* = 0)
(defglobal ?*super-hidden-cyclic-quads-salience* = 0)
(defglobal ?*cyclic-quads-salience* = 0)

(defglobal ?*activate-special-quads-salience* = 0)
(defglobal ?*naked-special-quads-salience* = 0)
(defglobal ?*hidden-special-quads-salience* = 0)
(defglobal ?*super-hidden-special-quads-salience* = 0)
(defglobal ?*special-quads-salience* = 0)

(defglobal ?*naked-quads-salience* = 0)
(defglobal ?*hidden-quads-salience* = 0)
(defglobal ?*super-hidden-quads-salience* = 0)
(defglobal ?*jellyfish-salience* = 0)
(defglobal ?*finned-jellyfish-salience* = 0)

(defglobal ?*activate-z-quads-salience* = 0)
(defglobal ?*z-quads-salience* = 0)
(defglobal ?*activate-g-quads-salience* = 0)
(defglobal ?*g-quads-salience* = 0)



(deffunction define-specific-saliences-at-L2 ()
    (bind ?*one-step-candidate-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    (bind ?*activate-pairs-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*naked-pairs-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*hidden-pairs-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*x-wing-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*super-hidden-pairs-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*pairs-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    (bind ?*finned-x-wing-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*activate-z-pairs-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*z-pairs-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    (bind ?*activate-g-pairs-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*g-pairs-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
)


 (deffunction define-specific-saliences-at-L3 ()
    (bind ?*activate-triplets-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*naked-triplets-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*hidden-triplets-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*swordfish-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*super-hidden-triplets-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*triplets-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    (bind ?*finned-swordfish-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*activate-z-triplets-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*z-triplets-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    (bind ?*activate-g-triplets-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*g-triplets-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
)


(deffunction define-specific-saliences-at-L4 ()
    (bind ?*activate-cyclic-quads-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*naked-cyclic-quads-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*hidden-cyclic-quads-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*super-hidden-cyclic-quads-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*cyclic-quads-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    (bind ?*activate-special-quads-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*naked-special-quads-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*hidden-special-quads-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*super-hidden-special-quads-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*special-quads-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    (bind ?*activate-quads-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*naked-quads-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*hidden-quads-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*jellyfish-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    (bind ?*finned-jellyfish-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*activate-z-quads-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*z-quads-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    (bind ?*activate-g-quads-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*g-quads-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; EXOCETS
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defglobal ?*activate-J2-Exocet-salience* = 0)
(defglobal ?*J2-Exocet-elimination-salience* = 0)
(defglobal ?*J2-Exocet-detection-salience* = 0)

(defglobal ?*activate-J3-Exocet-salience* = 0)
(defglobal ?*J3-Exocet-elimination-salience* = 0)
(defglobal ?*J3-Exocet-detection-salience* = 0)

(defglobal ?*activate-J4-Exocet-salience* = 0)
(defglobal ?*J4-Exocet-elimination-salience* = 0)
(defglobal ?*J4-Exocet-detection-salience* = 0)

(defglobal ?*activate-J5-Exocet-salience* = 0)
(defglobal ?*J5-Exocet-elimination-salience* = 0)
(defglobal ?*J5-Exocet-detection-salience* = 0)



(deffunction define-specific-saliences-at-L6 ()
    (bind ?*activate-J2-Exocet-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1))) ;;;; EXOCETS
    (bind ?*J2-Exocet-elimination-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1))) ;;;; EXOCETS
    (bind ?*J2-Exocet-detection-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1))) ;;;; EXOCETS
)

(deffunction define-specific-saliences-at-L9 ()
    (bind ?*activate-J3-Exocet-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1))) ;;;; EXOCETS
    (bind ?*J3-Exocet-elimination-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1))) ;;;; EXOCETS
    (bind ?*J3-Exocet-detection-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1))) ;;;; EXOCETS
)

(deffunction define-specific-saliences-at-L12 ()
    (bind ?*activate-J4-Exocet-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1))) ;;;; EXOCETS
    (bind ?*J4-Exocet-elimination-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1))) ;;;; EXOCETS
    (bind ?*J4-Exocet-detection-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1))) ;;;; EXOCETS
)

(deffunction define-specific-saliences-at-L15 ()
    (bind ?*activate-J5-Exocet-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1))) ;;;; EXOCETS
    (bind ?*J5-Exocet-elimination-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1))) ;;;; EXOCETS
    (bind ?*J5-Exocet-detection-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1))) ;;;; EXOCETS
)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; TEMPLATES
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; templates are special global patterns (akin to mega-T&E)

(defglobal ?*activate-template-1-salience* = 0)
(defglobal ?*partial-template-1-salience* = 0)
(defglobal ?*template-1-salience* = 0)

(defglobal ?*activate-template-2-salience* = 0)
(defglobal ?*partial-template-2-salience* = 0)
(defglobal ?*template-2-salience* = 0)

(defglobal ?*activate-template-3-salience* = 0)
(defglobal ?*partial-template-3-salience* = 0)
(defglobal ?*template-3-salience* = 0)

(defglobal ?*activate-template-4-salience* = 0)
(defglobal ?*partial-template-4-salience* = 0)
(defglobal ?*template-4-salience* = 0)

(defglobal ?*activate-template-5-salience* = 0)
(defglobal ?*partial-template-5-salience* = 0)
(defglobal ?*template-5-salience* = 0)

(defglobal ?*activate-template-6-salience* = 0)
(defglobal ?*partial-template-6-salience* = 0)
(defglobal ?*template-6-salience* = 0)

(defglobal ?*activate-template-7-salience* = 0)
(defglobal ?*partial-template-7-salience* = 0)
(defglobal ?*template-7-salience* = 0)

(defglobal ?*activate-template-8-salience* = 0)
(defglobal ?*partial-template-8-salience* = 0)
(defglobal ?*template-8-salience* = 0)

(defglobal ?*activate-template-9-salience* = 0)
(defglobal ?*partial-template-9-salience* = 0)
(defglobal ?*template-9-salience* = 0)


(deffunction define-specific-template-saliences ()
    (bind ?*activate-template-1-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*partial-template-1-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*template-1-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    (bind ?*activate-template-2-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*partial-template-2-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*template-2-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    (bind ?*activate-template-3-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*partial-template-3-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*template-3-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    (bind ?*activate-template-4-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*partial-template-4-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*template-4-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    (bind ?*activate-template-5-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*partial-template-5-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*template-5-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    (bind ?*activate-template-6-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*partial-template-6-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*template-6-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    (bind ?*activate-template-7-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*partial-template-7-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*template-7-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    (bind ?*activate-template-8-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*partial-template-8-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*template-8-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))

    (bind ?*activate-template-9-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*partial-template-9-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
    (bind ?*template-9-salience* (bind ?*next-rule-salience* (- ?*next-rule-salience* 1)))
)







