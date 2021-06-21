module Main exposing (..)

import Browser
import Css exposing (..)
import Debug exposing (toString)
import Html.Styled exposing (Html, button, div, text, toUnstyled)
import Html.Styled.Attributes exposing (css)
import SodukuBoard exposing (SodukuBoard)
import SodukuCell exposing (Meta, SodukuCell(..))
import SodukuNumber exposing (SodukuNumber(..))
import Theme exposing (palette)



---- MODEL ----


type alias Model =
    { sodukuBoard : SodukuBoard
    }


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
    div [ css [ display inlineFlex, flexDirection column ] ]
        [ SodukuBoard.view model.sodukuBoard
        , sodukuInput model.sodukuBoard
        ]


sodukuInput : SodukuBoard -> Html Msg
sodukuInput board =
    div [ css [ displayFlex, justifyContent spaceBetween, marginTop (px 20) ] ]
        (List.map
            (\n ->
                button
                    [ css
                        [ displayFlex
                        , justifyContent center
                        , alignItems center
                        , fontSize (px 30)
                        , color palette.white
                        , backgroundColor palette.darkslateblue
                        , border (px 0)
                        , height (px 70)
                        , width (px 50)
                        , position relative
                        , focus
                            [ backgroundColor palette.white
                            , color palette.darkslateblue
                            , outlineColor palette.darkslateblue
                            ]
                        ]
                    ]
                    [ SodukuNumber.view n
                    , div [ css [ fontSize (px 14), position absolute, top (px 4), right (px 4) ] ] [ getOutstandingCount board n ]
                    ]
            )
            SodukuNumber.elements
        )


getOutstandingCount : SodukuBoard -> SodukuNumber -> Html Msg
getOutstandingCount board number =
    board
        |> List.filterMap SodukuCell.value
        |> List.filter ((==) number)
        |> List.length
        |> (-) 9
        |> toString
        |> text



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view >> toUnstyled
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
