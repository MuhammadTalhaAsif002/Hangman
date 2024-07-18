[org 0x100]
jmp start
clearScreen:	;;from book pg no. 110
    push es
	push ax
	push cx
    push di
    mov ax,0xb800
    mov es,ax
    xor di,di
    mov ax,0x0720
    mov cx,2000
    cld
    rep stosw
	pop di
	pop cx
	pop ax
	pop es
	ret

Change_Background_Color:
    push ax
    push es
    push di
    push cx
    mov ax,0xb800
    mov es,ax
    mov di,0
    mov ah,0x30
    mov al,' '
    mov cx,2000
    cli
    rep stosw
    pop cx
    pop di
    pop es
    pop ax
	ret
GenRandNum:
    push bp
    mov bp,sp
    push cx
    push ax
    push dx
    MOV AH, 00h ; interrupts to get system time
    INT 1AH ; CX:DX now hold number of clock ticks since midnight
    mov ax, dx
    xor dx, dx
    mov cx, 10;
    div cx ; here dx contains the remainder of the division - from 0 to 9
    mov word[Index_From_RandNum],dx;
    pop cx;
    pop ax;
    pop dx;
    pop bp;
	ret
;;;;;;;;;;;;;PRINTSTR  from book pg no. 113
printstr: 
push bp
mov bp, sp
push es
pusha
push ds
pop es ; load ds in es
mov di, [bp+4] ; point di to string
mov cx, 0xffff ; load maximum number in cx
xor al, al ; load a zero in al
repne scasb ; find zero in the string
mov ax, 0xffff ; load maximum number in ax
sub ax, cx ; find change in cx
dec ax ; exclude null from length
jz exit ; no printing if string is empty
mov cx, ax ; load string length in cx
mov ax, 0xb800
mov es, ax ; point es to video base
mov al, 80 ; load al with columns per row
mul byte [bp+8] ; multiply with y position
add ax, [bp+10] ; add x position
shl ax, 1 ; turn into byte offset
mov di,ax ; point di to required location
mov si, [bp+4] ; point si to string
mov ah, [bp+6] ; load attribute in ah
cld ; auto increment mode
nextcharacter: lodsb ; load next char in al
stosw ; print char/attribute pair
loop nextcharacter ; repeat for the whole string
exit: popa
pop es
pop bp
ret 8 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Home_Screen:
    call Change_Background_Color
	mov ax, 0
    push ax ; x position
    mov ax, 4
    push ax ; y position
    mov ax, 0x02 ; Blue on black attribute
    push ax ; attribute
    mov ax, line1
    push ax ; address of message
    call printstr
	mov ax, 0
    push ax ; x position
    mov ax, 5
    push ax ; y position
    mov ax, 0x02 ; Blue on black attribute
    push ax ; attribute
    mov ax, line2
    push ax ; address of message
    call printstr
	mov ax, 0
    push ax ; x position
    mov ax, 6
    push ax ; y position
    mov ax, 0x02 ; Blue on black attribute
    push ax ; attribute
    mov ax, line3
    push ax ; address of message
    call printstr
	mov ax, 0
    push ax ; x position
    mov ax, 7
    push ax ; y position
    mov ax, 0x02 ; Blue on black attribute
    push ax ; attribute
    mov ax, line4
    push ax ; address of message
    call printstr
	mov ax, 0
    push ax ; x position
    mov ax, 8
    push ax ; y position
    mov ax, 0x02 ; Blue on black attribute
    push ax ; attribute
    mov ax, line5
    push ax ; address of message
    call printstr
	mov ax, 0
    push ax ; x position
    mov ax, 9
    push ax ; y position
    mov ax, 0x02 ; Blue on black attribute
    push ax ; attribute
    mov ax, line6
    push ax ; address of message
    call printstr
    mov ax, 15
    push ax ; x position
    mov ax, 13
    push ax ; y position
    mov ax, 0x07 ; White on black attribute
    push ax ; attribute
    mov ax, Members
    push ax ; address of message
    call printstr
    mov ax, 17
    push ax ; x position
    mov ax, 14
    push ax ; y position
    mov ax, 0x03 ; Cyan on black attribute
    push ax ; attribute
    mov ax, member1
    push ax ; address of message
    call printstr
    mov ax, 17
    push ax ; x position
    mov ax, 15
    push ax ; y position
    mov ax, 0x03 ; Cyan on black attribute (same as member 1)
    push ax ; attribute
    mov ax, member2
    push ax ; address of message
    call printstr
    mov ax, 17
    push ax ; x position
    mov ax, 16
    push ax ; y position
    mov ax, 0x03 ; Cyan on black attribute (same as member 1)
    push ax ; attribute
    mov ax, member3
    push ax ; address of message
    call printstr
    mov ax, 20
    push ax ; x position
    mov ax, 18
    push ax ; y position
    mov ax, 0x06 ; Yellow on black attribute
    push ax ; attribute
    mov ax, message2
    push ax ; address of message
    call printstr
	;;Press any key
    mov ah, 0
    int 16h
    ret
