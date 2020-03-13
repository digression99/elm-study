module TypeAnnotation1 exposing (..)

import Html


type alias CartItem =
    { name : String, price : Float, qty : Int, discounted : Bool }


cart : List CartItem
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


fromBool b =
    if b then
        "True"

    else
        "False"


parseCartItemToString : CartItem -> String
parseCartItemToString item =
    String.join " " [ item.name, String.fromFloat item.price, String.fromInt item.qty, fromBool item.discounted ]


discount minQty discPct item =
    if not item.discounted && item.qty >= minQty then
        { item
            | price = item.price * (1.0 - discPct)
            , discounted = True
        }

    else
        item


main =
    cart
        |> List.map (discount 10 0.3 >> discount 5 0.2)
        |> List.map parseCartItemToString
        |> String.join ", "
        |> Html.text
