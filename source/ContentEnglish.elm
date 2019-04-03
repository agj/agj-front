module ContentEnglish exposing (contentEnglish)

import General exposing (..)


contentEnglish : Content
contentEnglish =
    { title = "Ale Grilli’s website"
    , intro =
        intro
            "Hello. This is my, "
            "Ale Grilli"
            " (a.k.a. "
            "agj"
            ")’s home on the web. I’m a Chile-based «cross-media creator»—I program interactive media, design visuals, author videos, and more. I'm also a languages nerd. You may contact me via "
            "ale¶agj.cl"
            " (¶→@)."
    , menu = menu "Portfolio" "Blog"
    , links =
        links
            "I also have a "
            "pictures log"
            ". I use "
            "Twitter"
            " sparingly. My "
            "video works"
            " are on "
            "Vimeo"
            ". Some of my "
            "code"
            " is up on "
            "Github"
            ". I have a page with "
            "my old games"
            ". "
            "Greasy Fork"
            " houses my "
            "user scripts"
            ". My "
            "Tumblr"
            " has some stuff I've found around the web."
    }
