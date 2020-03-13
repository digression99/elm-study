module Type2 exposing (..)

import Html


maybeNum =
    Just 235


add1 a =
    a + 1


result =
    -- result = 236
    Maybe.map add1 maybeNum
