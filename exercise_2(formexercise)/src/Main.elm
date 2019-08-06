module Main exposing (Model, Msg(..), init, main, update, view, viewValidation)

import Browser
import Char exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String exposing (..)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , age : String
    , checkform : Bool
    }


init : Model
init =
    Model "" "" "" "" False



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Agecheck String
    | CheckForm


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name, checkform = False }

        Password password ->
            { model | password = password, checkform = False }

        PasswordAgain password ->
            { model | passwordAgain = password, checkform = False }

        Agecheck age ->
            { model | age = age, checkform = False }

        CheckForm ->
            { model | checkform = True }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Name", value model.name, onInput Name ] []
        , input [ type_ "password", placeholder "Password", value model.password, onInput Password ] []
        , input [ type_ "password", placeholder "Re-enter Password", value model.passwordAgain, onInput PasswordAgain ] []
        , input [ type_ "text", placeholder "Text to reverse", value model.age, onInput Agecheck ] []
        , button [ onClick CheckForm ] [ text "Submit" ]
        , viewValidation model
        ]


viewValidation : Model -> Html msg
viewValidation model =
    if length model.password < 8 then
        div [ style "color" "red" ] [ text "parolanız 8 karakterden az" ]

    else if any isUpper model.password == False then
        div [ style "color" "red" ] [ text " parolanızda büyük harf yoktur  " ]

    else if any isLower model.password == False then
        div [ style "color" "red" ] [ text "parolanızda küçük harf yok" ]

    else if any isDigit model.password == False then
        div [ style "color" "red" ] [ text "parolanızda rakam yok" ]

    else if isEmpty model.age || all isDigit model.age == False then
        div [ style "color" "red" ] [ text "lütfen sayi giriniz" ]

    else if model.password /= model.passwordAgain then
        div [ style "color" "red" ] [ text "2 parola kutusu birbirinden farklu" ]

    else
        div [ style "color" "green" ] [ text "that okey" ]
