module SodukuBoard exposing (..)

import Css exposing (..)
import Html.Styled exposing (Html, div)
import Html.Styled.Attributes exposing (css)
import SodukuCell exposing (SodukuCell)
import Theme exposing (theme)


type alias SodukuBoard =
    List SodukuCell


view : List SodukuCell -> Html msg
view cells =
    div
        [ css
            [ property "display" "inline-grid"
            , property "grid-template-columns" "repeat(9, 60px)"
            , property "grid-template-rows" "repeat(9, 60px)"
            , property "place-items" "stretch stretch"
            , fontFamilies [ "system-ui" ]
            , border3 (px 2) solid theme.boxBorder
            ]
        ]
        (List.map
            SodukuCell.view
            cells
        )
