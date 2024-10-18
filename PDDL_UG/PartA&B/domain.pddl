(define (domain windfarm)
    (:requirements :strips :typing)

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
        (belongs-to ?u - uuv ?s - ship)
        (at ?u - UUV ?l - location)
        (ship-at ?s - ship ?l - location)
        (path-between ?l1 - location ?l2 - location)
        (image-at ?d - data ?l - location)
        (scan-at ?d - data ?l - location)
        (sample-at ?sa - sample ?l - location)
        (collected ?u - UUV ?d - data)
        (clear ?u - UUV)
        (shipHasSample ?s - ship ?sa - sample)
        (uuvStorageFull ?u - UUV)
        (uuvHasSample ?u - UUV ?sa - sample)
        (uuvAlreadyHasSample ?u - UUV)
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
                            (belongs-to ?u ?s)
                            (ship-at ?s ?l)
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
                            (path-between ?l1 ?l2)
                        )
        :effect (and
                        (not (at ?u ?l1))
                        (at ?u ?l2)
                )
    )
    
    (:action UUV_Capturing_Image
        :parameters (?u - UUV ?l - location ?d - data)
        :precondition (and
                            (image-at ?d ?l)
                            (at ?u ?l)
                            (not (uuvStorageFull ?u))
                        )
        :effect (and
                        (uuvStorageFull ?u)
                        (not (image-at ?d ?l))
                )
    )
    
    (:action UUV_Conducts_Sonar_Scan
        :parameters (?u - UUV ?l - location ?d - data)
        :precondition (and
                            (scan-at ?d ?l)
                            (at ?u ?l)
                            (not (uuvStorageFull ?u))
                        )
        :effect (and
                        (uuvStorageFull ?u)
                        (not (scan-at ?d ?l))
                )
    )

    (:action UUV_Transmits_Data
        :parameters (?u - UUV ?s - ship)
        :precondition (and
                        (belongs-to ?u ?s)
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
                        (not (uuvAlreadyHasSample ?u))
                        (not (uuvReturned ?u))
                        (at ?u ?l)
                        (sample-at ?sa ?l)
                        (not (uuvHasSample ?u ?sa))
                        )
        :effect (and
                    (uuvAlreadyHasSample ?u)
                    (uuvHasSample ?u ?sa)
                    (not (sample-at ?sa ?l))
                )
    )

      (:action UUV_Returns_To_Ship
        :parameters (?u - UUV ?l - location ?s - ship)
        :precondition (and
                        (belongs-to ?u ?s)
                        (ship-at ?s ?l)
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
                            (belongs-to ?u ?s)
                            (uuvReturned ?u)
                            (uuvHasSample ?u ?sa)

                        )
        :effect (and
                    (not (uuvAlreadyHasSample ?u))
                    (uuvReturned ?u)
                    (shipHasSample ?s ?sa)
                )
    )


)