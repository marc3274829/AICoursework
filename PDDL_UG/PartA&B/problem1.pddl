(define (problem windfarm-mission-1)
    (:domain windfarm)

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
        (belongs-to uuv s)
        (ship-at s w1)
        (not (beenDeployedBefore uuv))
        (path-between w1 w2)
        (path-between w2 w1)
        (path-between w2 w3)
        (path-between w3 w2)
        (path-between w3 w4)
        (path-between w4 w3)
        (path-between w4 w1)
        (scan-at d w4)
        (image-at d w3)
    )

    (:goal
        (and
            (not (image-at d w1))
            (not (image-at d w3))
            (not (scan-at d w4))
            (not (uuvStorageFull uuv))
        )
    )
)