PrintBorder:
	push bp
	mov bp, sp
	push es
	push ax
	push cx
	push si
	push di
	mov ax, 0xb800
	mov es, ax ; point es to video base
	mov al, 80 ; load al with columns per row
	mul byte [bp+12] ; multiply with row number
	add ax, [bp+10] ; add col
	shl ax, 1 ; turn into byte offset
	mov di, ax ; point di to required location
	mov ah, [bp+4] ; load attribute in ah
	mov cx, [bp+6]
	sub cx, [bp+10]
	top_line: mov al, 0x2D ; ASCII of '-'
	mov [es:di], ax ; show this char on screen
	add di, 2 ; move to next screen location
	call delay;
	loop top_line ; repeat the operation cx times
	mov cx, [bp+8]
	sub cx, [bp+12]
	add di, 160
	right_line: mov al, 0x7c ; ASCII of '|'
	mov [es:di], ax ; show this char on screen
	add di, 160 ; move to next screen location
	call delay;
	loop right_line ; repeat the operation cx times
	mov cx, [bp+6]
	sub cx, [bp+10]
	sub di, 2
	bottom_line: mov al, 0x2D ; ASCII of '-'
	mov [es:di], ax ; show this char on screen
	sub di, 2 ; move to next screen location
	call delay;
	loop bottom_line ; repeat the operation cx times
	mov cx, [bp+8]
	sub cx, [bp+12]
	sub di, 160
	left_line: mov al, 0x7c ; ASCII of '|'
	mov [es:di], ax ; show this char on screen
	sub di, 160 ; move to next screen location
	call delay;
	loop left_line ; repeat the operation cx times
	pop di
	pop si
	pop cx
	pop ax
	pop es
	pop bp
	ret 10
delay: 
	push cx
	mov cx, 0xFFFF
	delay_loop: loop delay_loop
	pop cx
	ret
;---------------------------------------------
printInputline:
	pusha
	mov ax, 52
	push ax ; push x position
	mov ax, 13
	push ax ; push y position
	mov ax, 2 ; blue on black attribute
	push ax ; push attribute
	mov ax, Input_Msg
	push ax ; push address of message
	call printstr
    popa
	ret

;----------------------------------------------------
Draw_Man:
    pusha
    mov cx,[part_No]
	Rope_Part:
		cmp cx,0
		jne Head_Part
		call Print_Rope
		jmp Exit_of_DrawMan
    Head_Part:
		cmp cx,1
		jne Body_Part
        call Print_Head
        jmp Exit_of_DrawMan
    Body_Part:
		cmp cx,2
		jne Arms_Part
        call Print_Body
        jmp Exit_of_DrawMan
    Arms_Part:
		cmp cx,3
		jne Legs_Part
        call printarms
        jmp Exit_of_DrawMan
    Legs_Part:
        call printlegs
    Exit_of_DrawMan:
		popa
		ret
;=========================================================
Print_Rope:
    mov cx, 2
    pusha
	mov di,692
    rope_line:
        mov al, 0x7c ; ASCII of '|'
        mov ah, 0x44 
        mov [es:di], ax
        add di, 160
        call delay
    loop rope_line
    popa
    ret	
