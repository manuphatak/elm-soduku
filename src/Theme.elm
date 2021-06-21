module Theme exposing (..)

import Css exposing (..)


theme =
    { cellBorder = rgb 211 211 211
    , boxBorder = palette.black
    }


palette =
    { white = rgb 255 255 255
    , black = rgb 0 0 0
    , darkslateblue = hex "483d8b"
    }
