module Exercise4 exposing (..)

import Html


boolToString bool =
    if bool then
        "True"

    else
        "False"


infixFunc s1 s2 =
    String.slice 0 1 s1 == String.slice 0 1 s2



--wordCount sentence =
--    String.words sentence
--main = Html.text (String.fromInt (List.length (wordCount "Ha Bu Ba")))


wordCount =
    String.words >> List.length


main =
    "Here is a test sentence"
        |> wordCount
        |> String.fromInt
        |> Html.text
