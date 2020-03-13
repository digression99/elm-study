module Exercise2 exposing (..)

import Html


toUpperCase name =
    if String.length name > 10 then
        String.toUpper name

    else
        name


main =
    Html.text (toUpperCase "james moore")
