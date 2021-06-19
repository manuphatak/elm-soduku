module Main exposing (..)

import Browser
import Css exposing (..)
import Html.Styled exposing (Html, div, text, toUnstyled)
import Html.Styled.Attributes exposing (css)
import List exposing (map)



---- MODEL ----


type alias Model =
    { sodukuBoard : List SodukuCell
    }


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


type alias Meta =
    { row : SodukuNumber, col : SodukuNumber, block : SodukuNumber, pencilMarks : List SodukuNumber }


type SodukuCell
    = Empty Meta
    | Given Meta SodukuNumber
    | Input Meta SodukuNumber


init : ( Model, Cmd Msg )
init =
    ( { sodukuBoard =
            [ Empty (Meta N1 N1 N1 [])
            , Empty (Meta N1 N2 N1 [])
            , Empty (Meta N1 N3 N1 [])
            , Given (Meta N1 N4 N2 []) N3
            , Empty (Meta N1 N5 N2 [])
            , Given (Meta N1 N6 N2 []) N1
            , Given (Meta N1 N7 N3 []) N4
            , Empty (Meta N1 N8 N3 [])
            , Empty (Meta N1 N9 N3 [])
            , Given (Meta N2 N1 N1 []) N3
            , Empty (Meta N2 N2 N1 [])
            , Empty (Meta N2 N3 N1 [])
            , Empty (Meta N2 N4 N2 [])
            , Empty (Meta N2 N5 N2 [])
            , Given (Meta N2 N6 N2 []) N5
            , Empty (Meta N2 N7 N3 [])
            , Given (Meta N2 N8 N3 []) N6
            , Given (Meta N2 N9 N3 []) N1
            , Given (Meta N3 N1 N1 []) N9
            , Given (Meta N3 N2 N1 []) N1
            , Given (Meta N3 N3 N1 []) N5
            , Empty (Meta N3 N4 N2 [])
            , Empty (Meta N3 N5 N2 [])
            , Given (Meta N3 N6 N2 []) N8
            , Empty (Meta N3 N7 N3 [])
            , Given (Meta N3 N8 N3 []) N2
            , Empty (Meta N3 N9 N3 [])
            , Given (Meta N4 N1 N4 []) N1
            , Empty (Meta N4 N2 N4 [])
            , Given (Meta N4 N3 N4 []) N2
            , Empty (Meta N4 N4 N5 [])
            , Empty (Meta N4 N5 N5 [])
            , Given (Meta N4 N6 N5 []) N9
            , Empty (Meta N4 N7 N6 [])
            , Empty (Meta N4 N8 N6 [])
            , Given (Meta N4 N9 N6 []) N6
            , Empty (Meta N5 N1 N4 [])
            , Empty (Meta N5 N2 N4 [])
            , Empty (Meta N5 N3 N4 [])
            , Given (Meta N5 N4 N5 []) N1
            , Empty (Meta N5 N5 N5 [])
            , Empty (Meta N5 N6 N5 [])
            , Given (Meta N5 N7 N6 []) N9
            , Given (Meta N5 N8 N6 []) N8
            , Given (Meta N5 N9 N6 []) N3
            , Empty (Meta N6 N1 N4 [])
            , Empty (Meta N6 N2 N4 [])
            , Given (Meta N6 N3 N4 []) N9
            , Empty (Meta N6 N4 N5 [])
            , Given (Meta N6 N5 N5 []) N8
            , Given (Meta N6 N6 N5 []) N6
            , Empty (Meta N6 N7 N6 [])
            , Empty (Meta N6 N8 N6 [])
            , Empty (Meta N6 N9 N6 [])
            , Empty (Meta N7 N1 N7 [])
            , Empty (Meta N7 N2 N7 [])
            , Given (Meta N7 N3 N7 []) N7
            , Empty (Meta N7 N4 N8 [])
            , Empty (Meta N7 N5 N8 [])
            , Empty (Meta N7 N6 N8 [])
            , Empty (Meta N7 N7 N9 [])
            , Given (Meta N7 N8 N9 []) N5
            , Given (Meta N7 N9 N9 []) N4
            , Empty (Meta N8 N1 N7 [])
            , Empty (Meta N8 N2 N7 [])
            , Empty (Meta N8 N3 N7 [])
            , Empty (Meta N8 N4 N8 [])
            , Empty (Meta N8 N5 N8 [])
            , Empty (Meta N8 N6 N8 [])
            , Given (Meta N8 N7 N9 []) N1
            , Empty (Meta N8 N8 N9 [])
            , Given (Meta N8 N9 N9 []) N9
            , Empty (Meta N9 N1 N7 [])
            , Given (Meta N9 N2 N7 []) N5
            , Empty (Meta N9 N3 N7 [])
            , Empty (Meta N9 N4 N8 [])
            , Given (Meta N9 N5 N8 []) N9
            , Empty (Meta N9 N6 N8 [])
            , Empty (Meta N9 N7 N9 [])
            , Empty (Meta N9 N8 N9 [])
            , Empty (Meta N9 N9 N9 [])
            ]
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ sodukuBoard model.sodukuBoard
        ]


sodukuBoard : List SodukuCell -> Html Msg
sodukuBoard cells =
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
        (map
            viewCell
            cells
        )


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


theme =
    { cellBorder = rgb 211 211 211
    , boxBorder = rgb 0 0 0
    }


viewCell : SodukuCell -> Html Msg
viewCell cell =
    case cell of
        Empty _ ->
            div [ css [ commonCellStyles ] ] [ text " " ]

        Given _ value ->
            div [ css [ commonCellStyles ] ] [ viewSodukuNumber value ]

        Input _ value ->
            div [ css [ commonCellStyles ] ]
                [ viewSodukuNumber value
                ]


viewSodukuNumber : SodukuNumber -> Html Msg
viewSodukuNumber number =
    case number of
        N1 ->
            text "1"

        N2 ->
            text "2"

        N3 ->
            text "3"

        N4 ->
            text "4"

        N5 ->
            text "5"

        N6 ->
            text "6"

        N7 ->
            text "7"

        N8 ->
            text "8"

        N9 ->
            text "9"


sodukuBlock : Html Msg
sodukuBlock =
    div
        []
        [ div [] [ text "1" ]
        , div [] [ text "1" ]
        , div [] [ text "1" ]
        , div [] [ text "1" ]
        , div [] [ text "1" ]
        , div [] [ text "1" ]
        , div [] [ text "1" ]
        , div [] [ text "1" ]
        , div [] [ text "1" ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view >> toUnstyled
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
