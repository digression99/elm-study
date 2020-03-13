module Exercise3 exposing (..)

import Html


boolToString bool =
    if bool then
        "True"

    else
        "False"



--infixFunc s1 s2 =
--    String.slice 0 1 s1 == String.slice 0 1 s2


infixFunc a b =
    String.left 1 a == String.left 1 b


main =
    Html.text (boolToString (infixFunc "Hi" "Fu"))
