
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;                              CSP-RULES / SUDORULES
;;;                              SUDORULES LOADER
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





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; For reasons of efficiency and/or compatibility with Application 15b.1.12, 
;;; gBRT and Subset rules are Sudoku specific
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; GENERAL

(load (str-cat ?*Application-Dir* "GENERAL" ?*Directory-symbol* "background.clp"))
(load (str-cat ?*Application-Dir* "GENERAL" ?*Directory-symbol* "nrc-output.clp"))
(load (str-cat ?*Application-Dir* "GENERAL" ?*Directory-symbol* "solve.clp"))
(load (str-cat ?*Application-Dir* "GENERAL" ?*Directory-symbol* "manage.clp"))
(load (str-cat ?*Application-Dir* "GENERAL" ?*Directory-symbol* "NS.clp"))
(load (str-cat ?*Application-Dir* "GENERAL" ?*Directory-symbol* "HS.clp"))

;;; now loaded only if W1 is active:
(if (or ?*Whips[1]* ?*Bi-Whips* ?*Bi-Braids*) then
    (load (str-cat ?*Application-Dir* "GENERAL" ?*Directory-symbol* "init-links.clp"))
)

(if (or ?*G-Bivalue-Chains* ?*G-Whips*  ?*G-Braids*) then 
    (load (str-cat ?*Application-Dir* "GENERAL" ?*Directory-symbol* "glabels.clp"))
    (load (str-cat ?*Application-Dir* "GENERAL" ?*Directory-symbol* "init-glinks.clp"))
)


;;; UNIQUENESS

(if ?*Unique-Rectangles* then (load (str-cat ?*Application-Dir* "UNIQUENESS" ?*Directory-symbol* "UR1.clp")))
(if ?*Unique-Rectangles* then (load (str-cat ?*Application-Dir* "UNIQUENESS" ?*Directory-symbol* "UR2.clp")))
(if ?*Unique-Rectangles* then (load (str-cat ?*Application-Dir* "UNIQUENESS" ?*Directory-symbol* "UR2b.clp")))
(if ?*Unique-Rectangles* then (load (str-cat ?*Application-Dir* "UNIQUENESS" ?*Directory-symbol* "UR3.clp")))
(if ?*Unique-Rectangles* then (load (str-cat ?*Application-Dir* "UNIQUENESS" ?*Directory-symbol* "UR4.clp")))
(if ?*BUG* then (load (str-cat ?*Application-Dir* "UNIQUENESS" ?*Directory-symbol* "BUG.clp")))



;;; EXOTIC PATTERNS

(if ?*Belt4* then (load (str-cat ?*Application-Dir* "EXOTIC" ?*Directory-symbol* "sk-loops" ?*Directory-symbol* "Belt4-of-crosses.clp")))
(if ?*Belt6* then (load (str-cat ?*Application-Dir* "EXOTIC" ?*Directory-symbol* "sk-loops" ?*Directory-symbol* "Belt6-of-crosses.clp")))

(defglobal ?*J-Exocet-variant* = (if ?*Blue-J-Exocets* then (str-cat "Blue" ?*Directory-symbol*) else ""))

(if (or ?*J-Exocet* ?*J2-Exocet*) then (load (str-cat ?*Application-Dir* "EXOTIC" ?*Directory-symbol* "J-Exocets" ?*Directory-symbol* ?*J-Exocet-variant* "J2-Exocet.clp")))
(if (or ?*J-Exocet* ?*J3-Exocet*) then (load (str-cat ?*Application-Dir* "EXOTIC" ?*Directory-symbol* "J-Exocets" ?*Directory-symbol* ?*J-Exocet-variant* "J3-Exocet.clp")))
(if (or ?*J-Exocet* ?*J4-Exocet*) then (load (str-cat ?*Application-Dir* "EXOTIC" ?*Directory-symbol* "J-Exocets" ?*Directory-symbol* ?*J-Exocet-variant* "J4-Exocet.clp")))
(if (or ?*J-Exocet* ?*J5-Exocet*) then (load (str-cat ?*Application-Dir* "EXOTIC" ?*Directory-symbol* "J-Exocets" ?*Directory-symbol* ?*J-Exocet-variant* "J5-Exocet.clp")))



;;; SUBSETS

;;; when a Subset is detected, in the default behaviour of SudoRules,
;;; application of the rule can be interrupted if a simpler rule is applicable
;;; SudoRules now allows to modify this behaviour (blocked Subsets)
;;; as a result, different versions of the Subset rules, will be loaded by the SudoRules loader
(defglobal ?*Subsets-Directory* = (if ?*blocked-Subsets* then "BLOCKED-SUBSETS" else "SUBSETS"))

(if (or ?*Subsets* ?*Subsets[4]* ?*Subsets[3]* ?*Subsets[2]*) then
    (load (str-cat ?*Application-Dir* ?*Subsets-Directory* ?*Directory-symbol* "N2-naked-pairs.clp"))
    (load (str-cat ?*Application-Dir* ?*Subsets-Directory* ?*Directory-symbol* "H2-hidden-pairs.clp"))
    (load (str-cat ?*Application-Dir* ?*Subsets-Directory* ?*Directory-symbol* "SH2-x-wing.clp"))
)
(if (or ?*FinnedFish* ?*FinnedFish[4]* ?*FinnedFish[3]* ?*FinnedFish[2]*) then
    (load (str-cat ?*Application-Dir* ?*Subsets-Directory* ?*Directory-symbol* "FSH2-finned-x-wing.clp"))
)


