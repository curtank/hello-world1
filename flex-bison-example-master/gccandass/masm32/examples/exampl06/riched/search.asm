; #########################################################################

CallSearchDlg proc

    invoke DialogBoxParam,hInstance,300,hWnd,ADDR SearchProc,0

    ret

CallSearchDlg endp

; #########################################################################

SearchProc proc hWin   :DWORD,
                uMsg   :DWORD,
                wParam :DWORD,
                lParam :DWORD

    LOCAL hEdit      :DWORD

      .if uMsg == WM_INITDIALOG
        szText dlgTitle," Find Text"
        invoke SendMessage,hWin,WM_SETTEXT,0,ADDR dlgTitle

        invoke GetDlgItem,hWin,3093
        mov hCheck1, eax
        invoke GetDlgItem,hWin,3094
        mov hCheck2, eax

        .if CaseFlag == 1
          invoke SendMessage,hCheck1,BM_SETCHECK,BST_CHECKED,0
        .endif

        .if WholeWord == 1
          invoke SendMessage,hCheck2,BM_SETCHECK,BST_CHECKED,0
        .endif

      .elseif uMsg == WM_COMMAND
      
        .if wParam == 3091                ; cancel button
          jmp OutaHere

        .elseif wParam == IDOK            ; default enter key
          jmp FindMe

        .elseif wParam == 3090            ; find button
          FindMe:
          invoke GetDlgItem,hWin,3092
            mov hEdit, eax
            invoke SendMessage,hEdit,WM_GETTEXTLENGTH,0,0
            mov TextLen, eax
            .if TextLen == 0
              return 0
            .else

            invoke SendMessage,hCheck1,BM_GETCHECK,0,0
              .if eax == BST_CHECKED
                mov CaseFlag, 1
              .else
                mov CaseFlag, 0
              .endif

            invoke SendMessage,hCheck2,BM_GETCHECK,0,0
              .if eax == BST_CHECKED
                mov WholeWord, 1
              .else
                mov WholeWord, 0
              .endif

              inc TextLen
              invoke SendMessage,hEdit,WM_GETTEXT,TextLen,ADDR SearchText
              invoke TextFind,ADDR SearchText,TextLen
              jmp OutaHere
            .endif

        .elseif wParam == IDCANCEL  ; default escape button
          jmp OutaHere

        .endif

      .elseif uMsg == WM_CLOSE
        OutaHere:
        invoke EndDialog,hWin,0

      .endif

    mov eax, 0

    ret

SearchProc endp

; #########################################################################

TextFind proc lpBuffer:DWORD, len:DWORD

    LOCAL tp :DWORD
    LOCAL tl :DWORD
    LOCAL sch:DWORD
    LOCAL ft :FINDTEXT
    LOCAL Cr :CHARRANGE

    invoke SendMessage,hRichEd,WM_GETTEXTLENGTH,0,0
    mov tl, eax

    invoke SendMessage,hRichEd,EM_EXGETSEL,0,ADDR Cr

    inc Cr.cpMin                 ; inc starting pos by 1 so not searching
                                 ; same position repeatedly
    m2m ft.chrg.cpMin, Cr.cpMin  ; start pos
    m2m ft.chrg.cpMax, tl        ; end of text
    m2m ft.lpstrText, lpBuffer   ; string to search for

    ; 0 = case insensitive
    ; 2 = FT_WHOLEWORD
    ; 4 = FT_MATCHCASE
    ; 6 = FT_WHOLEWORD or FT_MATCHCASE

    mov sch, 0
    .if CaseFlag == 1
      or sch, 4
    .endif
    .if WholeWord == 1
      or sch, 2
    .endif

    invoke SendMessage,hRichEd,EM_FINDTEXT,sch,ADDR ft
    mov tp, eax

    .if tp == -1
      szText nomatch,"No further matches"
      invoke MessageBox,hWnd,ADDR nomatch,ADDR szDisplayName,MB_OK
      ret
    .endif

    m2m Cr.cpMin,tp     ; put start pos into structure
    dec len             ; dec length for zero terminator
    mov eax, len
    add tp,eax          ; add length to character pos
    m2m Cr.cpMax,tp     ; put end pos into structure

    ; ------------------------------------
    ; set the selection to the search word
    ; ------------------------------------
    invoke SendMessage,hRichEd,EM_EXSETSEL,0,ADDR Cr

    ret

TextFind endp

; #########################################################################
