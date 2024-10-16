(define (problem windfarm-mission-3)
    (:domain windfarm)

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
        sa - sample
        d - data
    )

    (:init
        (belongs-to uuv1 sh1)
        (belongs-to uuv2 sh2)
        (ship-at sh1 w2)
        (ship-at sh2 w1)
        (not (beenDeployedBefore uuv1))
        (not (beenDeployedBefore uuv2))
        (path-between w1 w2)
        (path-between w2 w1)
        (path-between w2 w3)
        (path-between w2 w4)
        (path-between w4 w2)
        (path-between w3 w5)
        (path-between w5 w3)
        (path-between w5 w6)
        (path-between w6 w4)
        (image-at d w3)
        (scan-at d w4)
        (image-at d w2)
        (scan-at d w6)
        (sample-at sa w5)
        (sample-at sa w1)

    )


    (:goal
        (and
            (shipHasSample sh1)
            (shipHasSample sh2)
            (not (scan-at d w4))
            (not (scan-at d w6))
            (not (image-at d w3))
            (not (image-at d w2))

        )
    )
)