(if (or ?*Subsets* ?*Subsets[4]* ?*Subsets[3]*) then
    (load (str-cat ?*Application-Dir* ?*Subsets-Directory* ?*Directory-symbol* "N3-naked-triplets.clp"))
    (load (str-cat ?*Application-Dir* ?*Subsets-Directory* ?*Directory-symbol* "H3-hidden-triplets.clp"))
    (load (str-cat ?*Application-Dir* ?*Subsets-Directory* ?*Directory-symbol* "SH3-swordfish.clp"))
)
(if (or ?*FinnedFish* ?*FinnedFish[4]* ?*FinnedFish[3]*) then
    (load (str-cat ?*Application-Dir* ?*Subsets-Directory* ?*Directory-symbol* "FSH3-finned-swordfish.clp"))
)


(if (or ?*Subsets* ?*Subsets[4]*) then
    (load (str-cat ?*Application-Dir* ?*Subsets-Directory* ?*Directory-symbol* "N4-naked-quads.clp"))
    (load (str-cat ?*Application-Dir* ?*Subsets-Directory* ?*Directory-symbol* "H4-hidden-quads.clp"))
    (load (str-cat ?*Application-Dir* ?*Subsets-Directory* ?*Directory-symbol* "SH4-jellyfish.clp"))
    (load (str-cat ?*Application-Dir* ?*Subsets-Directory* ?*Directory-symbol* "SpN4-special-naked-quads.clp"))
    (load (str-cat ?*Application-Dir* ?*Subsets-Directory* ?*Directory-symbol* "SpH4-special-hidden-quads.clp"))
    (load (str-cat ?*Application-Dir* ?*Subsets-Directory* ?*Directory-symbol* "SpSH4-special-jellyfish.clp"))
)
(if (or ?*FinnedFish* ?*FinnedFish[4]*) then
    (load (str-cat ?*Application-Dir* ?*Subsets-Directory* ?*Directory-symbol* "FSH4-finned-jellyfish.clp"))
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; TEMPLATES
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(if (and ?*Templates* (<= 1 ?*Templates-max-length*)) then (load (str-cat ?*Application-Dir* "TEMPLATES" ?*Directory-symbol* "Templates[1].clp")))
(if (and ?*Templates* (<= 2 ?*Templates-max-length*)) then (load (str-cat ?*Application-Dir* "TEMPLATES" ?*Directory-symbol* "Templates[2].clp")))
(if (and ?*Templates* (<= 3 ?*Templates-max-length*)) then (load (str-cat ?*Application-Dir* "TEMPLATES" ?*Directory-symbol* "Templates[3].clp")))
(if (and ?*Templates* (<= 4 ?*Templates-max-length*)) then (load (str-cat ?*Application-Dir* "TEMPLATES" ?*Directory-symbol* "Templates[4].clp")))
(if (and ?*Templates* (<= 5 ?*Templates-max-length*)) then (load (str-cat ?*Application-Dir* "TEMPLATES" ?*Directory-symbol* "Templates[5].clp")))
(if (and ?*Templates* (<= 6 ?*Templates-max-length*)) then (load (str-cat ?*Application-Dir* "TEMPLATES" ?*Directory-symbol* "Templates[6].clp")))
(if (and ?*Templates* (<= 7 ?*Templates-max-length*)) then (load (str-cat ?*Application-Dir* "TEMPLATES" ?*Directory-symbol* "Templates[7].clp")))
(if (and ?*Templates* (<= 8 ?*Templates-max-length*)) then (load (str-cat ?*Application-Dir* "TEMPLATES" ?*Directory-symbol* "Templates[8].clp")))
(if (and ?*Templates* (<= 9 ?*Templates-max-length*)) then (load (str-cat ?*Application-Dir* "TEMPLATES" ?*Directory-symbol* "Templates[9].clp")))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; STATISTICS
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;; most of this could be extended to the general CSP

(load (str-cat ?*Application-Dir* "STATS" ?*Directory-symbol* "stats.clp"))
(load (str-cat ?*Application-Dir* "STATS" ?*Directory-symbol* "unbiased-stats.clp"))
(load (str-cat ?*Application-Dir* "STATS" ?*Directory-symbol* "comparisons.clp"))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; REDEFINE APPLICATION-SPECIFIC RATING-TYPE
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deffunction define-application-specific-rating-type ()
    (bind ?*application-specific-rating-type*
        (if ?*FinnedFish*
            then "SFin"
            else (if ?*Subsets* then "S" else "")
        )
    )
    
    (if ?*Belt4* then
        (bind ?*application-specific-rating-type*
            (if (neq ?*application-specific-rating-type* "") then (str-cat ?*application-specific-rating-type* "+sk") else "sk")
        )
    )

    (if ?*J-Exocet* then
        (bind ?*J2-Exocet* TRUE)
        (bind ?*J3-Exocet* TRUE)
        (bind ?*J4-Exocet* TRUE)
        (bind ?*J5-Exocet* TRUE)
    )
    
    (if ?*J-Exocet* then
        (bind ?*application-specific-rating-type*
            (if (neq ?*application-specific-rating-type* "") then (str-cat ?*application-specific-rating-type* "+" "JE") else "JE")
        )
    )
    ?*application-specific-rating-type*
)



