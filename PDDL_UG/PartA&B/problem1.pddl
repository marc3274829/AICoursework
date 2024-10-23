(define (problem windfarm-mission-1)
    (:domain windfarm)
    (:requirements :negative-preconditions)

    (:objects
        uuv - UUV
        w1 - location                            ; Waypoint 1
        w2 - location                            ; Waypoint 2
        w3 - location                            ; Waypoint 3
        w4 - location                            ; Waypoint 4
        s - ship
        d - data
        
    )

    (:init
        (belongsTo uuv s)                        ; UUV belongs to the ship
        (shipAt s w1)                            ; Ship starts at waypoint 1
        (not (beenDeployedBefore uuv))           ; UUV has not been deployed yet
        (pathBetween w1 w2)                      ; ----------------------------
        (pathBetween w2 w1)                      ; Paths between each waypoint
        (pathBetween w2 w3)                      ;
        (pathBetween w3 w4)                      ;
        (pathBetween w4 w3)                      ;
        (pathBetween w4 w1)                      ; ----------------------------
        (scanAt d w4)                            ; Scan available at waypoint 4
        (imageAt d w3)                           ; Image available at waypoint 3
    )

    (:goal
        (and
            (not (imageAt d w3))                 ; Image has been taken
            (not (scanAt d w4))                  ; Scan has been taken
            (not (uuvStorageFull uuv))           ; All data has been transmitted
            (uuvReturned uuv)                    ; UUV is back on the ship
        )
    )
)