Print_Head:
    push ax
    mov ax, 5
    push ax ; top
    mov ax, 24
    push ax ; left
    mov ax, 8
    push ax ; bottom
    mov ax, 29
    push ax ; right
    mov ax, 0x44 ; Red FG
    push ax ; attribute
    call PrintBorder
pop ax
ret
Print_Body:
    mov cx, 7
    pusha
	mov di,1652
    Body_line:
        mov al, 0x7c ; ASCII of '|'
        mov ah, 0x44 
        mov [es:di], ax
        add di, 160
        call delay
    loop Body_line
    popa
    ret	
printarms:
	mov cx, 5
    pusha
	mov di,1652
    Right_Arm_line:
        mov al, 0x5c ; ASCII of '\'
        mov ah, 0x44 
        mov [es:di], ax
        add di, 164
        call delay
        loop Right_Arm_line
		mov cx, 5
		mov di,1652
	Left_Arm_line:
        mov al, 0x2f ; ASCII of '/'
        mov ah, 0x44 
        mov [es:di], ax
        add di, 156
        call delay
        loop Left_Arm_line
    popa
    ret
printlegs:
	mov cx, 5
    pusha
	mov di,2612
    Right_Leg_line:
    mov al, 0x5c ; ASCII of '\'
    mov ah, 0x44 
        mov [es:di], ax
        add di, 162
        call delay
        loop Right_Leg_line
		mov cx, 5
		mov di,2612
		mov al, 0x2f ; ASCII of '/'
	Left_Leg_line:   
        mov [es:di], ax
        add di, 158
        call delay
        loop Left_Leg_line
    popa
    ret
;;====================================================================================
Print_Charcter:
    push bp
    mov bp,sp
    pusha
	mov ax,0xb800
    mov es,ax
	mov di,2066
	mov cx,[bp+4]
    mov si,[bp+6]
    jcxz Print_LastWord
    Print_Char_on_position:
        sub di,4
    loop Print_Char_on_position
    Print_LastWord:
    mov ah,0x34
    mov al,[si]
	cmp [es:di],ax
	je do_not_move_charcter
	jmp move_character
do_not_move_charcter:
	dec word[Correct_Guess_count]
	jmp popping
move_character:
    mov [es:di],ax
popping:
    popa
    pop bp
	retn
;==========================================================================
Game_Loop:
    pusha
	    mov ax, 42
		push ax ; x position
		mov ax, 15
		push ax ; y position
		mov ax, 0x04 ; Blue on black attribute
		push ax ; attribute
		mov ax, Hint_Msg
		push ax ; address of message
		call printstr
	mov si,Hints
    call GenRandNum
    mov cx,[Index_From_RandNum]
	jcxz increment
	jmp Hints_Corresponding_SI
	increment:
		add cx,1
    Hints_Corresponding_SI:
        add si,20
    loop Hints_Corresponding_SI
    mov  ax,0xb800 ;;here i am adding indexes to move to that random num
    mov  es,ax
    mov di,2498
    mov ah,0x4
    cld
	mov cx,20
    nextchar: 
		mov al,[si]
		mov [es:di],ax
		add di,2
		add si,1
    loop nextchar
	mov si,Words
    mov cx,[Index_From_RandNum]
	jcxz increment_Words
	jmp Word_Corresponding_SI
	increment_Words:
		add cx,1
    Word_Corresponding_SI:
        add si,4
    loop Word_Corresponding_SI	
	mov bx,si		;;it is for setting characters position while taking input
    Word_Input_Loop:
		mov cx,4
		mov si,bx
        mov ah,0
        int 0x16
        checkIncompleteWord:
            cmp al,[si]
            je CharFound
            add si,1
        loop checkIncompleteWord
        CharNotFound:
            call Draw_Man
			add word[part_No],1
            cmp word[part_No],5
			jne Word_Input_Loop
			jmp Print_Died_MSG
        CharFound:
			add word[Correct_Guess_count],1
            push si
			push cx ; index of char to print
            call Print_Charcter
            cmp word[Correct_Guess_count],4
			jne Word_Input_Loop
            jmp PrintWinningMSG
		Exit_from_InputLoop:
		popa
		jmp End
		iret
