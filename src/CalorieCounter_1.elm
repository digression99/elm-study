module CalorieCounter_1 exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { total : Int, inputValue : Int }


initModel : Model
initModel =
    { total = 0, inputValue = 0 }


type Msg
    = AddCalorie
    | Clear
    | UpdateInput String


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddCalorie ->
            { model
                | total = model.total + model.inputValue -- can you use dot function?
                , inputValue = 0
            }

        Clear ->
            initModel

        UpdateInput payload ->
            { model | inputValue = Maybe.withDefault 0 (String.toInt payload) }


view : Model -> Html Msg
view model =
    div []
        [ h3 [] [ text ("Total calories : " ++ String.fromInt model.total) ]
        , input [ type_ "number", onInput UpdateInput, value (String.fromInt model.inputValue) ] []
        , button [ onClick AddCalorie ] [ text "Add" ]
        , button [ onClick Clear ] [ text "Clear" ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initModel
        , update = update
        , view = view
        }
