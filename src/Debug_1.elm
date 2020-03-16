module Debug_1 exposing (..)

import Debug
import Html


logData data =
    Debug.log data

logData 10

main =
    Html.text "Hi"
