(define (problem windfarm-mission-1)
    (:domain windfarm)
    (:requirements :negative-preconditions)

    (:objects
        uuv - UUV
        w1 - location
        w2 - location
        w3 - location
        w4 - location
        s - ship
        d - data
        
    )

    (:init
        (belongsTo uuv s)
        (shipAt s w1)
        (not (beenDeployedBefore uuv))
        (pathBetween w1 w2)
        (pathBetween w2 w1)
        (pathBetween w2 w3)
        (pathBetween w3 w4)
        (pathBetween w4 w3)
        (pathBetween w4 w1)
        (scanAt d w4)
        (imageAt d w3)
    )

    (:goal
        (and
            (not (imageAt d w1))
            (not (imageAt d w3))
            (not (scanAt d w4))
            (not (uuvStorageFull uuv))
            (uuvReturned uuv)
        )
    )
)