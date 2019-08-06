import Browser
import Html exposing (..)
import Html.Events exposing (onClick,onDoubleClick )
import Task
import Time
import Svg exposing (..)
import Svg.Attributes exposing (..)


-- MAIN


main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { zone : Time.Zone
  , time : Time.Posix
  , stop : Bool
  
  }


init : () -> (Model, Cmd Msg)
init _ =
  ( Model Time.utc (Time.millisToPosix 0) False 
  , Task.perform AdjustTimeZone Time.here
  )

 

-- UPDATE


type Msg
  = Tick Time.Posix
  | AdjustTimeZone Time.Zone
  | StopTime 
  | StartTime


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      ( { model | time = newTime }
      , Cmd.none
      )

    AdjustTimeZone newZone ->
      ( { model | zone = newZone }
      , Cmd.none
      )
     
    StopTime ->
      ({ model| stop = True}, Cmd.none )
   

    StartTime ->
      ({ model| stop = False}, Cmd.none )
-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
          if model.stop then
             Sub.none
          else if not model.stop then
           Time.every 1000 Tick
          else 
            Time.every 1000 Tick


-- VIEW


view : Model -> Html Msg
view model =

 div []
    [ 
    div [] [ clock model ]
    , stoptime model
    ] 
  
   

clock :Model -> Html Msg
clock model =
  let
    hour   = toFloat (Time.toHour   model.zone model.time)
    minute = toFloat (Time.toMinute model.zone model.time)
    second = toFloat (Time.toSecond model.zone model.time)
  in
  svg
    [ viewBox "0 2 400 400"
    , width "400"
    , height "400"
    ]
    [ circle [ cx "200", cy "200", r "120", fill "red" ] []
    , viewHand 6 60 (hour/12)
    , viewHand 6 90 (minute/60)
    , viewHand 3 90 (second/60)
    ]





viewHand : Int -> Float -> Float -> Svg msg
viewHand width length turns =
  let
    t = 2 * pi * (turns - 0.25)
    x = 200 + length * cos t
    y = 200 + length * sin t
  in
  line
    [ x1 "200"
    , y1 "200"
    , x2 (String.fromFloat x)
    , y2 (String.fromFloat y)
    , stroke "white"
    , strokeWidth (String.fromInt width)
    , strokeLinecap "round"
    ]
    []










stoptime :Model -> Html Msg
stoptime model =
    button [ onClick StopTime ,onDoubleClick StartTime ] [ Html.text "stop time" ]