(define (problem windfarm-mission-3)
    (:domain windfarm)
    (:requirements :negative-preconditions)

    (:objects
        uuv1 - UUV
        uuv2 - UUV
        w1 - location
        w2 - location
        w3 - location
        w4 - location
        w5 - location
        w6 - location
        sh1 - ship
        sh2 - ship
        sa1 - sample
        sa2 - sample
        d - data
    )

    (:init
        (belongsTo uuv1 sh1)
        (at uuv1 w2)                             ; UUV 1 starts at waypoint 2
        (belongsTo uuv2 sh2)
        (shipAt sh1 w2)
        (shipAt sh2 w1)
        (beenDeployedBefore uuv1)                ; UUV 1 starts off deployed
        (not (beenDeployedBefore uuv2))
        (pathBetween w1 w2)
        (pathBetween w2 w1)
        (pathBetween w2 w3)
        (pathBetween w2 w4)
        (pathBetween w4 w2)
        (pathBetween w3 w5)
        (pathBetween w5 w3)
        (pathBetween w5 w6)
        (pathBetween w6 w4)
        (imageAt d w3)
        (scanAt d w4)
        (imageAt d w2)
        (scanAt d w6)
        (sampleAt sa2 w5)
        (sampleAt sa1 w1)

    )


    (:goal
        (and
            (shipHasSample sh1)
            (shipHasSample sh2)
            (not (scanAt d w4))
            (not (scanAt d w6))
            (not (imageAt d w3))
            (not (imageAt d w2))
            (uuvReturned uuv1)
            (uuvReturned uuv2)

        )
    )
)
