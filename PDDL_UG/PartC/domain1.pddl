(define (domain windfarm-1)
    (:requirements :strips :typing :negative-preconditions)


    ; -------------------------------
    ; Types
    ; -------------------------------

    (:types
        UUV
        location
        ship
        data
        sample
        engineer
        
    )

    ; -------------------------------
    ; Predicates
    ; -------------------------------

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
        (engineerAtBay ?e - engineer)                        ; Engineer is at the bay
        (engineerAtCC ?e - engineer)                         ; Engineer is at the control centre
        (engineerBelongsTo ?e - engineer ?sh - ship )        ; Which ship the engineer belongs to
        
    )

    ; -------------------------------
    ; Actions
    ; -------------------------------

    (:action deploying_UUV
        :parameters (?u - UUV ?l - location ?s - ship ?e - engineer)
        :precondition (and
                            (engineerBelongsTo ?e ?s)                   ; Engineer of the correct ship has to be in the bay to deploy the UUV
                            (engineerAtBay ?e)
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
                            (scanAt
                 ?d ?l)
                            (at ?u ?l)
                            (not (uuvStorageFull ?u))
                        )
        :effect (and
                        (uuvStorageFull ?u)
                        (not (scanAt
             ?d ?l))
                )
    )

    (:action UUV_Transmits_Data
        :parameters (?u - UUV ?s - ship ?e - engineer)
        :precondition (and
                        (engineerBelongsTo ?e ?s)                            ; Engineer of the correct ship has to be in the control centre to recieve the transmission
                        (engineerAtCC ?e)
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
        :parameters (?u - UUV ?l - location ?s - ship ?e - engineer)
        :precondition (and
                        (engineerBelongsTo ?e ?s)                                ; Engineer has to be on the correct ship and in the bay for the UUV to return
                        (engineerAtBay ?e)
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

    (:action Engineer-Moves-To-Bay                                ; Moves the engineer to the bay
        :parameters (?e - engineer ?sh - ship)
        :precondition (and
                            (engineerBelongsTo ?e ?sh)            ; Engineer has to be on the correct ship
                            (engineerAtCC ?e)                     ; Engineer has to be in the control centre to move to the bay

                        )
        :effect (and
                    (not (engineerAtCC ?e))                       ; Engineer is no longer in the control centre
                    (engineerAtBay ?e)                            ; Engineer is now in the bay
                )
    )

    (:action Engineer-Moves-To-CC                                 ; Moves the engineer to the control centre
        :parameters (?e - engineer ?sh - ship)
        :precondition (and
                            (engineerBelongsTo ?e ?sh)            ; Engineer has to be on the correct ship
                            (engineerAtBay ?e)                    ; Engineer has to be in the bay to move to the control centre

                        )
        :effect (and
                    (not (engineerAtBay ?e))                      ; Engineer is no longer in the bay
                    (engineerAtCC ?e)                             ; Engineer is now in the control centre
                )
    )


)
