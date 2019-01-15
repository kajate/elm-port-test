port module Main exposing (..)

import Html.Styled as Html exposing (..)
import Html.Styled.Attributes as Attrs exposing (..)
import Html.Styled.Events as Evt exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- PORTS


port toJs : String -> Cmd msg


port sendInterval : Int -> Cmd msg


port fromJs : (Int -> msg) -> Sub msg



-- MODEL


type alias Model =
    { points : Int
    , interval : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { points = 0
      , interval = 1000
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Fire
    | Points Int
    | Interval
    | IntervalUp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Fire ->
            ( model, toJs "hello" )

        Points points ->
            ( { model | points = points }, Cmd.none )

        Interval ->
            let
                newInterval =
                    model.interval - 50
            in
            ( { model | interval = newInterval }, sendInterval newInterval )

        IntervalUp ->
            let
                newInterval =
                    model.interval + 50
            in
            ( { model | interval = newInterval }, sendInterval newInterval )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    fromJs Points



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] []
        , button [ onClick IntervalUp ] [ text "slower" ]
        , button [ onClick Interval ] [ text "faster" ]
        , div [] [ text ("Points: " ++ toString model.points) ]
        , div [] [ text ("Milliseconds: " ++ toString model.interval) ]
        ]
