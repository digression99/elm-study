module Case1 exposing (..)

import Html


type User
    = Regular String Int
    | Visitor String


toName : User -> String
toName user =
    case user of
        Regular name age ->
            name

        Visitor name ->
            name


main =
    Html.text (toName (Regular "Thomas" 44))
