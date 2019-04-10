module ContentJapanese exposing (contentJapanese)

import General exposing (..)


contentJapanese : Content
contentJapanese =
    { title = "アレ・グリリのウェブサイト"
    , intro =
        intro
            "ようこそ、"
            "アレ・グリリ"
            "（Ale Grilli、別名 "
            "agj"
            "）のホームページへ。チリを拠点にする《メディア・クリエイター》です。インタラクティブ・メディアのプログラミングや、視覚デザイン、映像制作、などに手掛ける者です。さらに言えば言語オタクです。ご連絡は "
            "ale¶agj.cl"
            "（¶→@）までにお願いします。"
    , menu = menu "作品集" "ブログ"
    , links =
        links
            ""
            "画像ログ"
            "を持っています。"
            "Twitter"
            " でたまに呟きます。自分の"
            "映像作品"
            "が "
            "Vimeo"
            " に。書く"
            "コード"
            "の一部が "
            "Github"
            " 上。昔作った"
            "ゲーム"
            "の置くページもあります。"
            "Greasy Fork"
            " に時に作る"
            "ユーザースクリプト"
            "があります。"
            "Tumblr"
            " にウェブで見つかった物が飾ってあります。"
    }
