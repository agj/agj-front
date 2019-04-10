module ContentJapanese exposing (contentJapanese)

import General exposing (..)


contentJapanese : Content
contentJapanese =
    { title = "アレ・グリリのウェブサイト"
    , intro =
        intro
            "ようこそ、**アレ・グリリ**（Ale Grilli、別名 **agj**）のホームページへ。チリを拠点にする「メディア・クリエイター」です。インタラクティブ・メディアのプログラミングや、視覚デザイン、映像制作、などに手掛ける者です。さらに言えば言語オタクです。ご連絡は “ale¶agj.cl”（¶→@）までにお願いします。"
    , menu = menu "作品集" "ブログ"
    , links =
        links
            "[**画像ログ**][piclog]を持っています。[Twitter][twitter] でたまにつぶやきます。自分の**映像作品**が [Vimeo][vimeo] に。書く**コード**の一部が [Github][github] 上。昔作った[**ゲーム**][games]の置くページもあります。[Greasy Fork][greasyfork] に時に作る**ユーザースクリプト**があります。[Tumblr][tumblr] にウェブで見つかった物が飾ってあります。"
    }
