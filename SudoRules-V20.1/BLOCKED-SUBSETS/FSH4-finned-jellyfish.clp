
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;                              CSP-RULES / SUDORULES
;;;                              FINNED JELLYFISH, NON-INTERRUPTED VERSION
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





(defrule activate-finned-jellyfish
	(declare (salience ?*finned-jellyfish-salience*))
	(logical (play) (context (name ?cont)))
    (not (deactivate ?cont quad))
=>
	(assert (technique ?cont finned-jellyfish))
	(bind ?*technique* FSHQ)
)




(defrule detect-L4-finned-jellyfish-in-rows
	(declare (salience ?*finned-jellyfish-salience*))
	(technique ?cont finned-jellyfish)
		
	(candidate (context ?cont) (status cand) (number ?nb) (row ?row1) (column ?col1))
	(candidate (context ?cont) (status cand) (number ?nb) (row ?row1) (column ?col2&:(< ?col1 ?col2)))

	(candidate (context ?cont) (status cand) (number ?nb) (column ?col2) (row ?row2&:(< ?row1 ?row2)))
	(candidate (context ?cont) (status cand) (number ?nb) (row ?row2) (column ?col3&~?col1&~?col2))

	(candidate (context ?cont) (status cand) (number ?nb) (column ?col3) (row ?row3&~?row2&:(< ?row1 ?row3)))
	(candidate (context ?cont) (status cand) (number ?nb) (row ?row3) (column ?col4&~?col1&~?col2&~?col3))

	(not (candidate (context ?cont) (status cand) (number ?nb) (row ?row1) (column ?colx&~?col1&~?col2&~?col3&~?col4)))
	(not (candidate (context ?cont) (status cand) (number ?nb) (row ?row2) (column ?colx&~?col1&~?col2&~?col3&~?col4)))
	(not (candidate (context ?cont) (status cand) (number ?nb) (row ?row3) (column ?colx&~?col1&~?col2&~?col3&~?col4)))
		
	(candidate (context ?cont) (status cand) (number ?nb) (column ?col1) (row ?row4&~?row1&~?row2&~?row3))
	(candidate (context ?cont) (status cand) (number ?nb) (row ?row4) (column ?colx) (block ?bl44&:(eq ?bl44 (block ?row4 ?col4))&:(neq ?bl44 (block ?row1 ?col4))&:(neq ?bl44 (block ?row2 ?col4))&:(neq ?bl44 (block ?row3 ?col4))&:(neq ?bl44 (block ?row4 ?col1))&:(neq ?bl44 (block ?row4 ?col2))&:(neq ?bl44 (block ?row4 ?col3))))
	(not (candidate (context ?cont) (status cand) (number ?nb) (row ?row4) (column ?coly&~?col1&~?col2&~?col3) (block ?bly&~?bl44)))
=>
    (assert (apply-rule-as-a-block ?cont))
    (assert (blocked ?cont finned-jellyfish-in-rows ?nb ?row1 ?row2 ?row3 ?row4 ?col1 ?col2 ?col3 ?col4))
	(if (or ?*print-actions* ?*print-L4* ?*print-finned-jellyfish*) then
        (bind ?*blocked-rule-description*
            (str-cat "finned-jellyfish-in-rows: "
				(number-name ?nb) 
				?*starting-cell-symbol* (row-name ?row1) ?*separation-sign-in-cell* (row-name ?row2) 
				?*separation-sign-in-cell* (row-name ?row3) ?*separation-sign-in-cell* (row-name ?row4) ?*ending-cell-symbol*
				?*starting-cell-symbol* (column-name ?col1) ?*separation-sign-in-cell* (column-name ?col2) 
				?*separation-sign-in-cell* (column-name ?col3) ?*separation-sign-in-cell* (column-name ?col4) ?*ending-cell-symbol*
			)
        )
	)
)

(defrule apply-L4-finned-jellyfish-in-rows
    (declare (salience ?*apply-a-blocked-rule-salience-1*))
    (blocked ?cont finned-jellyfish-in-rows ?nb ?row1 ?row2 ?row3 ?row4 ?col1 ?col2 ?col3 ?col4)
    ;;; then the candidature of this number for any cell outside row4 in the intersection of column 4 wih block 44 can be retracted
    (rc-cell ?row4 ?col4 ?bl44 ?sq4)
    ?cand <- (candidate (context ?cont) (status cand) (number ?nb) (column ?col4) (block ?bl44) (row ?rowz&~?row4))
=>
    (retract ?cand)
    (if (eq ?cont 0) then (bind ?*nb-candidates* (- ?*nb-candidates* 1)))
    (if (or ?*print-actions* ?*print-L4* ?*print-finned-jellyfish*) then
        (bind ?elim (str-cat (row-name ?rowz) (column-name ?col4) ?*non-equal-sign* (numeral-name ?nb)))
        (add-elimination-to-blocked-rule ?elim)
    )
)





