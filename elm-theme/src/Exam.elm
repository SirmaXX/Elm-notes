import Browser
import Html exposing (map,text,Html,div,p,ul,button,input,h1,li,br,h3  )
import Html.Attributes exposing (value,type_ ,checked,class,style)
import Html.Events exposing (onClick,onInput)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region


--MAİN

main =
    Browser.document
        { init = init
        , update = update
        ,subscriptions = subscriptions  
        , view = view
       }


type alias Flags=
    {
      width:Int
     ,height:Int 
     
    }

type alias Model =
    { device:Device    }

--INIT

init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { device = Element.classifyDevice flags
      }
    , Cmd.none
    )   


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DeviceClassified device ->
            ( { model | device = device }
            , Cmd.none
            )

subscriptions : Model -> Sub Msg
subscriptions model =
    onResize <|
        \width height ->
            DeviceClassified (Element.classifyDevice { width = width, height = height })
--UPDATE

view : Model -> Browser.Document Msg
view model =
    { title = "Deniz Balcı"
    , body = deviceBody model
    }


deviceBody : Model -> List (Html Msg)
deviceBody model =
    case model.device.class of
        Phone ->
            mobileLayout

        _ ->
            a4PagesLayout
