Config { font = "xft:M+ 1p:size=14:antialias=true"
        , additionalFonts = [
                "xft:M+ 1p:size=8:antialias=true",
                "xft:M+ 1p:size=10:antialias=true"
                ]
        , borderColor = "#ffa738"
        , border = TopB
        , bgColor = "#94004c"
        , fgColor = "#b6a738"
        , position = TopW C 100
        -- , position = Static { xpos = 0 , ypos = 0, width = 1920, height = 40 }
        , commands = [ 
                Run Weather "CYVR" ["-t","<tempC>C","-L","18","-H","25","--normal","green","--high","red","--low","lightblue"] 36000
          -- network activity monitor (dynamic interface resolution)
                , Run DynNetwork     [ "--template" , "<dev>: <tx>kB/s|<rx>kB/s"
                                        , "--Low"      , "1000"       -- units: kB/s
                                        , "--High"     , "5000"       -- units: kB/s
                                        , "--low"      , "blue"
                                        , "--normal"   , "yellow"
                                        , "--high"     , "green"
                                        ] 10
                , Run Cpu [  "-L","3","-H","50","--normal","green","--high","red"] 10
                , Run Memory ["-t","Mem: <usedratio>%"] 10
                --, Run Swap [] 10
                -- , Run Com "uname" ["-s","-r"] "" 36000
                --, Run Date "%a %b %_d %Y %H:%M:%S" "date" 10
                , Run StdinReader
                , Run Com "uname" ["-s","-r"] "" 36000
                , Run Com "hostname" ["-f"] "" 36000
                 
        ]
        , sepChar = "%"
        , alignSep = "}{"
        , template = " <fn=2>%StdinReader%</fn> }{ |<fn=1> %cpu% </fn> | <fn=1>%memory% </fn>| <fn=1>%dynnetwork%</fn> | <fn=1><fc=#ee9a00>%date%</fc></fn> | %hostname% | <fn=1>%uname% </fn>| <fn=1>%CYVR% </fn>"
}
