module Main exposing (Model, Msg(..), init, main, probability, subscriptions, update, usuallyTrue, view, viewValidation, viewValimage)

import Browser
import Html exposing (..)
import Html.Attributes exposing (src, style)
import Html.Events exposing (onClick)
import Random
import Svg exposing (..)
import Svg.Attributes exposing (..)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { dieFace : Int
    , secFaces : Bool
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { dieFace = 1, secFaces = True }, Cmd.none )


usuallyTrue : Random.Generator Bool
usuallyTrue =
    Random.weighted ( 50, True ) [ ( 50, False ) ]


probability : Random.Generator Int
probability =
    Random.int 0 1



-- UPDATE


type Msg
    = Roll
    | NewFace Int
    | SecFace Bool


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Cmd.batch
                [ Random.generate NewFace probability
                , Random.generate SecFace usuallyTrue
                ]
            )

        NewFace newFace ->
            ( { model | dieFace = newFace }
            , Cmd.none
            )

        SecFace secFace ->
            ( { model | secFaces = secFace }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewValidation model
        , button [ onClick Roll ] [ Html.text "Roll" ]
        , viewValimage model
        ]


viewValidation : Model -> Html msg
viewValidation model =
    if model.dieFace == 0 then
        svg
            [ width "120"
            , height "120"
            , viewBox "0 0 120 120"
            ]
            [ circle
                [ cx "50"
                , cy "50"
                , r "50"
                ]
                []
            ]

    else
        svg
            [ width "120"
            , height "120"
            , viewBox "0 0 120 120"
            ]
            [ circle
                [ cx "30"
                , cy "30"
                , r "30"
                ]
                []
            ]


viewValimage : Model -> Html msg
viewValimage model =
    if model.secFaces == True then
        img [ src "money.jpeg" ] []

    else
        img [ src "money1.jpeg" ] []
