module Main exposing (..)

import Notes exposing (Note(..), toPrintableNote)
import Printer exposing (Text, printValue)


printNotes : List Note -> List Text
printNotes notes =
    List.map (\note -> printValue toPrintableNote note) notes


main =
    let
        sticky_note =
            { title = "Get coffee and milk, please."
            , description = "Make sure to only get oat milk this week."
            }

        book_note =
            { description = "Sanders really attempts to explain his secret herbs and spices."
            , pageNumber = 34
            , bookId = 1102
            }

        journal_note =
            { title = "Thinking of the best ways to interact with creation."
            , tags =
                [ "creativity"
                , "creative process"
                , "interactivity"
                , "playfulness"
                , "happiness"
                , "mental health"
                , "spirituality"
                , "mindfulness"
                , "motivation"
                , "passion"
                , "flow state"
                , "focus"
                ]
            }

        items =
            [ StickyNote sticky_note, BookNote book_note, JournalNote journal_note ]

        output =
            String.join "\n" <| printNotes items

        log =
            Debug.log output "end"

        init : () -> ( Int, Cmd msg )
        init flags =
            ( 0, Cmd.none )
    in
    Platform.worker
        { init = init
        , update = \msg model -> ( model, Cmd.none )
        , subscriptions = \state -> Sub.none
        }
