module SodukuNumber exposing (..)

import Html.Styled exposing (Html, text)


type SodukuNumber
    = N1
    | N2
    | N3
    | N4
    | N5
    | N6
    | N7
    | N8
    | N9


elements : List SodukuNumber
elements =
    [ N1, N2, N3, N4, N5, N6, N7, N8, N9 ]


toInt : SodukuNumber -> Int
toInt n =
    case n of
        N1 ->
            1

        N2 ->
            2

        N3 ->
            3

        N4 ->
            4

        N5 ->
            5

        N6 ->
            6

        N7 ->
            7

        N8 ->
            8

        N9 ->
            9


show : SodukuNumber -> String
show number =
    case number of
        N1 ->
            "1"

        N2 ->
            "2"

        N3 ->
            "3"

        N4 ->
            "4"

        N5 ->
            "5"

        N6 ->
            "6"

        N7 ->
            "7"

        N8 ->
            "8"

        N9 ->
            "9"


view : SodukuNumber -> Html msg
view number =
    text (show number)
