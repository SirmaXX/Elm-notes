import Random
import Svg exposing (..)
import Svg.Attributes exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (..)
import Random



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
  }


init : () -> (Model, Cmd Msg)
init _ =
  ( Model 1
  , Cmd.none
  )



-- UPDATE


type Msg
  = Roll
  | NewFace Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      ( model
      , Random.generate NewFace (Random.int 0 1)
      )

    NewFace newFace ->
      ( Model newFace
      , Cmd.none
      )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW


view : Model -> Html Msg
view model =
     div[] [
     viewValidation model
   ,  button [ onClick Roll ] [Html.text "Roll" ]
    ]




viewValidation : Model -> Html msg
viewValidation model =
  if model.dieFace== 0  then
    div [style "color" "green" ] [Html.text "OK" ]
  else
    div [style "color" "red" ] [Html.text "Passwords do not match!" ]