(defrule detect-L4-finned-jellyfish-in-columns
	(declare (salience ?*finned-jellyfish-salience*))
	(technique ?cont finned-jellyfish)
	
	(candidate (context ?cont) (status cand) (number ?nb) (column ?col1) (row ?row1) )
	(candidate (context ?cont) (status cand) (number ?nb) (column ?col1) (row ?row2&~?row1))

	(candidate (context ?cont) (status cand) (number ?nb) (row ?row2) (column ?col2&:(< ?col1 ?col2)))
	(candidate (context ?cont) (status cand) (number ?nb) (column ?col2) (row ?row3&~?row1&~?row2))

	(candidate (context ?cont) (status cand) (number ?nb) (row ?row3) (column ?col3&~?col2&:(< ?col1 ?col3)))
	(candidate (context ?cont) (status cand) (number ?nb) (column ?col3) (row ?row4&~?row1&~?row2&~?row3))

	(not (candidate (context ?cont) (status cand) (number ?nb) (column ?col1) (row ?rowx&~?row1&~?row2&~?row3&~?row4)))
	(not (candidate (context ?cont) (status cand) (number ?nb) (column ?col2) (row ?rowx&~?row1&~?row2&~?row3&~?row4)))
	(not (candidate (context ?cont) (status cand) (number ?nb) (column ?col3) (row ?rowx&~?row1&~?row2&~?row3&~?row4)))
		
	(candidate (context ?cont) (status cand) (number ?nb) (row ?row1) (column ?col4&~?col1&~?col2&~?col3))
	(candidate (context ?cont) (status cand) (number ?nb) (row ?rowx) (column ?col4) (block ?bl44&:(eq ?bl44 (block ?row4 ?col4))&:(neq ?bl44 (block ?row1 ?col4))&:(neq ?bl44 (block ?row2 ?col4))&:(neq ?bl44 (block ?row3 ?col4))&:(neq ?bl44 (block ?row4 ?col1))&:(neq ?bl44 (block ?row4 ?col2))&:(neq ?bl44 (block ?row4 ?col3))))
	(not (candidate (context ?cont) (status cand) (number ?nb) (column ?col4) (row ?rowy&~?row1&~?row2&~?row3) (block ?bly&~?bl44)))
=>
    (assert (apply-rule-as-a-block ?cont))
    (assert (blocked ?cont finned-jellyfish-in-columns ?nb ?col1 ?col2 ?col3 ?col4 ?row1 ?row2 ?row3 ?row4))
	(if (or ?*print-actions* ?*print-L4* ?*print-finned-jellyfish*) then
        (bind ?*blocked-rule-description*
            (str-cat "finned-jellyfish-in-columns: "
				(number-name ?nb) 
				?*starting-cell-symbol* (column-name ?col1) ?*separation-sign-in-cell* (column-name ?col2) 
				?*separation-sign-in-cell* (column-name ?col3) ?*separation-sign-in-cell* (column-name ?col4) ?*ending-cell-symbol*
				?*starting-cell-symbol* (row-name ?row1) ?*separation-sign-in-cell* (row-name ?row2) 
				?*separation-sign-in-cell* (row-name ?row3) ?*separation-sign-in-cell* (row-name ?row4) ?*ending-cell-symbol*
			)
        )
	)
)

(defrule apply-L4-finned-jellyfish-in-columns
    (declare (salience ?*apply-a-blocked-rule-salience-1*))
    (blocked ?cont finned-jellyfish-in-columns ?nb ?col1 ?col2 ?col3 ?col4 ?row1 ?row2 ?row3 ?row4)
    ;;; then the candidature of this number for any cell outside col4 in the intersection of row 4 wih block 44 can be retracted
    (rc-cell ?row4 ?col4 ?bl44 ?sq4)
    ?cand <- (candidate (context ?cont) (status cand) (number ?nb) (row ?row4) (block ?bl44) (column ?colz&~?col4))

=>
    (retract ?cand)
    (if (eq ?cont 0) then (bind ?*nb-candidates* (- ?*nb-candidates* 1)))
    (if (or ?*print-actions* ?*print-L4* ?*print-finned-jellyfish*) then
        (bind ?elim (str-cat (row-name ?row4) (column-name ?colz) ?*non-equal-sign* (numeral-name ?nb)))
        (add-elimination-to-blocked-rule ?elim)
    )
)
