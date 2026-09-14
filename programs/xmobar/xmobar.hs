Config
  { overrideRedirect = False
  , font     = "xft:iosevka-9"
  , bgColor  = "#1e1e2e"
  , fgColor  = "#cdd6f4"
  , position = TopSize C 100 36
  , commands = [ Run Cpu
                 [ "-L", "3"
                 , "-H", "50"
                 , "--high"  , "#f38ba8"
                 , "--normal", "#a6e3a1"
                 ] 10
               , Run Alsa "default" "Master"
                 [ "--template", "<volumestatus>"
                 , "--suffix"  , "True"
                 , "--"
                 , "--on", ""
                 ]
               , Run Memory ["--template", "Mem: <fc=#cba6f7><usedratio></fc>%"] 10 
               , Run Date "%a %Y-%m-%d <fc=#89b4fa>%H:%M</fc>" "date" 10 
               , Run XMonadLog
               ]
  , sepChar  = "%"
  , alignSep = "}{"
  , template = "%XMonadLog% }{ %alsa:default:Master% | %cpu% | %memory% | %date% "
  }
