; he code published under Creative Commons (CC-BY-NC) license
; author: hasherezade (hasherezade.net)

; WARNING: this it a code I created for learning purpose in my teens. 
; It works, but is NOT a production-ready quality of code!
; May be suboptimal and have bugs!

; compile with tasm:
; tasm <name>.asm
; tlink <name>.obj

; works on: DoS, Windows <= XP

.model tiny
.stack 100h
.data
circle_bitmap db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,0,0,0,0,0,0,0
db 0,0,0,0,0,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,0,0,0,0,0
db 0,0,0,0,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,0,0,0,0
db 0,0,0,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,0,0,0
db 0,0,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,0,0
db 0,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,0
db 0,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,0
db 4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4
db 4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4
db 4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4
db 4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4
db 4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4
db 0,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,0
db 0,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,0
db 0,0,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,0,0
db 0,0,0,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,0,0,0
db 0,0,0,0,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,0,0,0,0
db 0,0,0,0,0,0,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0

cross_bitmap db 9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,9,9,0,0,0,0
db 0,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,9,9,9,9,0,0,0,0
db 0,0,9,0,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,0,9,9,9,0,0,0,0,0
db 0,0,0,0,0,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0,0,9,9,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,9,9,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,0,9,9,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,9,9,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,9,9,0,0,0,0,0,0,0,0,0,0,0,9,9,9,9,9,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0,0,0,0,0,0,0,0,9,9,9,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,0,0,0,0,0,9,9,9,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0,0,9,9,9,9,0,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,9,9,9,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,0,9,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,9,9,9,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,9,0,9,0,0,0,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,9,9,0,0,0,0,0,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,9,9,9,9,9,0,0,0,0,0,0,0,0,0,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,9,9,9,9,9,0,0,0,0,0,0,0,0,0,0,0,0,9,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,9,9,9,9,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,9,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,9,9,9,9,9,9,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,9,9,9,9,9,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0,0,0,0,0,0,0,0
db 0,0,9,0,0,0,9,9,0,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,9,0,0,0,0,0,0
db 0,9,9,9,9,9,9,9,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,0,0,0,0

mouse_flag db 0
cross_and_circle_flag db 0
field_flag db 0
fields db 10 dup(0)
lines db 9 dup(0)
fields_states dw 10 dup(0)
the_biggest_state db 0
machine db 0
where_to_put db 0 ; an empty field with the biggest state

circles_won_str db "Circles won!$"
crosses_won_str db "Crosses won!$"
draw_str db "Draw!$"

title_str db "Tic-Tac-Toe$"
signature_str db "[hasherezade, 2003]$"

choose1_str db "1 - human vs computer$"
choose2_str db "2 - human vs human$"
choose3_str db "3 - quit$"

.code

start:

assume ds:@data
mov ax,@data
mov ds,ax
mov ax,0a000h
mov es,ax

mov ax,0013h
int 10h
call paint_menu
cmp machine,0
je finish
call paint_field
call mousepointer
mov ax,0003h
int 10h
finish:
mov ah,4ch
int 21h

;si - sprite
;di - point of pasting
;bx - half of width
paint_sprite:
push ax
push ds
push es
push di
push si
mov ax,0a000h
mov es,ax
mov ax,@data
mov ds,ax
mov cx,23
paint_sprite_d1:
push cx
mov cx,bx
rep movsw
add di,320
sub di,bx
sub di,bx
pop cx
loop paint_sprite_d1
pop si
pop di
pop es
pop ds
pop ax
ret

paint_menu:
push ax
push bx
push dx
;set pointer
mov ah,2
mov dh,5
mov dl,13
mov bh,0
int 10h
mov dx,offset title_str
mov ah,9
int 21h
;set pointer
mov ah,2
mov dh,6
mov dl,10
mov bh,0
int 10h
mov dx,offset signature_str
mov ah,9
int 21h

;set pointer
mov ah,2
mov dh,9
mov dl,10
mov bh,0
int 10h
mov dx,offset choose1_str
mov ah,9
int 21h

