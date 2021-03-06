Config { font = "xft:M+ 1p:size=15:antialias=true"
        , borderColor = "ffa738"
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
                , Run Cpu ["-L","3","-H","50","--normal","green","--high","red"] 10
                , Run Memory ["-t","Mem: <usedratio>%"] 10
                --, Run Swap [] 10
                -- , Run Com "uname" ["-s","-r"] "" 36000
                --, Run Date "%a %b %_d %Y %H:%M:%S" "date" 10
                , Run StdinReader
                , Run Com "uname" ["-s","-r"] "" 36000
        ]
        , sepChar = "%"
        , alignSep = "}{"
        , template = " %StdinReader% }{ | %cpu% | %memory% | %dynnetwork% | <fc=#ee9a00>%date%</fc> | %uname% | %CYVR% "
}
