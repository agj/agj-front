module ContentJapanese exposing (contentJapanese)

import General exposing (..)


contentJapanese : Content
contentJapanese =
    { title = "アレ・グリリのウェブ"
    , intro =
        intro
            ("ようこそ、**アレ・グリリ**（Ale Grilli、別名 **agj**）のホームページへ。"
                ++ "チリを拠点にする「メディア・クリエイター」です。"
                ++ "インタラクティブ・メディアのプログラミングや、視覚デザイン、映像制作、などに手掛ける者です。"
                ++ "さらに言えば言語オタクです。"
                ++ "ご連絡は “ale¶agj.cl”（¶→@）までお願いします。"
            )
    , menu = menu "作品集" "ブログ"
    , links =
        links
            ("他に、[**画像ログ**][piclog]を持っています。"
                ++ "日西バイリンガル Twitter アカウント [**Japoñol**][japonol] を運営していて、"
                ++ "[メインアカウント][twitter]は放置状態です。"
                ++ "手掛けた**映像作品**が [Vimeo][vimeo] に。"
                ++ "書いた**コード**の一部は [Github][github] 上に。"
                ++ "昔作った[**ゲーム**][games]が置いてあるページもあります。"
                ++ "[Greasy Fork][greasyfork] にたまに作るブラウザー用**ユーザースクリプト**があります。"
                ++ "ウェブでの拾い物は [Tumblr][tumblr] に。"
            )
    }
