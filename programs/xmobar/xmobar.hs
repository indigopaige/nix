Config
  { overrideRedirect = False
  , font     = "xft:Iosevka:size=20:antialias=true"
  , border   = NoBorder
  , bgColor  = "#303446"
  , fgColor  = "#c6d0f5"
  , position = TopSize L 100 40
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
          [ "--template", "<hspace=5/><volumestatus>"
          , "--suffix"  , "True"
          , "--"
          , "--on", ""
          ]

      , Run Memory
          [ "--template"
          , "<fc=#ca9ee6><usedratio></fc><hspace=5/>"

          ] 10

      , Run XMonadLog
      ]

  , sepChar  = "%"
  , alignSep = "}{"

  , template =
      "%alsa:default:Master% } %XMonadLog% { %cpu%  %memory%"
  }
