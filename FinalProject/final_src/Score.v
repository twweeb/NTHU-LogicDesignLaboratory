`define LetterS ((300 <= col_addr) && (col_addr < 320) && (90 <= row_addr) && (row_addr < 94)) || ((300 <= col_addr) && (col_addr < 320) && (108 <= row_addr) && (row_addr < 112)) || ((300 <= col_addr) && (col_addr < 320) && (126 <= row_addr) && (row_addr < 130)) || ((300 <= col_addr) && (col_addr < 304) && (90 <= row_addr) && (row_addr < 112)) || ((316 <= col_addr) && (col_addr < 320) && (108 <= row_addr) && (row_addr < 130))
`define LetterC ((330 <= col_addr) && (col_addr < 350) && (90 <= row_addr) && (row_addr < 94)) || ((330 <= col_addr) && (col_addr < 350) && (126 <= row_addr) && (row_addr < 130)) || ((330 <= col_addr) && (col_addr < 334) && (90 <= row_addr) && (row_addr < 130))
`define LetterO ((360 <= col_addr) && (col_addr < 380) && (90 <= row_addr) && (row_addr < 94)) || ((360 <= col_addr) && (col_addr < 380) && (126 <= row_addr) && (row_addr < 130)) || ((360 <= col_addr) && (col_addr < 364) && (90 <= row_addr) && (row_addr < 130))  || ((376 <= col_addr) && (col_addr < 380) && (90 <= row_addr) && (row_addr < 130))
`define LetterR ((390 <= col_addr) && (col_addr < 410) && (90 <= row_addr) && (row_addr < 94)) || ((390 <= col_addr) && (col_addr < 410) && (106 <= row_addr) && (row_addr < 110)) || ((390 <= col_addr) && (col_addr < 394) && (90 <= row_addr) && (row_addr < 130))  || ((406 <= col_addr) && (col_addr < 410) && (90 <= row_addr) && (row_addr < 110)) || ((402 <= col_addr) && (col_addr < 406) && (110 <= row_addr) && (row_addr < 114)) || ((404 <= col_addr) && (col_addr < 408) && (114 <= row_addr) && (row_addr < 118)) || ((406 <= col_addr) && (col_addr < 410) && (118 <= row_addr) && (row_addr < 130))
`define LetterE ((420 <= col_addr) && (col_addr < 440) && (90 <= row_addr) && (row_addr < 94)) || ((420 <= col_addr) && (col_addr < 440) && (108 <= row_addr) && (row_addr < 112)) || ((420 <= col_addr) && (col_addr < 440) && (126 <= row_addr) && (row_addr < 130)) || ((420 <= col_addr) && (col_addr < 424) && (90 <= row_addr) && (row_addr < 130))

`define x3 450
`define x2 480
`define x1 510
`define x0 540
`define y2 90

