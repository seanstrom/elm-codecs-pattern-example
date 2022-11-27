module Notes exposing (..)

import Printer exposing (Printable)


type Note
    = StickyNote { title : String, description : String }
    | BookNote { description : String, pageNumber : Int, bookId : Int }
    | JournalNote { title : String, tags : List String }


encodeStickyNote sticky_note =
    "title: "
        ++ sticky_note.title
        ++ "\n"
        ++ "description: "
        ++ sticky_note.description
        ++ "\n"


decodeStickyNote input =
    case String.split "\n" input of
        [] ->
            { title = "", description = "" }

        title :: [] ->
            { title = title, description = "" }

        title :: description :: _ ->
            { title = title, description = description }


encodeBookNote book_note =
    "bookId: "
        ++ String.fromInt book_note.bookId
        ++ "\n"
        ++ "pageNumber: "
        ++ String.fromInt book_note.pageNumber
        ++ "\n"
        ++ "description: "
        ++ book_note.description
        ++ "\n"


defaultBookNote (book_id, page_number, description) =
    { bookId = Maybe.withDefault -1 book_id
    , pageNumber = Maybe.withDefault -1 page_number
    , description = Maybe.withDefault "" description
    }


decodeBookNote input =
    case String.split "\n" input of
        [] ->
            defaultBookNote (Nothing, Nothing, Nothing)

        book_id :: [] ->
            defaultBookNote ((String.toInt book_id), Nothing, Nothing)

        book_id :: page_number :: [] ->
            defaultBookNote ((String.toInt book_id), (String.toInt page_number), Nothing)

        book_id :: page_number :: description :: _ ->
            defaultBookNote ((String.toInt book_id), (String.toInt page_number), Just description)


encodeJournalNote journal_note =
    "title: "
        ++ journal_note.title
        ++ "\n"
        ++ "tags: "
        ++ String.join ", " journal_note.tags
        ++ "\n"


decodeJournalNote input =
    case String.split "\n" input of
        [] ->
            { title = "", tags = [] }

        title :: [] ->
            { title = title, tags = [] }

        title :: tags :: _ ->
            { title = title, tags = (String.split ", " tags) }


toPrintableNote : Note -> Printable Note
toPrintableNote note =
    case note of
        StickyNote sticky_note ->
            { encode = \_ -> encodeStickyNote sticky_note
            , decode = \input -> StickyNote <| decodeStickyNote input
            }

        BookNote book_note ->
            { encode = \_ -> encodeBookNote book_note
            , decode = \input -> BookNote <| decodeBookNote input
            }

        JournalNote journal_note ->
            { encode = \_ -> encodeJournalNote journal_note
            , decode = \input -> JournalNote <| decodeJournalNote input
            }
