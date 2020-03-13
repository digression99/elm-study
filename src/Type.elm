module Type exposing (..)


type Action
    = AddPlayer String
    | Score Int Int


msg =
    AddPlayer "James"
