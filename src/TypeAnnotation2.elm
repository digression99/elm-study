module TypeAnnotation2 exposing (..)

import Html


type alias Item =
    { name : String, price : Float, qty : Int, discounted : Bool }


cart : List Item
cart =
    [ { name = "Lemon"
      , price = 0.5
      , qty = 1
      , discounted = False
      }
    , { name = "Apple"
      , price = 1.0
      , qty = 5
      , discounted = False
      }
    , { name = "Pear"
      , price = 1.25
      , qty = 10
      , discounted = False
      }
    ]


discount : Int -> Float -> Item -> Item
discount minQty discPct item =
    if not item.discounted && item.qty >= minQty then
        { item
            | price = item.price * (1.0 - discPct)
            , discounted = True
        }

    else
        item


newCart : List Item
newCart =
    List.map (discount 10 0.3 >> discount 5 0.2) cart


fromBool : Bool -> String
fromBool b =
    case b of
        True ->
            "True"

        False ->
            "False"


parseCartItemToString : Item -> String
parseCartItemToString item =
    String.join " " [ item.name, String.fromFloat item.price, String.fromInt item.qty, fromBool item.discounted ]


main : Html.Html msg
main =
    newCart
        |> List.map parseCartItemToString
        |> String.join ", "
        |> Html.text
