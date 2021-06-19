module SodukuCell exposing (..)

import SodukuNumber exposing (SodukuNumber)


type alias Meta =
    { row : SodukuNumber, col : SodukuNumber, block : SodukuNumber, pencilMarks : List SodukuNumber }


type SodukuCell
    = Empty Meta
    | Given Meta SodukuNumber
    | Input Meta SodukuNumber


value : SodukuCell -> Maybe SodukuNumber
value cell =
    case cell of
        Empty _ ->
            Nothing

        Given _ n ->
            Just n

        Input _ n ->
            Just n
