module SodukuCell exposing (..)

import Css exposing (..)
import Html.Styled exposing (Html, div, text)
import Html.Styled.Attributes exposing (css)
import SodukuNumber exposing (SodukuNumber)
import Theme exposing (theme)


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


commonCellStyles : Style
commonCellStyles =
    Css.batch
        [ border3 (px 1) solid theme.cellBorder
        , displayFlex
        , justifyContent center
        , alignItems center
        , fontSize (px 50)
        , nthChild "3n + 1" [ borderLeft3 (px 2) double theme.boxBorder ]
        , nthChild "3n" [ borderRight3 (px 2) double theme.boxBorder ]
        , nthChild "n" [ nthChild "-n + 9" [ borderTop3 (px 2) double theme.boxBorder ] ]
        , nthChild "n + 19" [ nthChild "-n + 27" [ borderBottom3 (px 2) solid theme.boxBorder ] ]
        , nthChild "n + 28" [ nthChild "-n + 36" [ borderTop3 (px 2) solid theme.boxBorder ] ]
        , nthChild "n + 46" [ nthChild "-n + 54" [ borderBottom3 (px 2) solid theme.boxBorder ] ]
        , nthChild "n + 55" [ nthChild "-n + 63" [ borderTop3 (px 2) solid theme.boxBorder ] ]
        , nthChild "n + 73" [ nthChild "-n + 81" [ borderBottom3 (px 2) solid theme.boxBorder ] ]
        ]


view : SodukuCell -> Html msg
view cell =
    case cell of
        Empty _ ->
            div [ css [ commonCellStyles ] ] [ text " " ]

        Given _ n ->
            div [ css [ commonCellStyles ] ] [ SodukuNumber.view n ]

        Input _ n ->
            div [ css [ commonCellStyles ] ]
                [ SodukuNumber.view n
                ]
