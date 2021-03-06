
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;                              CSP-RULES / SUDORULES
;;;                              FINNED SWORDFISH, NON-INTERRUPTED VERSION
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





(defrule activate-finned-swordfish
	(declare (salience ?*finned-swordfish-salience*))
	(logical (play) (context (name ?cont)))
    (not (deactivate ?cont triplet))
=>
	(assert (technique ?cont finned-swordfish))
	(bind ?*technique* FSHT)
)



(defrule detect-L3-finned-swordfish-in-rows
	(declare (salience ?*finned-swordfish-salience*))
	(technique ?cont finned-swordfish)

	
	(candidate (context ?cont) (status cand) (number ?nb) (row ?row1) (column ?col1) (block ?bl11))
	(candidate (context ?cont) (status cand) (number ?nb) (row ?row1) (column ?col2&:(< ?col1 ?col2)) (block ?bl12))

	(candidate (context ?cont) (status cand) (number ?nb) (column ?col2) (row ?row2&:(< ?row1 ?row2)) (block ?bl22))
	(candidate (context ?cont) (status cand) (number ?nb) (row ?row2) (column ?col3&~?col1&~?col2) (block ?bl23&~?bl22))

	(not (candidate (context ?cont) (status cand) (number ?nb) (row ?row1) (column ?colx&~?col1&~?col2&~?col3)))
	(not (candidate (context ?cont) (status cand) (number ?nb) (row ?row2) (column ?colx&~?col1&~?col2&~?col3)))

	(candidate (context ?cont) (status cand) (number ?nb) (column ?col1) (row ?row3&~?row1&~?row2) (block ?bl31&~?bl11))
	(candidate (context ?cont) (status cand) (number ?nb) (row ?row3) (column ?colx) (block ?bl33&~?bl23&:(eq ?bl33 (block ?row3 ?col3))))
	(not (candidate (context ?cont) (status cand) (number ?nb) (row ?row3) (column ?coly&~?col1&~?col2) (block ?bly&~?bl33)))
=>
    (assert (apply-rule-as-a-block ?cont))
    (assert (blocked ?cont finned-swordfish-in-rows ?nb ?row1 ?row2 ?row3 ?col1 ?col2 ?col3))
	(if (or ?*print-actions* ?*print-L3* ?*print-finned-swordfish*) then
        (bind ?*blocked-rule-description*
            (str-cat "finned-swordfish-in-rows: "
				(number-name ?nb) 
				?*starting-cell-symbol* (row-name ?row1) ?*separation-sign-in-cell* (row-name ?row2) 
				?*separation-sign-in-cell* (row-name ?row3) ?*ending-cell-symbol*
				?*starting-cell-symbol* (column-name ?col1) ?*separation-sign-in-cell* (column-name ?col2) 
				?*separation-sign-in-cell* (column-name ?col3) ?*ending-cell-symbol*
			)
        )
	)
)

(defrule apply-L3-finned-swordfish-in-rows
    (declare (salience ?*apply-a-blocked-rule-salience-1*))
    (blocked ?cont finned-swordfish-in-rows ?nb ?row1 ?row2 ?row3 ?col1 ?col2 ?col3)
    ;;; then the candidature of this number for any cell outside row3 in the intersection of column 3 wih block 33 can be retracted
    (rc-cell ?row3 ?col3 ?bl33 ?sq3)
    ?cand <- (candidate (context ?cont) (status cand) (number ?nb) (column ?col3) (block ?bl33) (row ?rowz&~?row3))
=>
    (retract ?cand)
    (if (eq ?cont 0) then (bind ?*nb-candidates* (- ?*nb-candidates* 1)))
    (if (or ?*print-actions* ?*print-L3* ?*print-finned-swordfish*) then
        (bind ?elim (str-cat (row-name ?rowz) (column-name ?col3) ?*non-equal-sign* (numeral-name ?nb)))
        (add-elimination-to-blocked-rule ?elim)
    )
)




(defrule detect-L3-finned-swordfish-in-columns
	(declare (salience ?*finned-swordfish-salience*))
	(technique ?cont finned-swordfish)
	
	(candidate (context ?cont) (status cand) (number ?nb) (row ?row1) (column ?col1) (block ?bl11))
	(candidate (context ?cont) (status cand) (number ?nb) (column ?col1) (row ?row2&:(< ?row1 ?row2)) (block ?bl21))

	(candidate (context ?cont) (status cand) (number ?nb) (row ?row2) (column ?col2&:(< ?col1 ?col2)) (block ?bl22))
	(candidate (context ?cont) (status cand) (number ?nb) (column ?col2) (row ?row3&~?row1&~?row2) (block ?bl32&~?bl22))

	(not (candidate (context ?cont) (status cand) (number ?nb) (column ?col1) (row ?rowx&~?row1&~?row2&~?row3)))
	(not (candidate (context ?cont) (status cand) (number ?nb) (column ?col2) (row ?rowx&~?row1&~?row2&~?row3)))

	(candidate (context ?cont) (status cand) (number ?nb) (row ?row1) (column ?col3&~?col1&~?col2) (block ?bl13&~?bl11))
	(candidate (context ?cont) (status cand) (number ?nb) (row ?rowx) (column ?col3) (block ?bl33&~?bl32&:(eq ?bl33 (block ?row3 ?col3))))
	(not (candidate (context ?cont) (status cand) (number ?nb) (column ?col3) (row ?rowy&~?row1&~?row2) (block ?bly&~?bl33)))
=>
    (assert (apply-rule-as-a-block ?cont))
    (assert (blocked ?cont finned-swordfish-in-columns ?nb ?col1 ?col2 ?col3 ?row1 ?row2 ?row3))
	(if (or ?*print-actions* ?*print-L3* ?*print-finned-swordfish*) then
        (bind ?*blocked-rule-description*
            (str-cat "finned-swordfish-in-columns: "
				(number-name ?nb) 
				?*starting-cell-symbol* (column-name ?col1) ?*separation-sign-in-cell* (column-name ?col2) 
				?*separation-sign-in-cell* (column-name ?col3) ?*ending-cell-symbol*
				?*starting-cell-symbol* (row-name ?row1) ?*separation-sign-in-cell* (row-name ?row2) 
				?*separation-sign-in-cell* (row-name ?row3) ?*ending-cell-symbol*
            )
        )
	)
)

(defrule apply-L3-finned-swordfish-in-columns
    (declare (salience ?*apply-a-blocked-rule-salience-1*))
    (blocked ?cont finned-swordfish-in-columns ?nb ?col1 ?col2 ?col3 ?row1 ?row2 ?row3)
    ;;; then the candidature of this number for any cell outside col3 in the intersection of row 3 wih block 33 can be retracted
    (rc-cell ?row3 ?col3 ?bl33 ?sq3)
    ?cand <- (candidate (context ?cont) (status cand) (number ?nb) (row ?row3) (block ?bl33) (column ?colz&~?col3))

=>
    (retract ?cand)
    (if (eq ?cont 0) then (bind ?*nb-candidates* (- ?*nb-candidates* 1)))
    (if (or ?*print-actions* ?*print-L3* ?*print-finned-swordfish*) then
        (bind ?elim (str-cat (row-name ?row3) (column-name ?colz) ?*non-equal-sign* (numeral-name ?nb)))
        (add-elimination-to-blocked-rule ?elim)
    )
)

