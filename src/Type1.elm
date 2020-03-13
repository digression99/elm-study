module Type1 exposing (..)

import Html



-- first value of the empty list.
-- List.head means the first element of the list.


first =
    List.head []


weekday dayInNumber =
    if dayInNumber == 0 then
        "Sunday"

    else
        "Unknown"


weekday2 dayInNumber =
    case dayInNumber of
        0 ->
            "Sunday"

        _ ->
            "Unknown Day"



--checkEmpty first =
--    case first of
--        Just val ->
--            val
--
--        Nothing ->
--            "Empty"


main =
    Html.text <| weekday2 1