;set pointer
mov ah,2
mov dh,10
mov dl,10
mov bh,0
int 10h
mov dx,offset choose2_str
mov ah,9
int 21h

;set pointer
mov ah,2
mov dh,11
mov dl,10
mov bh,0
int 10h
mov dx,offset choose3_str
mov ah,9
int 21h

check_mode_loop:
mov dl,0ffh
mov ah,6
int 21h

cmp al,'1'
je machine_true

cmp al,'2'
je machine_false

cmp al, '3'
je finish_menu

jmp check_mode_loop

machine_true:
mov byte ptr machine,1
jmp finish_menu

machine_false:
mov byte ptr machine,2

finish_menu:
call flush_screen

mov ah,2
mov dh,0
mov dl,0
mov bh,0
int 10h
pop dx
pop bx
pop ax
ret

flush_screen:
push dx
push cx
push bx
push ax
push ds
push es
push di
push si
mov ax,0a000h
mov es,ax
mov cx,32000
mov ax,0
rep stosw
pop si
pop di
pop es
pop ds
pop ax
pop bx
pop cx
pop dx
ret


;di - point of pasting
paint_into_field:
push dx
push cx
push bx
push ax
push ds
push es
push di
push si
mov bx,64
mov ax,0a000h
mov es,ax
mov ah,15
mov al,15
mov cx,40
paint_into_d1:
push cx
mov cx,bx
loop_paint_into_field:
cmp byte ptr es:[di],0
jne do_not_paint
mov byte ptr es:[di],al
do_not_paint:
inc di
loop loop_paint_into_field
add di,320
sub di,bx
pop cx
loop paint_into_d1
pop si
pop di
pop es
pop ds
pop ax
pop bx
pop cx
pop dx
ret

check_coordinates:
cmp cx,128
jnb check_next_x1
mov field_flag,1
mov cx,96
sub cx,bx
jmp check_y
check_next_x1:
cmp cx,192
jnb check_next_x2
mov field_flag,2
mov cx,160
sub cx,bx
jmp check_y
check_next_x2:
cmp cx,256
jnb check_y
mov field_flag,3
mov cx,224
sub cx,bx
check_y:
cmp dx,80
jnb check_next_y1
mov dx,60
sub dx,10
jmp check_if_finished
check_next_y1:
cmp dx,120
jnb check_next_y2
add field_flag,3
mov dx,100
sub dx,10
jmp check_if_finished
check_next_y2:
cmp dx,160
jnb check_if_finished
add field_flag,6
mov dx,140
sub dx,10
check_if_finished:
ret

;bx - pawn, circle(1) or cross(10)
fill_fields:
push si
push ax
push cx
mov ax,offset fields
xor cx,cx
mov cl,byte ptr field_flag
add ax,cx
mov si,ax
mov byte ptr ds:[si],bl
pop cx
pop ax
pop si
ret

