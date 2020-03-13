module Main exposing (main)

import Html


add a b =
    a + b


getAge age =
    if age < 18 then
        "Under Age"

    else
        "Of Age"


boolToString bool =
    if bool then
        "True"

    else
        "False"


count =
    100


increment amt =
    count + amt


result =
    add 2 2 |> (\a -> modBy 2 a == 0)


increment cnt amt =
    let
        localCount =
            cnt

        localCount =
            localCount + amt
    in
    localCount + amt


main =
    Html.text (String.fromInt (increment 10))