`define Zero0	((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x0 <= col_addr) && (col_addr < `x0+4) && (`y2 <= row_addr) && (row_addr < `y2+40)) || ((`x0+16 <= col_addr) && (col_addr < `x0+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define One0	(`x0+16 <= col_addr) && (col_addr < `x0+20) && (`y2 <= row_addr) && (row_addr < `y2+40)
`define Two0	((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x0 <= col_addr) && (col_addr < `x0+4) && (`y2+18 <= row_addr) && (row_addr < `y2+40)) || ((`x0+16 <= col_addr) && (col_addr < `x0+20) && (`y2 <= row_addr) && (row_addr < `y2+22))  
`define Three0	((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x0+16 <= col_addr) && (col_addr < `x0+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define Four0	((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x0 <= col_addr) && (col_addr < `x0+4) && (`y2 <= row_addr) && (row_addr < `y2+22)) || ((`x0+16 <= col_addr) && (col_addr < `x0+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define Five0	((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x0 <= col_addr) && (col_addr < `x0+4) && (`y2 <= row_addr) && (row_addr < `y2+22)) || ((`x0+16 <= col_addr) && (col_addr < `x0+20) && (`y2+18 <= row_addr) && (row_addr < `y2+40))
`define Six0	((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x0 <= col_addr) && (col_addr < `x0+4) && (`y2 <= row_addr) && (row_addr < `y2+40)) || ((`x0+16 <= col_addr) && (col_addr < `x0+20) && (`y2+18 <= row_addr) && (row_addr < `y2+40))
`define Seven0	((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x0+16 <= col_addr) && (col_addr < `x0+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define Eight0	((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x0 <= col_addr) && (col_addr < `x0+4) && (`y2 <= row_addr) && (row_addr < `y2+40)) || ((`x0+16 <= col_addr) && (col_addr < `x0+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define Nine0	((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x0 <= col_addr) && (col_addr < `x0+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x0 <= col_addr) && (col_addr < `x0+4) && (`y2 <= row_addr) && (row_addr < `y2+22)) || ((`x0+16 <= col_addr) && (col_addr < `x0+20) && (`y2 <= row_addr) && (row_addr < `y2+40))

`define Zero1	((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x1 <= col_addr) && (col_addr < `x1+4) && (`y2 <= row_addr) && (row_addr < `y2+40)) || ((`x1+16 <= col_addr) && (col_addr < `x1+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define One1	(`x1+16 <= col_addr) && (col_addr < `x1+20) && (`y2 <= row_addr) && (row_addr < `y2+40)
`define Two1	((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x1 <= col_addr) && (col_addr < `x1+4) && (`y2+18 <= row_addr) && (row_addr < `y2+40)) || ((`x1+16 <= col_addr) && (col_addr < `x1+20) && (`y2 <= row_addr) && (row_addr < `y2+22))  
`define Three1	((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x1+16 <= col_addr) && (col_addr < `x1+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define Four1	((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x1 <= col_addr) && (col_addr < `x1+4) && (`y2 <= row_addr) && (row_addr < `y2+22)) || ((`x1+16 <= col_addr) && (col_addr < `x1+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define Five1	((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x1 <= col_addr) && (col_addr < `x1+4) && (`y2 <= row_addr) && (row_addr < `y2+22)) || ((`x1+16 <= col_addr) && (col_addr < `x1+20) && (`y2+18 <= row_addr) && (row_addr < `y2+40))
`define Six1	((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x1 <= col_addr) && (col_addr < `x1+4) && (`y2 <= row_addr) && (row_addr < `y2+40)) || ((`x1+16 <= col_addr) && (col_addr < `x1+20) && (`y2+18 <= row_addr) && (row_addr < `y2+40))
`define Seven1	((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x1+16 <= col_addr) && (col_addr < `x1+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define Eight1	((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x1 <= col_addr) && (col_addr < `x1+4) && (`y2 <= row_addr) && (row_addr < `y2+40)) || ((`x1+16 <= col_addr) && (col_addr < `x1+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define Nine1	((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x1 <= col_addr) && (col_addr < `x1+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x1 <= col_addr) && (col_addr < `x1+4) && (`y2 <= row_addr) && (row_addr < `y2+22)) || ((`x1+16 <= col_addr) && (col_addr < `x1+20) && (`y2 <= row_addr) && (row_addr < `y2+40))

`define Zero2	((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x2 <= col_addr) && (col_addr < `x2+4) && (`y2 <= row_addr) && (row_addr < `y2+40)) || ((`x2+16 <= col_addr) && (col_addr < `x2+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define One2	(`x2+16 <= col_addr) && (col_addr < `x2+20) && (`y2 <= row_addr) && (row_addr < `y2+40)
`define Two2	((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x2 <= col_addr) && (col_addr < `x2+4) && (`y2+18 <= row_addr) && (row_addr < `y2+40)) || ((`x2+16 <= col_addr) && (col_addr < `x2+20) && (`y2 <= row_addr) && (row_addr < `y2+22))  
`define Three2	((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x2+16 <= col_addr) && (col_addr < `x2+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define Four2	((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x2 <= col_addr) && (col_addr < `x2+4) && (`y2 <= row_addr) && (row_addr < `y2+22)) || ((`x2+16 <= col_addr) && (col_addr < `x2+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define Five2	((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x2 <= col_addr) && (col_addr < `x2+4) && (`y2 <= row_addr) && (row_addr < `y2+22)) || ((`x2+16 <= col_addr) && (col_addr < `x2+20) && (`y2+18 <= row_addr) && (row_addr < `y2+40))
`define Six2	((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x2 <= col_addr) && (col_addr < `x2+4) && (`y2 <= row_addr) && (row_addr < `y2+40)) || ((`x2+16 <= col_addr) && (col_addr < `x2+20) && (`y2+18 <= row_addr) && (row_addr < `y2+40))
`define Seven2	((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x2+16 <= col_addr) && (col_addr < `x2+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define Eight2	((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x2 <= col_addr) && (col_addr < `x2+4) && (`y2 <= row_addr) && (row_addr < `y2+40)) || ((`x2+16 <= col_addr) && (col_addr < `x2+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define Nine2	((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x2 <= col_addr) && (col_addr < `x2+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x2 <= col_addr) && (col_addr < `x2+4) && (`y2 <= row_addr) && (row_addr < `y2+22)) || ((`x2+16 <= col_addr) && (col_addr < `x2+20) && (`y2 <= row_addr) && (row_addr < `y2+40))

`define Zero3	((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x3 <= col_addr) && (col_addr < `x3+4) && (`y2 <= row_addr) && (row_addr < `y2+40)) || ((`x3+16 <= col_addr) && (col_addr < `x3+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define One3	(`x3+16 <= col_addr) && (col_addr < `x3+20) && (`y2 <= row_addr) && (row_addr < `y2+40)
`define Two3	((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x3 <= col_addr) && (col_addr < `x3+4) && (`y2+18 <= row_addr) && (row_addr < `y2+40)) || ((`x3+16 <= col_addr) && (col_addr < `x3+20) && (`y2 <= row_addr) && (row_addr < `y2+22))  
`define Three3	((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x3+16 <= col_addr) && (col_addr < `x3+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define Four3	((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x3 <= col_addr) && (col_addr < `x3+4) && (`y2 <= row_addr) && (row_addr < `y2+22)) || ((`x3+16 <= col_addr) && (col_addr < `x3+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define Five3	((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x3 <= col_addr) && (col_addr < `x3+4) && (`y2 <= row_addr) && (row_addr < `y2+22)) || ((`x3+16 <= col_addr) && (col_addr < `x3+20) && (`y2+18 <= row_addr) && (row_addr < `y2+40))
`define Six3	((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x3 <= col_addr) && (col_addr < `x3+4) && (`y2 <= row_addr) && (row_addr < `y2+40)) || ((`x3+16 <= col_addr) && (col_addr < `x3+20) && (`y2+18 <= row_addr) && (row_addr < `y2+40))
`define Seven3	((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x3+16 <= col_addr) && (col_addr < `x3+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define Eight3	((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x3 <= col_addr) && (col_addr < `x3+4) && (`y2 <= row_addr) && (row_addr < `y2+40)) || ((`x3+16 <= col_addr) && (col_addr < `x3+20) && (`y2 <= row_addr) && (row_addr < `y2+40))
`define Nine3	((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2 <= row_addr) && (row_addr < `y2+4)) || ((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2+18 <= row_addr) && (row_addr < `y2+22)) || ((`x3 <= col_addr) && (col_addr < `x3+20) && (`y2+36 <= row_addr) && (row_addr < `y2+40)) || ((`x3 <= col_addr) && (col_addr < `x3+4) && (`y2 <= row_addr) && (row_addr < `y2+22)) || ((`x3+16 <= col_addr) && (col_addr < `x3+20) && (`y2 <= row_addr) && (row_addr < `y2+40))

module Score(
    input clk,
    input wire [8:0] row_addr,
    input wire [9:0] col_addr,
    input wire game_status,
    input wire START,
    input wire RESET,
    output reg [31:0] score,
    output reg px
   );
    reg [159:0] pattern [7:0];
	reg [31:0] score;
	reg [31:0] score_cnt;

	initial begin//set the initial value
		score <= 1'b0;
		score_cnt <= 0;
	end

	always @ (posedge clk or posedge RESET) begin
		if(RESET==1)begin
			px<=1'b0;//if reset , don't display the score
		end
		else if(`LetterS || `LetterC || `LetterO || `LetterR || `LetterE) begin
			px<=1'b1; //display score
		end
		else if(((score[3:0] == 0) && (`Zero0)) ||//every 4 regs shows ong number.
				((score[3:0] == 4'd1) && (`One0)) ||
				((score[3:0] == 4'd2) && (`Two0)) ||
				((score[3:0] == 4'd3) && (`Three0)) ||
				((score[3:0] == 4'd4) && (`Four0)) ||
				((score[3:0] == 4'd5) && (`Five0)) ||
				((score[3:0] == 4'd6) && (`Six0)) ||
				((score[3:0] == 4'd7) && (`Seven0)) ||
				((score[3:0] == 4'd8) && (`Eight0)) ||
				((score[3:0] == 4'd9) && (`Nine0))||
				
				((score[7:4] == 0) && (`Zero1)) ||
				((score[7:4] == 1) && (`One1)) ||
				((score[7:4] == 2) && (`Two1)) ||
				((score[7:4] == 3) && (`Three1)) ||
				((score[7:4] == 4) && (`Four1)) ||
				((score[7:4] == 5) && (`Five1)) ||
				((score[7:4] == 6) && (`Six1)) ||
				((score[7:4] == 7) && (`Seven1)) ||
				((score[7:4] == 8) && (`Eight1)) ||
				((score[7:4] == 9) && (`Nine1)) ||
				
				((score[11:8] == 0) && (`Zero2)) ||
				((score[11:8] == 1) && (`One2)) ||
				((score[11:8] == 2) && (`Two2)) ||
				((score[11:8] == 3) && (`Three2)) ||
				((score[11:8] == 4) && (`Four2)) ||
				((score[11:8] == 5) && (`Five2)) ||
				((score[11:8] == 6) && (`Six2)) ||
				((score[11:8] == 7) && (`Seven2)) ||
				((score[11:8] == 8) && (`Eight2)) ||
				((score[11:8] == 9) && (`Nine2)) ||
				
				((score[15:12] == 0) && (`Zero3)) ||
				((score[15:12] == 1) && (`One3)) ||
				((score[15:12] == 2) && (`Two3)) ||
				((score[15:12] == 3) && (`Three3)) ||
				((score[15:12] == 4) && (`Four3)) ||
				((score[15:12] == 5) && (`Five3)) ||
				((score[15:12] == 6) && (`Six3)) ||
				((score[15:12] == 7) && (`Seven3)) ||
				((score[15:12] == 8) && (`Eight3)) ||
				((score[15:12] == 9) && (`Nine3))		// display four-digit number score
				) begin
			px<=1'b1;
		end
		else begin
			px<=1'b0;
		end
	end
	
	always @ (posedge clk or posedge RESET or posedge START) begin		// a 1s_counter in BCD code, to produce score
		if(START||RESET) begin//if reset or start, score = 0;
			score <= 0;
			score_cnt <= 0;
		end
		else if(game_status==0) ;//if game over, score don't change.
		else if(score_cnt < 25_000_000) score_cnt <= score_cnt + 1;
		else begin// caculate score in decimal system.
			score_cnt <= 0;
			if(score[3:0] == 4'b1001) begin//if reach 9 ,carry a number.
				score[3:0] <= 0;
				if(score[7:4] == 4'b1001) begin
					score[7:4] <= 0;
					if(score[11:8] == 4'b1001) begin
						score[11:8] <= 0;
						if(score[15:12] == 4'b1001) begin
							score[15:12] <= 0;
						end
						else score[15:12] <= score[15:12] + 1;
					end
					else score[11:8] <= score[11:8] + 1;
				end
				else score[7:4] <= score[7:4] + 1;
			end
			else score[3:0] <= score[3:0] + 1;
		end
	end
endmodule

