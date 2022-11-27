module Printer exposing (..)


type alias Text =
    String


type alias Printable a =
    TextCodec a


type alias TextCodec a =
    { encode : a -> Text
    , decode : Text -> a
    }


printValue : (value -> Printable value) -> value -> Text
printValue toPrintableCodec val =
    (toPrintableCodec val).encode val
