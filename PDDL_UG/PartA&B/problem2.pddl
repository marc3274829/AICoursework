(define (problem windfarm-mission-2)
    (:domain windfarm)

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
        (belongs-to uuv sh)
        (ship-at sh w1)
        (not (beenDeployedBefore uuv))
        (path-between w1 w2)
        (path-between w2 w3)
        (path-between w3 w5)
        (path-between w5 w1)
        (path-between w1 w4)
        (path-between w4 w3)
        (image-at d w5)
        (scan-at d w3)
        (sample-at sa w1)
    )

    (:goal
        (and
            (not (image-at d w5))
            (not (scan-at d w3))
            (uuvHasSample uuv)
            (not (uuvStorageFull uuv))
           
        )
    )
)