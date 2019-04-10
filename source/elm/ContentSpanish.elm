module ContentSpanish exposing (contentSpanish)

import General exposing (..)


contentSpanish : Content
contentSpanish =
    { title = "Web de Ale Grilli"
    , intro =
        intro
            "Hola. Este es el sitio web de "
            "Ale Grilli"
            " (a veces "
            "agj"
            "). Soy un «creador transmedial»\u{200B}—\u{200B}desde Chile programo medios interactivos, diseño gráfica, creo videos, y otras cosas. Me gustan mucho los idiomas. Me puedes contactar por medio de "
            "ale¶agj.cl"
            " (¶→@)."
    , menu = menu "Portafolio" "Blog"
    , links =
        links
            "También tengo un "
            "archivo de imágenes"
            ". Uso "
            "Twitter"
            " a veces. Mis "
            "videos"
            " están en "
            "Vimeo"
            ". Parte de mi "
            "código"
            " está en "
            "Github"
            ". Una página alberga "
            "mis videojuegos viejos"
            ". En "
            "Greasy Fork"
            " están mis "
            "user scripts"
            ". Mi "
            "Tumblr"
            " tiene algunas cosas que he encontrado en la web."
    }
