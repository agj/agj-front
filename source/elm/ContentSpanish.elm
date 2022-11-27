module ContentSpanish exposing (contentSpanish)

import General exposing (..)


contentSpanish : Content
contentSpanish =
    { title = "Web de Ale Grilli"
    , intro =
        intro
            ("Hola. Este es el sitio web de **Ale Grilli** (a veces **agj**). "
                ++ "Soy un «creador transmedial»\u{200B}—\u{200B}"
                ++ "desde Chile programo medios interactivos, diseño gráfica, creo videos, y otras cosas. "
                ++ "Me gustan mucho los idiomas. "
                ++ "Me puedes contactar por medio de “ale¶agj.cl” (¶→@)."
            )
    , menu = menu "Portafolio" "Blog"
    , links =
        links
            ("También tengo un [**archivo de imágenes**][piclog]. "
                ++ "Respecto a redes sociales, apenas uso [Mastodon][mastodon] y [Twitter][twitter]. "
                ++ "Mis **videos** están en [Vimeo][vimeo] y [Youtube][youtube]. "
                ++ "Parte de mi **código** está en [Github][github]. "
                ++ "Una página alberga [mis **videojuegos** viejos][games]. "
                ++ "En [Greasy Fork][greasyfork] están mis **userscripts**. "
                ++ "En mi [Tumblr][tumblr] tengo cosas raras de la web."
            )
    }
