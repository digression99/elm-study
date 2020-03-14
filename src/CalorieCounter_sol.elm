module CalorieCounter_sol exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { calories : Int
    , input : Int
    , error : Maybe String
    }


initModel : Model
initModel =
    Model 0 0 Nothing


type Msg
    = AddCalorie
    | Input String
    | Clear


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddCalorie ->
            { model
                | calories = model.calories + model.input
                , input = 0
            }

        Input val ->
            case String.toInt val of
                Just input ->
                    { model
                        | input = input -- local value.
                        , error = Nothing
                    }

                Nothing ->
                    { model
                        | input = 0
                        , error = Just "You got an error."
                    }

        Clear ->
            initModel


view : Model -> Html Msg
view model =
    div []
        [ h3 [] [ text ("Total Calories : " ++ String.fromInt model.calories) ]
        , input
            [ type_ "text"
            , onInput Input
            , value
                (if model.input == 0 then
                    ""

                 else
                    String.fromInt model.input
                )
            ]
            []
        , div [] [ text (Maybe.withDefault "" model.error) ]
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
