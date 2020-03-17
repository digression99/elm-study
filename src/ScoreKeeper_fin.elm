module ScoreKeeper_fin exposing (..)

import Browser
import Debug
import Html exposing (..)
import Html.Attributes exposing (class, placeholder, type_, value)
import Html.Events exposing (..)
import List



-- model


type alias Model =
    { players : List Player
    , name : String
    , playerId : Maybe Int
    , plays : List Play
    }


type alias Player =
    { id : Int
    , name : String
    , points : Int
    }


type alias Play =
    { id : Int
    , playerId : Int
    , name : String
    , points : Int
    }


initModel : Model
initModel =
    { players = []
    , name = ""
    , playerId = Nothing
    , plays = []
    }



-- update


type Msg
    = Edit Player
    | Score Player Int
    | Input String
    | Save
    | Cancel
    | DeletePlay Play


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input name ->
            Debug.log "Input Updated Model"
                { model
                    | name = name
                }

        Cancel ->
            Debug.log "Cancel action."
                { model | name = "", playerId = Nothing }

        Save ->
            if String.isEmpty model.name then
                model

            else
                save model

        Score player points ->
            score model player points

        Edit player ->
            { model | name = player.name, playerId = Just player.id }

        DeletePlay play ->
            deletePlay model play


deletePlay : Model -> Play -> Model
deletePlay model play =
    let
        newPlays =
            List.filter (\p -> p.id /= play.id) model.plays

        newPlayers =
            List.map
                (\player ->
                    if player.id == play.playerId then
                        { player | points = player.points - 1 * play.points }

                    else
                        player
                )
                model.players
    in
    { model | plays = newPlays, players = newPlayers }


score : Model -> Player -> Int -> Model
score model scorer points =
    let
        newPlayers =
            List.map
                (\player ->
                    if player.id == scorer.id then
                        { player
                            | points = player.points + points
                        }

                    else
                        player
                )
                model.players

        play =
            Play (List.length model.plays) scorer.id scorer.name points
    in
    { model
        | players = newPlayers
        , plays = play :: model.plays
    }


add : Model -> Model
add model =
    let
        player =
            Player (List.length model.players) model.name 0

        newPlayers =
            player :: model.players
    in
    { model
        | players = newPlayers
        , name = ""
    }


edit : Model -> Int -> Model
edit model id =
    let
        newPlayers =
            List.map
                (\player ->
                    if player.id == id then
                        { player | name = model.name }

                    else
                        player
                )
                model.players

        newPlays =
            List.map
                (\play ->
                    if play.playerId == id then
                        { play | name = model.name }

                    else
                        play
                )
                model.plays
    in
    { model
        | players = newPlayers
        , plays = newPlays
        , name = ""
        , playerId = Nothing
    }


save : Model -> Model
save model =
    case model.playerId of
        Just id ->
            edit model id

        Nothing ->
            add model



-- view


view : Model -> Html Msg
view model =
    div [ class "scoreboard " ]
        [ h1 [] [ text "Score Keeper" ]
        , playerSection model
        , playerForm model
        , playSection model
        , p [] [ text (Debug.toString model) ]
        ]


playSection : Model -> Html Msg
playSection model =
    div []
        [ playListHeader
        , playList model
        ]


playListHeader : Html Msg
playListHeader =
    header []
        [ div [] [ text "Plays" ]
        , div [] [ text "Points" ]
        ]


playList : Model -> Html Msg
playList model =
    model.plays
        |> List.map renderPlay
        |> ul []


renderPlay : Play -> Html Msg
renderPlay play =
    li []
        [ i [ class "remove", onClick (DeletePlay play) ] []
        , div [] [ text play.name ]
        , div [] [ text (Debug.toString play.points) ]
        ]


playerForm : Model -> Html Msg
playerForm model =
    form [ onSubmit Save ]
        [ input
            [ type_ "text"
            , (\pId ->
                case pId of
                    Just playerId ->
                        class "edit"

                    Nothing ->
                        class ""
              )
                model.playerId
            , placeholder "Add/Edit player..."
            , onInput Input
            , value model.name
            ]
            []
        , button [ type_ "submit " ] [ text "Save" ]
        , button [ type_ "button ", onClick Cancel ] [ text "Cancel" ]
        ]


playerListHeader : Html Msg
playerListHeader =
    header []
        [ div [] [ text "Name" ]
        , div [] [ text "Points" ]
        ]


playerList : Model -> Html Msg
playerList model =
    model.players
        |> List.sortBy .name
        |> List.map (renderPlayer model.playerId)
        |> ul []


getClassName playerId player =
    if player.id == playerId then
        case playerId of
            Just id ->
                class "edit"

            Nothing ->
                class ""

    else
        class ""


renderPlayer : Maybe Int -> Player -> Html Msg
renderPlayer playerId player =
    li []
        [ i [ class "edit", onClick (Edit player) ] []
        , div [ class "" ] [ text player.name ]
        , button [ type_ "button", onClick (Score player 2) ] [ text "2pt" ]
        , button [ type_ "button", onClick (Score player 3) ] [ text "3pt" ]
        , div [] [ text (Debug.toString player.points) ]
        ]


playerTotal : Model -> Html Msg
playerTotal model =
    let
        total =
            List.map .points model.plays
                |> List.sum
    in
    footer []
        [ div [] [ text "Total : " ]
        , div [] [ text (Debug.toString total) ]
        ]


playerSection : Model -> Html Msg
playerSection model =
    div []
        [ playerListHeader
        , playerList model
        , playerTotal model
        ]


main =
    Browser.sandbox
        { init = initModel
        , update = update
        , view = view
        }
