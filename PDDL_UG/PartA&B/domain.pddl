(define (domain windfarm)
    (:requirements :strips :typing :negative-preconditions)

    ; -------------------------------
    ; Types
    ; -------------------------------

    (:types
        UUV            
        location       ; Waypoints the UUV and ship can be at
        ship
        data           ; Scannable or photographable objects
        sample         ; Sample that can be taken by the UUV
    )

    ; -------------------------------
    ; Predicates
    ; -------------------------------

    (:predicates
        (belongsTo ?u - uuv ?s - ship)                ; Which ship the UUV belongs to
        (at ?u - UUV ?l - location)                   ; Which waypoint is the UUV at
        (shipAt ?s - ship ?l - location)              ; Which waypoint is the ship at
        (pathBetween ?l1 - location ?l2 - location)   ; Where you can go to from each waypoint
        (imageAt ?d - data ?l - location)             ; Which waypoints have an image available
        (scanAt ?d - data ?l - location)              ; Which waypoints have a scan available
        (sampleAt ?sa - sample ?l - location)         ; Which waypoints have a sample available
        (shipHasSample ?s - ship)                     ; If the ship has a sample
        (uuvStorageFull ?u - UUV)                     ; If the UUV has its storage full due to an image or sonar scan
        (uuvHasSample ?u - UUV)                       ; If the UUV is holding a sample
        (uuvReturned ?u - UUV)                        ; If the UUV is returned on the ship
        (shipReceivedTransmission ?s - ship)          ; If the ship has recieved the UUV transmition of data
        (beenDeployedBefore ?u - UUV)                 ; If the UUV has been deployed before, since it can only be deployed once
        
    )

    ; -------------------------------
    ; Actions
    ; -------------------------------

    (:action deploying_UUV                                         ; Deploys the UUV at the ships current location
        :parameters (?u - UUV ?l - location ?s - ship)
        :precondition (and
                            (belongsTo ?u ?s)                      ; Makes sure the right ship is deploying the right UUV
                            (shipAt ?s ?l)                         ; Drops the UUV at the ships location
                            (not (beenDeployedBefore ?u))          ; UUV can only be deployed once, so checks that it has not been deployed before
                        )
        :effect (and
                        (beenDeployedBefore ?u)                    ; UUV has now been deployed
                        (at ?u ?l)                                 ; UUV is deployed at the ships current location
                )
    )
    
    (:action UUV_Moving_Location                                   ; Moves UUV between waypoints as long as there is a valid path
        :parameters (?u - UUV ?l1 - location ?l2 - location)
        :precondition (and
                            (not (uuvReturned ?u))                 ; Checks the UUV is not currently in the ship
                            (at ?u ?l1)                            ; Checks UUV is at the location you want to move from
                            (pathBetween ?l1 ?l2)                  ; Checks there is a path between waypoints
                        )
        :effect (and
                        (not (at ?u ?l1))                          ; Changes UUV location from the first location to the second location
                        (at ?u ?l2)
                )
    )

    (:action Ship_Moving_Location                                   ; Moves ship between waypoints as long as there is a valid path
        :parameters (?s - ship ?l1 - location ?l2 - location)
        :precondition (and
                            (shipAt ?s ?l1)                         ; Checks the ship is at the location you want to move from
                            (pathBetween ?l1 ?l2)                   ; Checks there is a path between waypoints
                        )
        :effect (and
                        (not (shipAt ?s ?l1))                       ; Changes UUV location from the first location to the second location
                        (shipAt ?s ?l2)
                )
    )
    
    (:action UUV_Capturing_Image                                    ; UUV captures an image where available
        :parameters (?u - UUV ?l - location ?d - data)
        :precondition (and
                            (not (uuvReturned ?u))                     ; UUV cannot take image from the ship
                            (imageAt ?d ?l)                         ; Checks if an image is at a location
                            (at ?u ?l)                              ; Checks the UUV is at the same location of the image
                            (not (uuvStorageFull ?u))               ; Checks there is storage available in the UUV
                        )
        :effect (and
                        (uuvStorageFull ?u)                         ; Storage on the UUV is now full
                        (not (imageAt ?d ?l))                       ; Image has been taken from the location
                )
    )
    
    (:action UUV_Conducts_Sonar_Scan                                ; UUV conducts sonar scan where available
        :parameters (?u - UUV ?l - location ?d - data)
        :precondition (and
                            (not (uuvReturned ?u))                     ; UUV cannot scan from the ship
                            (scanAt ?d ?l)                          ; Checks if a scan is at a location
                            (at ?u ?l)                              ; Checks the UUV is at the same location of the scan
                            (not (uuvStorageFull ?u))               ; Checks there is storage available in the UUV
                        )
        :effect (and
                        (uuvStorageFull ?u)                         ; UUV storage is now full
                        (not (scanAt ?d ?l))                        ; Scan has been taken from the location
                )
    )

    (:action UUV_Transmits_Data                                     ; UUV trasmits data to ship
        :parameters (?u - UUV ?s - ship)
        :precondition (and
                        (belongsTo ?u ?s)                           ; Checks the UUV belongs to the ship
                        (uuvStorageFull ?u)                         ; Checks the UUV has data to be transmitted
                        )
        :effect (and
                        (not (uuvStorageFull ?u))                   ; UUV has transmitted the data, so storage is now clear
                        (shipReceivedTransmission ?s)               ; Ship has recieved the transmission
                        
                )
    )

    (:action UUV_Collects_Sample                                    ; UUV collects sample from waypoint
        :parameters (?u - UUV ?sa - sample ?l - location)
        :precondition (and
                        (not (uuvReturned ?u))                      ; UUV cannot collect sample from ship
                        (at ?u ?l)                                  ; Checks the UUV is in the same location as the sample
                        (sampleAt ?sa ?l)                           ; Checks the sample is at a location
                        (not (uuvHasSample ?u))                     ; Checks the UUV sample storage is empty
                        )
        :effect (and
                    (uuvHasSample ?u)                               ; UUV now has a sample and cannot collect another
                    (not (sampleAt ?sa ?l))                         ; Sample has been collected from location
                )
    )

      (:action UUV_Returns_To_Ship                                  ; Return the UUV to the ship
        :parameters (?u - UUV ?l - location ?s - ship)
        :precondition (and
                        (belongsTo ?u ?s)                           ; Check the UUV belongs to the ship
                        (shipAt ?s ?l)                              ; Checks the ship and the UUV are at the same location
                        (at ?u ?l)
                        (not (uuvReturned ?u))                      ; UUV cannot return to the ship if it is already on the ship
                        )
        :effect (and
                    (uuvReturned ?u)                                ; UUV is now on the ship
                )
    )

    (:action UUV_Returns_Sample                                     ; Return the sample to the ship
        :parameters (?u - UUV ?s - ship ?sa - sample)
        :precondition (and
                            (belongsTo ?u ?s)                       ; UUV has to return the sample to the ship it's on
                            (uuvReturned ?u)                        ; UUV has to be on the ship to return the sample
                            (uuvHasSample ?u)                       ; UUV has to have a sample to return it

                        )
        :effect (and
                    (not (uuvHasSample ?u))                         ; Sample has been taken from the UUV
                    (shipHasSample ?s)                              ; Ship now has the sample
                )
    )


)
