(define (problem windfarm-mission-2)
    (:domain windfarm)
    (:requirements :negative-preconditions)
    (:objects
        uuv - UUV
        w1 - location
        w2 - location
        w3 - location
        w4 - location
        w5 - location
        sh - ship
        sa - sample
        d - data
    )

    (:init
        (belongsTo uuv sh)
        (shipAt sh w1)
        (not (beenDeployedBefore uuv))
        (pathBetween w1 w2)
        (pathBetween w2 w3)
        (pathBetween w3 w5)
        (pathBetween w5 w1)
        (pathBetween w1 w4)
        (pathBetween w4 w3)
        (imageAt d w5)
        (scanAt d w3)
        (sampleAt sa w1)
    )

    (:goal
        (and
            (not (imageAt d w5))
            (not (scanAt d w3))
            (shipHasSample sh)
            (not (uuvStorageFull uuv))
            (uuvReturned uuv)
           
        )
    )
)