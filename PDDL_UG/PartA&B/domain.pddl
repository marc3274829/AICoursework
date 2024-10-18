(define (domain windfarm)
    (:requirements :strips :typing :negative-preconditions)

    ; -------------------------------
    ; Types
    ; -------------------------------

    ; EXAMPLE

    ; (:types
    ;     parent_type
    ;     child_type - parent_type

    ; )
    (:types
        UUV
        location
        ship
        data
        sample
    )

    ; -------------------------------
    ; Predicates
    ; -------------------------------

    ; EXAMPLE

    ; (:predicates
    ;     (no_arity_predicate)
    ;     (one_arity_predicate ?p - parameter_type)
    ; )

    (:predicates
        (belongsTo ?u - uuv ?s - ship)
        (at ?u - UUV ?l - location)
        (shipAt ?s - ship ?l - location)
        (pathBetween ?l1 - location ?l2 - location)
        (imageAt ?d - data ?l - location)
        (scanAt ?d - data ?l - location)
        (sampleAt ?sa - sample ?l - location)
        (shipHasSample ?s - ship)
        (uuvStorageFull ?u - UUV)
        (uuvHasSample ?u - UUV)
        (uuvReturned ?u - UUV)
        (shipReceivedTransmission ?s - ship)
        (beenDeployedBefore ?u - UUV)
        
    )

    ; -------------------------------
    ; Actions
    ; -------------------------------

    ; EXAMPLE

    ; (:action action-template
    ;     :parameters (?p - parameter_type)
    ;     :precondition (and
    ;         (one_arity_predicate ?p)
    ;     )
    ;     :effect 
    ;     (and 
    ;         (no_arity_predicate)
    ;         (not (one_arity_predicate ?p))
    ;     )
    ; )

    (:action deploying_UUV
        :parameters (?u - UUV ?l - location ?s - ship)
        :precondition (and
                            (belongsTo ?u ?s)
                            (shipAt ?s ?l)
                            (not (beenDeployedBefore ?u))
                        )
        :effect (and
                        (beenDeployedBefore ?u)
                        (at ?u ?l)
                )
    )
    
    (:action UUV_Moving_Location
        :parameters (?u - UUV ?l1 - location ?l2 - location)
        :precondition (and
                            (not (uuvReturned ?u))
                            (at ?u ?l1)
                            (pathBetween ?l1 ?l2)
                        )
        :effect (and
                        (not (at ?u ?l1))
                        (at ?u ?l2)
                )
    )
    
    (:action UUV_Capturing_Image
        :parameters (?u - UUV ?l - location ?d - data)
        :precondition (and
                            (imageAt ?d ?l)
                            (at ?u ?l)
                            (not (uuvStorageFull ?u))
                        )
        :effect (and
                        (uuvStorageFull ?u)
                        (not (imageAt ?d ?l))
                )
    )
    
    (:action UUV_Conducts_Sonar_Scan
        :parameters (?u - UUV ?l - location ?d - data)
        :precondition (and
                            (scanAt ?d ?l)
                            (at ?u ?l)
                            (not (uuvStorageFull ?u))
                        )
        :effect (and
                        (uuvStorageFull ?u)
                        (not (scanAt ?d ?l))
                )
    )

    (:action UUV_Transmits_Data
        :parameters (?u - UUV ?s - ship)
        :precondition (and
                        (belongsTo ?u ?s)
                        (uuvStorageFull ?u)
                        )
        :effect (and
                        (not (uuvStorageFull ?u))
                        (shipReceivedTransmission ?s)
                        
                )
    )

    (:action UUV_Collects_Sample
        :parameters (?u - UUV ?sa - sample ?l - location)
        :precondition (and
                        (not (uuvReturned ?u))
                        (at ?u ?l)
                        (sampleAt ?sa ?l)
                        (not (uuvHasSample ?u))
                        )
        :effect (and
                    (uuvHasSample ?u)
                    (not (sampleAt ?sa ?l))
                )
    )

      (:action UUV_Returns_To_Ship
        :parameters (?u - UUV ?l - location ?s - ship)
        :precondition (and
                        (belongsTo ?u ?s)
                        (shipAt ?s ?l)
                        (at ?u ?l)
                        (not (uuvReturned ?u))
                        )
        :effect (and
                    (uuvReturned ?u)
                )
    )

    (:action UUV_Returns_Sample
        :parameters (?u - UUV ?s - ship ?sa - sample)
        :precondition (and
                            (belongsTo ?u ?s)
                            (uuvReturned ?u)
                            (uuvHasSample ?u)

                        )
        :effect (and
                    (not (uuvHasSample ?u))
                    (shipHasSample ?s)
                )
    )


)