calc_lines:
push si
push di
push cx
push bx
push ax
mov ax,offset lines
mov di,ax
mov ax,offset fields
mov si,ax
xor cx,cx
add cl,byte ptr ds:[si+1]
add cl,byte ptr ds:[si+2]
add cl,byte ptr ds:[si+3]
mov byte ptr ds:[di+1],cl
mov bx,1
call is_game_won
xor cx,cx
add cl,byte ptr ds:[si+4]
add cl,byte ptr ds:[si+5]
add cl,byte ptr ds:[si+6]
mov byte ptr ds:[di+2],cl
mov bx,2
call is_game_won
xor cx,cx
add cl,byte ptr ds:[si+7]
add cl,byte ptr ds:[si+8]
add cl,byte ptr ds:[si+9]
mov byte ptr ds:[di+3],cl
mov bx,3
call is_game_won
xor cx,cx
add cl,byte ptr ds:[si+1]
add cl,byte ptr ds:[si+4]
add cl,byte ptr ds:[si+7]
mov byte ptr ds:[di+4],cl
mov bx,4
call is_game_won
xor cx,cx
add cl,byte ptr ds:[si+2]
add cl,byte ptr ds:[si+5]
add cl,byte ptr ds:[si+8]
mov byte ptr ds:[di+5],cl
mov bx,5
call is_game_won
xor cx,cx
add cl,byte ptr ds:[si+3]
add cl,byte ptr ds:[si+6]
add cl,byte ptr ds:[si+9]
mov byte ptr ds:[di+6],cl
mov bx,6
call is_game_won
xor cx,cx
add cl,byte ptr ds:[si+1]
add cl,byte ptr ds:[si+5]
add cl,byte ptr ds:[si+9]
mov byte ptr ds:[di+7],cl
mov bx,7
call is_game_won
xor cx,cx
add cl,byte ptr ds:[si+3]
add cl,byte ptr ds:[si+5]
add cl,byte ptr ds:[si+7]
mov byte ptr ds:[di+8],cl
mov bx,8
call is_game_won
call calculate_lines
pop ax
pop bx
pop cx
pop di
pop si
ret


calculate_lines:
push si
push di
push cx
push bx
push ax
mov ax,offset lines
mov si,ax
mov cx,8
loop_calculate:
inc si
cmp byte ptr ds:[si],0
ja continue_calculation1
mov byte ptr ds:[si],1
jmp next
continue_calculation1:
cmp byte ptr ds:[si],1
ja continue_calculation2
mov byte ptr ds:[si],2
jmp next
continue_calculation2:
cmp byte ptr ds:[si],2
ja continue_calculation3
mov byte ptr ds:[si],20
jmp next
continue_calculation3:
cmp byte ptr ds:[si],10
jne continue_calculation4
mov byte ptr ds:[si],5
jmp next
continue_calculation4:
cmp byte ptr ds:[si],20
jne continue_calculation5
mov byte ptr ds:[si],100
jmp next
continue_calculation5:
mov byte ptr ds:[si],0
next:
loop loop_calculate
call calculate_the_state
pop ax
pop bx
pop cx
pop di
pop si
ret


is_game_won:
cmp cx,30
je crosses_winning
cmp cx,3
je circles_winning
ret
crosses_winning:
lea dx,crosses_won_str
mov ah,9
int 21h
call hilight_winner
mov ah,0
int 16h
mov ax,0003h
int 10h
mov ah,4ch
int 21h
ret
circles_winning:
lea dx,circles_won_str
mov ah,9
int 21h
call hilight_winner
mov ah,0
int 16h
mov ax,0003h
int 10h
mov ah,4ch
int 21h
ret

hilight_winner:
xor dx,dx
xor cx,cx
cmp bx,3
ja hilight_d1
mov cx,bx
hilight_p1:
add dx,40
loop hilight_p1
mov cx,64
call calculate_point
call paint_into_field
add di,64
call paint_into_field
add di,64
call paint_into_field
ret
hilight_d1:
cmp bx,6
ja hilight_d2
sub bx,3
mov cx,bx
xor bx,bx
hilight_p2:
add bx,64
loop hilight_p2
mov cx,bx
mov dx,40
call calculate_point
call paint_into_field
add dx,40
call calculate_point
call paint_into_field
add dx,40
call calculate_point
call paint_into_field
ret
hilight_d2:
cmp bx,7
ja hilight_d3
mov dx,40
mov cx,64
call calculate_point
call paint_into_field
add cx,64
add dx,40
call calculate_point
call paint_into_field
add cx,64
add dx,40
call calculate_point
call paint_into_field
ret
hilight_d3:
mov dx,40
mov cx,192
call calculate_point
call paint_into_field
sub cx,64
add dx,40
call calculate_point
call paint_into_field
sub cx,64
add dx,40
call calculate_point
call paint_into_field
ret

