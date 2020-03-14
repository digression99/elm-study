module Type_Exercise_1_revisit exposing (..)

import Html


type alias Item =
    { name : String, qty : Int, freeQty : Int }


cart : List Item
cart =
    [ { name = "Lemon", qty = 1, freeQty = 0 }
    , { name = "Apple", qty = 5, freeQty = 0 }
    , { name = "Pear", qty = 10, freeQty = 0 }
    ]


give : Int -> Int -> Item -> Item
give baseQty freeQty item =
    if item.qty >= baseQty then
        { item | freeQty = freeQty }

    else
        item


giveFree : Item -> Item
giveFree item =
    (give 5 1 >> give 10 3) item


parseCartItemToString : Item -> String
parseCartItemToString item =
    String.join " " [ item.name, String.fromInt item.qty, String.fromInt item.freeQty ]


main : Html.Html -> msg
main =
    cart
        |> List.map giveFree
        |> List.map parseCartItemToString
        |> String.join ", "
        |> Html.text
