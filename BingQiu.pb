title$ = "Bing Qiu"
If InitSprite()
Else
  MessageRequester(title$,"DirectX v.7 or later was unable to be initialized",#MB_ICONERROR)
  End 
EndIf 
If InitKeyboard() 
Else 
  MessageRequester(title$,"A keyboard was unable to be initialized!",#MB_ICONERROR)
  End 
EndIf 
If InitSound() 
  UseOGGSoundDecoder()
Else 
  MessageRequester(title$,"Sound was unable to be initialized!",#MB_ICONERROR)
  End
EndIf 

If InitJoystick()
  joystick = 1
Else
  joystick = 0
EndIf 
 
 
 ;OnErrorResume()

 Enumeration ; sprites
   #Paddle = 1;
   #Ball  
   #Block
   #Back = #Block+10
   #Numbers = 40
   #Letters = 50
 EndEnumeration
 
 
 Procedure BitmapText(Text$,x,y)

  Text$ = UCase(Text$) 
  Length = Len(Text$) 
  For k=1 To Length
    A$ = Mid(Text$, k,1)
    If A$=" "
      x+20 
    Else 
      v = Asc(A$)
      If v>=65 And v<=90
        v = #Letters + v - 65 ; 65 ASCII 'A'
      ElseIf v>=48 And v<=57
        v = #Numbers + v - 48 ; 48 ASCII '0' 
      ElseIf v=33
        v =  #Letters+26 ; 33 ASCII '!' 
      EndIf
      If IsSprite(v)
        DisplayTransparentSprite(v,x,y)
        x+SpriteWidth(v)
      EndIf 
    EndIf 
  Next 
EndProcedure 










 DataSection     ; ********* a includebinary file bigger .exe but noone can steal stuff :)
   
   ball: IncludeBinary "images\ball.bmp"
   paddle: IncludeBinary "images\paddle.bmp"
   back: IncludeBinary "images\back.bmp"
   block_1: IncludeBinary "images\block_1.bmp"
   block_2: IncludeBinary "images\block_2.bmp"
   block_3: IncludeBinary "images\block_3.bmp"
   block_4: IncludeBinary "images\block_4.bmp"
   block_5: IncludeBinary "images\block_5.bmp"
    
   a: IncludeBinary "images\Font\A.bmp"
   b: IncludeBinary "images\Font\B.bmp"
   c: IncludeBinary "images\Font\C.bmp"
   d: IncludeBinary "images\Font\D.bmp"
   e: IncludeBinary "images\Font\E.bmp"
   f: IncludeBinary "images\Font\F.bmp"
   g: IncludeBinary "images\Font\G.bmp"
   h: IncludeBinary "images\Font\H.bmp"
   i: IncludeBinary "images\Font\I.bmp"
   j: IncludeBinary "images\Font\J.bmp"
   k: IncludeBinary "images\Font\K.bmp"
   l: IncludeBinary "images\Font\L.bmp"
   m: IncludeBinary "images\Font\M.bmp"
   n: IncludeBinary "images\Font\N.bmp"
   o: IncludeBinary "images\Font\O.bmp"
   p: IncludeBinary "images\Font\P.bmp"
   q: IncludeBinary "images\Font\Q.bmp"
   r: IncludeBinary "images\Font\R.bmp"
   s: IncludeBinary "images\Font\S.bmp"
   t: IncludeBinary "images\Font\T.bmp"
   u: IncludeBinary "images\Font\U.bmp"
   v: IncludeBinary "images\Font\V.bmp"
   w: IncludeBinary "images\Font\W.bmp"
   x: IncludeBinary "images\Font\X.bmp"
   y: IncludeBinary "images\Font\Y.bmp"
   z: IncludeBinary "images\Font\Z.bmp"
   exclam: IncludeBinary "images\Font\!.bmp"
     
   0: IncludeBinary "images\Font\0.bmp"
   1: IncludeBinary "images\Font\1.bmp"
   2: IncludeBinary "images\Font\2.bmp"
   3: IncludeBinary "images\Font\3.bmp"
   4: IncludeBinary "images\Font\4.bmp"
   5: IncludeBinary "images\Font\5.bmp"
   6: IncludeBinary "images\Font\6.bmp"
   7: IncludeBinary "images\Font\7.bmp"
   8: IncludeBinary "images\Font\8.bmp"
   9: IncludeBinary "images\Font\9.bmp"
 

 EndDataSection 

Width = 15
Height = 24
Dim blocks.b(Width, Height)


screenX = 775
screenY = 520
If OpenWindow(0,200,200,screenX,screenY,#PB_Window_SystemMenu | #PB_Window_MinimizeGadget| #PB_Window_MaximizeGadget | #PB_Window_TitleBar | #PB_Window_SizeGadget,title$)

   Enumeration
     #M_Easy
     #M_Normal
     #M_Hard
     #M_Reset
     #M_Level
     #M_ResetHiScore    
     #M_Controls
     #M_ViewHiScores
     #M_About
     #M_Exit
     #M_MusicA
     #M_MusicB
     #M_MusicC
     #M_MusicD 
   EndEnumeration
  
    If CreateMenu(0, WindowID())
      MenuTitle("Mode")
        MenuItem(#M_Easy, "Easy")
        MenuItem(#M_Normal, "Normal")
        MenuItem(#M_Hard, "Hard")
      MenuTitle("Options")
        MenuItem(#M_Reset, "Reset")
        MenuItem(#M_Level, "Choose Level")
        MenuItem(#M_ResetHiScore, "Reset HiScore")
        MenuItem(#M_Controls, "View Controls")
        MenuItem(#M_ViewHiScores, "View HiScores")
        MenuItem(#M_About, "About")
        MenuBar()
        MenuItem( #M_Exit, "Exit")
    EndIf 
    
    ; open screen bigger than window that way the play area can be adjusted
  If OpenWindowedScreen(WindowID(0),0,0,screenX,screenY,0,0,0)  
    CatchSprite(#Ball,?ball,0)
    CatchSprite(#paddle,?paddle,0)
    CatchSprite(#back,?back,0)
    CatchSprite(#block,?block_1,0)
    CatchSprite(#block+1,?block_2,0)
    CatchSprite(#block+2,?block_3,0)
    CatchSprite(#block+3,?block_4,0)
    CatchSprite(#block+4,?block_5,0)
    
    CatchSprite(#Letters+0,?a,0)
    CatchSprite(#Letters+1,?b,0)
    CatchSprite(#Letters+2,?c,0)
    CatchSprite(#Letters+3,?d,0)
    CatchSprite(#Letters+4,?e,0)
    CatchSprite(#Letters+5,?f,0)
    CatchSprite(#Letters+6,?g,0)
    CatchSprite(#Letters+7,?h,0)
    CatchSprite(#Letters+8,?i,0)
    CatchSprite(#Letters+9,?j,0)
    CatchSprite(#Letters+10,?k,0)
    CatchSprite(#Letters+11,?l,0)
    CatchSprite(#Letters+12,?m,0)
    CatchSprite(#Letters+13,?n,0)
    CatchSprite(#Letters+14,?o,0)
    CatchSprite(#Letters+15,?p,0)
    CatchSprite(#Letters+16,?q,0)
    CatchSprite(#Letters+17,?r,0)
    CatchSprite(#Letters+18,?s,0)
    CatchSprite(#Letters+19,?t,0)
    CatchSprite(#Letters+20,?u,0)
    CatchSprite(#Letters+21,?v,0)
    CatchSprite(#Letters+22,?w,0)
    CatchSprite(#Letters+23,?x,0)
    CatchSprite(#Letters+24,?y,0)
    CatchSprite(#Letters+25,?z,0)
    CatchSprite(#Letters+26,?exclam,0)
    
    CatchSprite(#Numbers+0,?0,0) 
    CatchSprite(#Numbers+1,?1,0)
    CatchSprite(#Numbers+2,?2,0)
    CatchSprite(#Numbers+3,?3,0)
    CatchSprite(#Numbers+4,?4,0)
    CatchSprite(#Numbers+5,?5,0)
    CatchSprite(#Numbers+6,?6,0)
    CatchSprite(#Numbers+7,?7,0)
    CatchSprite(#Numbers+8,?8,0)
    CatchSprite(#Numbers+9,?9,0)
  
    Mode = 1 ; NORMAL

  Gosub newGame 
    
    Repeat

      ClearScreen(0,0,0)
      Gosub ExamineKeyboard 
      Gosub MoveBall
      Gosub GetEvents
      Gosub DrawStuff
      Gosub DrawMenu     
      FlipBuffers()
    
    Until playing <> 1 Or  event = #PB_Event_CloseWindow Or KeyboardPushed(#PB_Key_Escape)
    
    Goto GameEnd  
    
  Else
    MessageRequester("Tetris","A Screen unable to be initialized!",#MB_ICONERROR)  
  EndIf
Else
  MessageRequester("Tetris","A window was unable to be opened!",#MB_ICONERROR)
EndIf

; shouldn't get here.... but if it does
Goto GameEnd




;**********************************************************
;
;- GetEvents
;
;**********************************************************
GetEvents:
  EventID.l = WindowEvent()
         
    Select EventID
      Case #PB_Event_CloseWindow
        playing = 0
        Paused = 0
      Case #PB_EventMenu      ; A Menu item has been selected         
        Select EventMenuID()

          Case   #M_Easy
            If mode <> 0 
              Mode = 0    
              Gosub newGame
              Paused = 0
            Else
              MessageRequester("Block","You are playing Baby Mode.",0) 
            EndIf
            
          Case   #M_Normal
            If mode <> 1
              Mode = 1    
              Gosub newGame
              Paused = 0
            Else
              MessageRequester("Block","You are playing Normal Mode.",0) 
            EndIf
            
          Case   #M_Hard
            If mode <> 2  
              Mode = 2    
              Gosub newGame
              Paused = 0
            Else
              MessageRequester("Block","You are playing Block Mode.",0) 
            EndIf
                                 
          Case   #M_Reset
            Result = MessageRequester("Block","Are you sure that you want to Restart? "+var$,#PB_MessageRequester_YesNo)
            If Result = #PB_MessageRequester_Yes  
              t = Mode     
              Gosub newGame
              Mode = t
              Paused = 0
            EndIf
            
          Case   #M_Level
            var$ = InputRequester("Blocks","Choose your level 0-9","0")
            If Val(var$) >= 0 And Val(var$) <= 9             
              Result = MessageRequester("Block","Are you Sure? level "+var$,#PB_MessageRequester_YesNo)
              If Result = #PB_MessageRequester_Yes       
                Gosub newGame
                level = Val(var$)
                timeD = levelSpeed
                Paused = 0
              EndIf      
            Else
              MessageRequester("Blocks","Not a valid Selection",0)
            EndIf

          Case #M_Controls
            MessageRequester(title$,"Controls"+Chr(13)+"--------"+Chr(13)+"Space - Start Ball"+Chr(13)+"Up Arrow - Pause"+Chr(13)+"Left & Right Arrows - Move Paddle"+Chr(13)+"R - Reset"+Chr(13)+"Escape - Exit",0)
         
          Case #M_ViewHiScores
            MessageRequester(title$,"--------"+Chr(13)+Str(hiscore))
            
          Case #M_About
            MessageRequester(title$,"Programmed by: Kenneth Cason"+Chr(13)+"Email: reddragon72455@yahoo.com",0)
               
          Case #M_ResetHiScore
            temp = score
            score = 0
            hiscore = 0
            Gosub saveHiScore
            score = temp   
          
          Case #M_Exit
            playing = 0
            Paused = 0
            
                       
        EndSelect
    EndSelect
Return 




;**********************************************************
;
;- ExamineKeyboard
;
;**********************************************************
ExamineKeyboard:
  ExamineKeyboard()
  If joystick = 1
    ExamineJoystick()
  EndIf
  


  If  KeyboardPushed(#PB_Key_Right) Or (joystick = 1 And JoystickAxisX() = 1 )
    paddleX+paddleSpeed 
    If paddleX+paddleWidth > 620
      paddleX = 620 - paddleWidth
    EndIf
  EndIf

  If  KeyboardPushed(#PB_Key_Left) Or (joystick = 1 And JoystickAxisX() = -1 )
    paddleX-paddleSpeed
    If paddleX < 20
      paddleX = 20
    EndIf
  EndIf

If KeyboardPushed(#PB_Key_R) Or (joystick = 1 And JoystickButton(9) )
  Gosub newgame
EndIf


 Repeat 
    If WindowID(0)
      Event = WindowEvent() 
      If Event    
        Delay(10)
      EndIf   
    EndIf 
    
    Gosub getEvents
    
    ExamineKeyboard()
    If KeyboardReleased(#PB_Key_RightAlt) Or KeyboardReleased(#PB_Key_Up);pause
      If Paused = 0
        Gosub DrawStuff
        Gosub DrawMenu
        BitmapText("PAUSE",(Width*24)/2-50,(Height-1)*24/2)
        FlipBuffers()
        Paused = 1
      Else 
        Paused = 0
      EndIf 
    EndIf      
 Until paused = 0
 
   Gosub getEvents
   If joystick = 1
    If JoystickButton(10)
        Gosub DrawStuff
        Gosub DrawMenu
        BitmapText("PAUSE",(Width*24)/2-50,(Height-1)*24/2)
        FlipBuffers()
        Paused = 1
      FlipBuffers()
    EndIf
    Repeat
      If joystick = 1
        ExamineJoystick()
      EndIf
      If pausecounter < 0 
        If joystick = 1
          If JoystickButton(1) Or JoystickButton(2) Or JoystickButton(3) Or JoystickButton(4) Or JoystickButton(5) Or JoystickButton(6) Or JoystickButton(7) Or JoystickButton(8)
            paused = 0
            pausecounter = 20
          EndIf
       EndIf 
      Else
        pausecounter - 1
      EndIf 
    Until paused = 0
  EndIf   

Return

;**********************************************************
;
;- newGame
;
;**********************************************************
newGame:
  Gosub loadHiScore
  Gosub saveHiScore
    
  Dim blocks.b(Width,Height)
  For x = 0 To Width-1
    For y = 0 To Height-1
      Blocks(x,y) = 0
    Next
  Next
  lives = 5
  level = 0
  Gosub loadLevel
  Gosub setPosition

Return

;**********************************************************
;
;- levelUp
;
;**********************************************************
levelUp:
 
  Dim blocks.b(Width,Height)
  For x = 0 To Width-1
    For y = 0 To Height-1
      Blocks(x,y) = 0
    Next
  Next

  Gosub setPosition
  level + 1
  Gosub loadLevel ; redundant but useful   
Return


;**********************************************************
;
;- setPosition
;
;**********************************************************
setPosition:
  paddleX = 260
  paddleY = 480
  ballX = paddleX-20
  ballY = paddleY-120
  ballSpeed = 4
  paddleSpeed = 4
  paddleWidth = SpriteWidth(#paddle)
  ballWidth = SpriteWidth(#ball)
  angleX = 45
  angleY = 45
  playing = 1
Return



;**********************************************************
;
;- MoveBall
;
;**********************************************************
MoveBall:

    ballX = ballX + ballSpeed *Cos(angleX/360*6.28); 
    ballY = ballY + (ballSpeed*Sin(angleY/360*6.28));
    If SpritePixelCollision(#ball, ballX, ballY, #paddle, paddleX, paddleY)
      temp = ballX - paddleX
      If temp > -ballWidth And temp < 20      
        angleX = 35
      ElseIf temp >=20 And temp < 40
        angleX = 45
      ElseIf temp >=40 And temp < 55
        angleX = 65   
      ElseIf temp >=55 And temp < 65
        angleX = 90
      ElseIf temp >=65 And temp < 80
        angleX = 115   
      ElseIf temp >=80 And temp < 100
        angleX = 135
      ElseIf temp >=100
        angleX = 145
      EndIf
      angleY * -1
      ballY = paddleY - ballWidth
    EndIf
    If ballY <= 20
      angleY * -1
      ballY = 20
    EndIf
    If ballX <= 20
      angleX * -1
      angleY * -1
      ballX = 20
      ballSpeed*-1
    ElseIf ballX >= 620 - ballWidth
      angleX * -1
      angleY * -1
      ballX = 620 - ballWidth
      ballSpeed*-1
    ElseIf ballY > paddleY+30
      Gosub isDead
    EndIf
  For x = 0 To Width-1
    For y = 0 To Height-1
      If blocks(x,y) > 0
        If SpritePixelCollision(blocks(x,y)+1,x*40+20,y*20+20, #ball,ballX,ballY)
          blocks(x,y) - 1
          angleX * -1
          angleY * -1
          Gosub isWin
        EndIf
      EndIf
    Next
  Next
Return

;**********************************************************
;
;- loadHiScore
;
;**********************************************************
LoadHiScore:
  If ReadFile(0, "blocks.hs")
    hiscore   = ReadLong()+1234567890
    CloseFile(0)
  EndIf 
Return 

;**********************************************************
;
;- saveHiScore
;
;**********************************************************
SaveHiScore:
If score > hiscore
  hiscore = score
EndIf

If OpenFile(0, "bingqiu.hs")
  WriteLong(hiscore-1234567890)  ; baby size
  CloseFile(0)
EndIf 
Return 

;**********************************************************
;
;- isDead
;
;**********************************************************
isDead:
  If ballY > 500
    Gosub saveHiScore
    lives - 1
    If lives < 0 
      Gosub newGame
    Else
      Gosub setPosition
    EndIf
    Delay(1000)
      
  EndIf
Return


;**********************************************************
;
;- isWin
;
;**********************************************************
isWin:
    blocks = 0
    For y = 0 To 23
      For x = 1 To 15
        If blocks(x,y) > 0 
          blocks + 1
          Break 2
         EndIf
      Next
    Next
    If blocks = 0 ; win
      Gosub levelUp
      Delay(1000) 
    EndIf
Return 

;**********************************************************
;
;- loadLevel
;
;**********************************************************
LoadLevel:
  If ReadFile(0, "levels/"+Str(level)+".lvl")
    For y = 0 To 23
      str$ = ReadString()
      For x = 1 To 15
        blocks(x-1,y) = Val( StringField(str$,x,",") )
      Next
    Next
    CloseFile(0)
  EndIf 
Return 

;**********************************************************
;
;- drawStuff
;
;**********************************************************
drawStuff:
  DisplayTransparentSprite(#back,0,0)
  For x = 0 To Width-1
    For y = 0 To Height-1
      If blocks(x,y) > 0
        DisplaySprite(#Block+blocks(x,y)-1, x*40+20, y*20+20)
      EndIf
    Next
  Next
  DisplayTransparentSprite(#ball,ballX, ballY)
  DisplayTransparentSprite(#paddle,paddleX, paddleY)
Return


;**********************************************************
;
;- DrawMenu
;
;**********************************************************
DrawMenu:
  OffsetX = 640
  bitmapText("BINGQIU",OffsetX,10)
  bitmapText("MODE",OffsetX,35)
  If mode = 0
    bitmapText(" EASY",OffsetX,60) 
  ElseIf mode = 1
    bitmapText(" NORMAL",OffsetX,60) 
  ElseIf mode = 2 
    bitmapText(" HARD",OffsetX,60) 
  EndIf
  bitmapText("LEVEL",OffsetX,85)    
  bitmapText(" "+Str(level),OffsetX,110)
  bitmapText("SCORE",OffsetX,135)
  bitmapText(" "+Str(score),OffsetX,160)
  bitmapText("HISCORE",OffsetX,185)
  bitmapText(" "+Str(hiscore),OffsetX,210)
  bitmapText("LIVES",OffsetX,235)
  bitmapText(" "+Str(lives),OffsetX,260)
Return



;**********************************************************
;
;- GameEnd
;
;**********************************************************
GameEnd:
  Gosub SaveHiScore
  End   ; :D enjoy
; IDE Options = PureBasic v3.94 (Windows - x86)