;calculates states of particular fields
calculate_the_state:
push si
push di
push dx
push cx
push bx
push ax
mov byte ptr where_to_put,0
mov byte ptr the_biggest_state,0
mov ax,offset fields_states
mov bx,offset lines
mov si,bx
mov di,ax
xor cx,cx
xor dx,dx
inc dx
add cl,byte ptr ds:[si+1]
add cl,byte ptr ds:[si+4]
add cl,byte ptr ds:[si+7]
mov byte ptr ds:[di+1],cl
call check_if_free
xor cx,cx
inc dx
add cl,byte ptr ds:[si+1]
add cl,byte ptr ds:[si+5]
mov byte ptr ds:[di+2],cl
call check_if_free
xor cx,cx
inc dx
add cl,byte ptr ds:[si+1]
add cl,byte ptr ds:[si+6]
add cl,byte ptr ds:[si+8]
mov byte ptr ds:[di+3],cl
call check_if_free
xor cx,cx
inc dx
add cl,byte ptr ds:[si+2]
add cl,byte ptr ds:[si+4]
mov byte ptr ds:[di+4],cl
call check_if_free
xor cx,cx
inc dx
add cl,byte ptr ds:[si+2]
add cl,byte ptr ds:[si+5]
add cl,byte ptr ds:[si+7]
add cl,byte ptr ds:[si+8]
mov byte ptr ds:[di+5],cl
call check_if_free
xor cx,cx
inc dx
add cl,byte ptr ds:[si+2]
add cl,byte ptr ds:[si+6]
mov byte ptr ds:[di+6],cl
call check_if_free
xor cx,cx
inc dx
add cl,byte ptr ds:[si+3]
add cl,byte ptr ds:[si+4]
add cl,byte ptr ds:[si+8]
mov byte ptr ds:[di+7],cl
call check_if_free
xor cx,cx
inc dx
add cl,byte ptr ds:[si+3]
add cl,byte ptr ds:[si+5]
mov byte ptr ds:[di+8],cl
call check_if_free
xor cx,cx
inc dx
add cl,byte ptr ds:[si+3]
add cl,byte ptr ds:[si+6]
add cl,byte ptr ds:[si+7]
mov byte ptr ds:[di+9],cl
call check_if_free
pop ax
pop bx
pop cx
pop dx
pop di
pop si
ret

check_if_free:
push si
push di
push ax
push cx
mov ax,offset fields
mov si,ax
add si,dx
mov ax,offset fields_states
mov di,ax
add di,dx
mov cl,byte ptr ds:[di]
cmp byte ptr ds:[si],0
jne booked
cmp byte ptr the_biggest_state,cl
ja booked
mov byte ptr the_biggest_state,cl
mov byte ptr where_to_put,dl
booked:
pop cx
pop ax
pop di
pop si
ret

set_pointer:
push ax
push bx
push dx
mov ah,2
mov dh,10
mov dl,20
mov bh,0
int 10h
pop dx
pop bx
pop ax
ret

is_board_filled:
push si
push ax
push cx
push bx
mov ax,offset fields
mov si,ax
xor bx,bx
mov cx,9
inc si
is_next_field_filled:
add bl,byte ptr ds:[si]
inc si
loop is_next_field_filled
cmp bl,45
jne not_filled
mov dx,offset draw_str
mov ah,9
int 21h
mov ah,0
int 16h
mov ax,0003h
int 10h
mov ah,4ch
int 21h
not_filled:
pop bx
pop cx
pop ax
pop si
ret

paint_circle:
mov bx,21
lea si,circle_bitmap
call check_coordinates
call calculate_point
call is_circle_free
call is_board_filled
ret

is_circle_free:
push di
push ax
mov ax,offset fields
mov di,ax
xor ax,ax
mov al,byte ptr field_flag
add di,ax
mov cl,byte ptr ds:[di]
pop ax
pop di
cmp cl,0
jne ignore
call paint_sprite
mov bx,1
call fill_fields
call calc_lines
cmp machine,1
jne ignore
call set_cross
ignore:
ret

