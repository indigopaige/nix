Config
  { overrideRedirect = False
  , font     = "xft:Iosevka:size=20:antialias=true"
  , bgColor  = "#303446"
  , fgColor  = "#c6d0f5"
  , position = TopSize C 100 32
  , commands =
      [ Run Cpu
          [ "-L", "3"
          , "-H", "50"
          , "--high"  , "#e78284"
          , "--normal", "#a6d189"
          , "--template"
          , "<total>"
          ] 10

      , Run Alsa "default" "Master"
          [ "--template", "<box color=red><volumestatus></box>"
          , "--suffix"  , "True"
          , "--"
          , "--on", ""
          ]

      , Run Memory
          [ "--template"
          , "Mem: <fc=#ca9ee6><usedratio></fc>%"
          ] 10

      , Run Date
          "%a %Y-%m-%d <fc=#babbf1>%H:%M</fc>"
          "date"
          10

      , Run XMonadLog
      ]

  , sepChar  = "%"
  , alignSep = "}{"

  , template =
      "%alsa:default:Master% } %XMonadLog% | %date% { %cpu% | %memory%"
  }