;;=======================================================================================================
	Print_Died_MSG:
		call Change_Background_Color
		mov ax, 32
		push ax ; push x position
		mov ax, 11
		push ax ; push y position
		mov ax, 0x04 ; red on black attribute
		push ax ; push attribute
		mov ax, Died_Message
		push ax ; push address of message
		call printstr
		call Print_ThankYou
		jmp Exit_from_InputLoop
	PrintWinningMSG:
		call Change_Background_Color
		mov ax, 28
		push ax ; x position
		mov ax, 11
		push ax ; y position
		mov ax, 0x02 ; green on black attribute
		push ax ; attribute
		mov ax, Win_Message
		push ax ; address of message
		call printstr
		call Print_ThankYou
	Print_ThankYou:
		mov ax, 26
		push ax ; x position
		mov ax, 13
		push ax ; y position
		mov ax, 0x03 ; Blue on black attribute
		push ax ; attribute
		mov ax, ThanksMSG
		push ax ; address of message
		call printstr
		jmp End
		ret
	Play_Again_Choice:
		mov ax, 20
		push ax ; x position
		mov ax, 15
		push ax ; y position
		mov ax, 2 ; Green on black attribute
		push ax ; attribute
		mov ax, Play_Again
		push ax ; address of message
		call printstr  
		mov ah,0
		int 16h
		cmp al,'y'
		je Main_Screen
		cmp al,'Y'
		je Main_Screen
		ret
	ResetGame:		;;it is for resetting credentials in case of play again
    mov word [part_No], 0
	mov word[Index_From_RandNum],0
	mov word[Correct_Guess_count],0
    ret
;;=========================================================================================================================
start:
	call Home_Screen
Main_Screen:
	call ResetGame
	call Change_Background_Color
	call printInputline
	mov ax, 3
	push ax ; top
	mov ax, 3
	push ax ; left
	mov ax, 23
	push ax ; bottom
	mov ax, 38
	push ax ; right number
	mov ax, 0x00 ; Red FG
	push ax ; attribute
    call PrintBorder
    call Game_Loop
End:
	call Play_Again_Choice
	call clearScreen
	mov ax,0x4c00
	int 0x21
;;=================================================================================================================
Members : dw 'Developed by : '
member1: dw 'Abdullah  (22L-7500) '
member2: dw 'Sharjeel  (22L-7526) '
member3: dw 'Talha Asif(22L-7510) '
message2: dw 'Press any key to Continue'
Win_Message: dw 'Hurrah! Man is Safe. '
Input_Msg: dw 'Enter word : - - - - '
Hint_Msg: dw 'Hint : '
Words: dw 'lamp','road','time','bank','fire','wind','leaf','bird','fish','star', 0
Hints: dw 'Source of light     ','Path for vehicles   ','Clock measures this ','Finance institution ','Burns and give light','Movement of air     ',' Part of a plant    ','Feathered creature  ','Aquatic animal      ','Luminous celestial  ', 0
Index_From_RandNum:dw 0
Correct_Guess_count:dw 0
Play_Again: dw 'Want to play again? (Y for Yes / N for No) '
Died_Message:dw 'Oops! Man died'
part_No:dw 0
ThanksMSG:dw 'Thanks for playing Hangman.'
line1: db " __    __      ___     .__   __.  _______     .___  ___.      ___      .__   __."
line2: db "|  |  |  |    /   \    |  \ |  | /  _____|    |   \/   |     /   \     |  \ |  |"
line3: db "|  |__|  |   /  ^  \   |   \|  ||  |  __      |  \  /  |    /  ^  \    |   \|  |"
line4: db "|   __   |  /  /_\  \  |  . `  ||  | |_ |     |  |\/|  |   /  /_\  \   |  . `  |"
line5: db "|  |  |  | /  _____  \ |  |\   ||  |__| |     |  |  |  |  /  _____  \  |  |\   |"
line6: db "|__|  |__|/__/     \__\|__| \__| \______|     |__|  |__| /__/     \__\ |__| \__|"