set_cross:
push dx
push cx
push bx
push ax
call figureout_cross_coordinates
call paint_cross
pop ax
pop bx
pop cx
pop dx
ret

figureout_cross_coordinates:
cmp byte ptr where_to_put,6
jbe figureout_y_d1
mov dx,130
sub byte ptr where_to_put,6
call figureout_x_of_cross
ret
figureout_y_d1:
cmp byte ptr where_to_put,3
jbe figureout_y_d2
mov dx,90
sub byte ptr where_to_put,3
call figureout_x_of_cross
ret
figureout_y_d2:
mov dx,50
call figureout_x_of_cross
ret


figureout_x_of_cross:
cmp byte ptr where_to_put,3
jb figureout_x_d1
mov cx,203
ret
figureout_x_d1:
cmp byte ptr where_to_put,2
jb figureout_x_d2
mov cx,139
ret
figureout_x_d2:
mov cx,75
ret

paint_cross:
mov bx,21
lea si,cross_bitmap
call check_coordinates
call calculate_point
call is_cross_free
ret

is_cross_free:
push di
push ax
mov ax,offset fields
mov di,ax
xor ax,ax
mov al,byte ptr field_flag
add di,ax
mov cl,byte ptr ds:[di]
pop ax
pop di
cmp cl,0
jne ignore_cross
call paint_sprite
mov bx,10
call fill_fields
call calc_lines
ignore_cross:
ret

calculate_point:
push ax
push dx
mov ax,dx
sal ax,8
sal dx,6
add dx,ax
add dx,cx
mov di,dx
pop dx
pop ax
ret

row:
push cx
mov cx,64
call calculate_point
mov cx,193
loop_line1:
mov byte ptr es:[di],3
inc di
loop loop_line1
pop cx
ret

paint_horizontal:
push dx
push cx
mov dx,40
mov cx,4
loop_horizontal:
call row
add dx,40
loop loop_horizontal
pop cx
pop dx
ret

column:
push dx
mov dx,40
call calculate_point
mov cx,120
loop_line3:
mov byte ptr es:[di],3
add di,320
loop loop_line3
pop dx
ret

paint_vertical:
push dx
push cx
mov cx,4
mov ax,64
loop_vertical:
push cx
mov cx,ax
call column
pop cx
add ax,64
loop loop_vertical
pop cx
pop dx
ret

paint_field:
call paint_horizontal
call paint_vertical
ret

mousepointer:
mov ax,00h
int 33h
or ax,ax
jz finish_mouse
call cursor_in_the_field
mov ax,01h
int 33h
loop_mouse:
mov dl,0ffh
mov ah,6
int 21h
cmp al,'q'
je finish_mouse
mov ax,03h
int 33h
test bx,1
jz not_left
shr cx,1
cmp byte ptr mouse_flag,0
jne loop_mouse

cmp byte ptr cross_and_circle_flag,0
jne is_cross
call hide_mousepointer
call paint_circle
mov byte ptr cross_and_circle_flag,1
mov byte ptr mouse_flag,1
call show_mousepointer
jmp loop_mouse
is_cross:
cmp byte ptr cross_and_circle_flag,1
jne loop_mouse
call hide_mousepointer
cmp machine,2
jne dont_paint_cross
call paint_cross
jmp painting_cross_done
dont_paint_cross:
call paint_circle
painting_cross_done:
mov byte ptr cross_and_circle_flag,0
mov byte ptr mouse_flag,1
call show_mousepointer
jmp loop_mouse
not_left:
mov byte ptr mouse_flag,0
jmp loop_mouse
finish_mouse:
ret

cursor_in_the_field:
mov ax,08h
mov cx,41
mov dx,145
int 33h
mov ax,07h
mov cx,130
mov dx,494
int 33h
ret

hide_mousepointer:
push ax
mov ax,2
int 33h
pop ax
ret

show_mousepointer:
push ax
mov ax,1
int 33h
pop ax
ret

END start

