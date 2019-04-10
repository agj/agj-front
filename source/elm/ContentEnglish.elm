module ContentEnglish exposing (contentEnglish)

import General exposing (..)


contentEnglish : Content
contentEnglish =
    { title = "Ale Grilli’s website"
    , intro =
        intro
            "Hello. This is my, **Ale Grilli** (a.k.a. **agj**)’s home on the web. I’m a Chile-based «cross-media creator»\u{200B}—\u{200B}I program interactive media, design visuals, author videos, and more. I'm also a languages nerd. You may contact me via “ale¶agj.cl” (¶→@)."
    , menu = menu "Portfolio" "Blog"
    , links =
        links
            "I also have a [**pictures log**][piclog]. I use [Twitter][twitter] sparingly. My **video works** are on [Vimeo][vimeo]. Some of my **code** is up on [Github][github]. I have a page with [my old **games**][games]. [Greasy Fork][greasyfork] houses my **user scripts**. My [Tumblr][tumblr] has some stuff I've found around the web."
    }
