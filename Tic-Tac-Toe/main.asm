; the code published under Creative Commons (CC-BY-NC) license
; author: hasherezade (hshrzd.wordpress.com)
; contact: hasherezade@op.pl

; compile with tasm:
; tasm <name>.asm
; tlink <name>.obj

; works on: DoS, Windows <= XP

.model tiny
.stack 100h
.data
kolko db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0
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
db 0,0,0,0,0,0,4,4, 4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0

krzyzyk db 9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,9,9,0,0,0,0
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
db 0,0,0,0,0,9,9,9, 9,9,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,0,0,0,0,0,0,0,0
db 0,0,9,0,0,0,9,9,0,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,9,0,0,0,0,0,0
db 0,9,9,9,9,9,9,9,9,9,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,0,0,0,0

mycha_flag db 0
kik_flag db 0
pole_flag db 0
pola db 10 dup(0)
linie db 9 dup(0)
stan_pola dw 10 dup(0)
najwiekszy_stan db 0
maszyna db 0
gdzie_postawic db 0 ;puste pole z największym stanem

wygkol db "Circles won!$"
wygkrzyz db "Crosses won!$"
remis db "Draw!$"

tytul db "Tic-Tac-Toe$"
podpis db "[hasherezade, 2003]$"

wybierz1 db "1 - human vs computer$"
wybierz2 db "2 - human vs human$"
wybierz3 db "3 - quit$"

.code

start:

assume ds:@data
mov ax,@data
mov ds,ax
mov ax,0a000h
mov es,ax

mov ax,0013h
int 10h
call rysuj_menu
cmp maszyna,0
je koniec
call rysuj_pole
call myszka
mov ax,0003h
int 10h
koniec:
mov ah,4ch
int 21h

;si - sprajt
;di -miejsce wklejenia
;bx -połowa szerokości
rysuj_sprajt:
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
rysuj_sprajt_d1:
push cx
mov cx,bx
rep movsw
add di,320
sub di,bx
sub di,bx
pop cx
loop rysuj_sprajt_d1
pop si
pop di
pop es
pop ds
pop ax
ret

rysuj_menu:
push ax
push bx
push dx
;ustawiam wskaznik
mov ah,2
mov dh,5
mov dl,13
mov bh,0
int 10h
mov dx,offset tytul
mov ah,9
int 21h
;ustawiam wskaznik
mov ah,2
mov dh,6
mov dl,10
mov bh,0
int 10h
mov dx,offset podpis
mov ah,9
int 21h

;ustawiam wskaznik
mov ah,2
mov dh,9
mov dl,10
mov bh,0
int 10h
mov dx,offset wybierz1
mov ah,9
int 21h

;ustawiam wskaznik
mov ah,2
mov dh,10
mov dl,10
mov bh,0
int 10h
mov dx,offset wybierz2
mov ah,9
int 21h

;ustawiam wskaznik
mov ah,2
mov dh,11
mov dl,10
mov bh,0
int 10h
mov dx,offset wybierz3
mov ah,9
int 21h

entliczek:
mov dl,0ffh
mov ah,6
int 21h

cmp al,'1'
je maszyna_tak

cmp al,'2'
je maszyna_nie

cmp al, '3'
je koncz_menu

jmp entliczek

maszyna_tak:
mov byte ptr maszyna,1
jmp koncz_menu

maszyna_nie:
mov byte ptr maszyna,2

koncz_menu:
call zamaluj_ekran

mov ah,2
mov dh,0
mov dl,0
mov bh,0
int 10h
pop dx
pop bx
pop ax
ret

zamaluj_ekran:
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


;di -miejsce wklejenia
zamaluj_pole:
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
zamaluj_d1:
push cx
mov cx,bx
petla_zamaluj_pole:
cmp byte ptr es:[di],0
jne nie_maluj
mov byte ptr es:[di],al
nie_maluj:
inc di
loop petla_zamaluj_pole
add di,320
sub di,bx
pop cx
loop zamaluj_d1
pop si
pop di
pop es
pop ds
pop ax
pop bx
pop cx
pop dx
ret

sprawdzaj_wspolrzedne:
cmp cx,128
jnb sprawdzaj_x_dalej1
mov pole_flag,1
mov cx,96
sub cx,bx
jmp sprawdzaj_y
sprawdzaj_x_dalej1:
cmp cx,192
jnb sprawdzaj_x_dalej2
mov pole_flag,2
mov cx,160
sub cx,bx
jmp sprawdzaj_y
sprawdzaj_x_dalej2:
cmp cx,256
jnb sprawdzaj_y
mov pole_flag,3
mov cx,224
sub cx,bx
sprawdzaj_y:
cmp dx,80
jnb sprawdzaj_y_dalej1
mov dx,60
sub dx,10
jmp sprawdzaj_koniec
sprawdzaj_y_dalej1:
cmp dx,120
jnb sprawdzaj_y_dalej2
add pole_flag,3
mov dx,100
sub dx,10
jmp sprawdzaj_koniec
sprawdzaj_y_dalej2:
cmp dx,160
jnb sprawdzaj_koniec
add pole_flag,6
mov dx,140
sub dx,10
sprawdzaj_koniec:
ret



;bx - znak, kółko(1) lub krzyżyk(10)
wypelnij_pole:
push si
push ax
push cx
mov ax,offset pola
xor cx,cx
mov cl,byte ptr pole_flag
add ax,cx
mov si,ax
mov byte ptr ds:[si],bl
pop cx
pop ax
pop si
ret

oblicz_linie:
push si
push di
push cx
push bx
push ax
mov ax,offset linie
mov di,ax
mov ax,offset pola
mov si,ax
xor cx,cx
add cl,byte ptr ds:[si+1]
add cl,byte ptr ds:[si+2]
add cl,byte ptr ds:[si+3]
mov byte ptr ds:[di+1],cl
mov bx,1
call czy_wygrano
xor cx,cx
add cl,byte ptr ds:[si+4]
add cl,byte ptr ds:[si+5]
add cl,byte ptr ds:[si+6]
mov byte ptr ds:[di+2],cl
mov bx,2
call czy_wygrano
xor cx,cx
add cl,byte ptr ds:[si+7]
add cl,byte ptr ds:[si+8]
add cl,byte ptr ds:[si+9]
mov byte ptr ds:[di+3],cl
mov bx,3
call czy_wygrano
xor cx,cx
add cl,byte ptr ds:[si+1]
add cl,byte ptr ds:[si+4]
add cl,byte ptr ds:[si+7]
mov byte ptr ds:[di+4],cl
mov bx,4
call czy_wygrano
xor cx,cx
add cl,byte ptr ds:[si+2]
add cl,byte ptr ds:[si+5]
add cl,byte ptr ds:[si+8]
mov byte ptr ds:[di+5],cl
mov bx,5
call czy_wygrano
xor cx,cx
add cl,byte ptr ds:[si+3]
add cl,byte ptr ds:[si+6]
add cl,byte ptr ds:[si+9]
mov byte ptr ds:[di+6],cl
mov bx,6
call czy_wygrano
xor cx,cx
add cl,byte ptr ds:[si+1]
add cl,byte ptr ds:[si+5]
add cl,byte ptr ds:[si+9]
mov byte ptr ds:[di+7],cl
mov bx,7
call czy_wygrano
xor cx,cx
add cl,byte ptr ds:[si+3]
add cl,byte ptr ds:[si+5]
add cl,byte ptr ds:[si+7]
mov byte ptr ds:[di+8],cl
mov bx,8
call czy_wygrano
call przelicz_linie
pop ax
pop bx
pop cx
pop di
pop si
ret


przelicz_linie:
push si
push di
push cx
push bx
push ax
mov ax,offset linie
mov si,ax
mov cx,8
petla_przelicz:
inc si
cmp byte ptr ds:[si],0
ja przeliczaj_dalej1
mov byte ptr ds:[si],1
jmp next
przeliczaj_dalej1:
cmp byte ptr ds:[si],1
ja przeliczaj_dalej2
mov byte ptr ds:[si],2
jmp next
przeliczaj_dalej2:
cmp byte ptr ds:[si],2
ja przeliczaj_dalej3
mov byte ptr ds:[si],20
jmp next
przeliczaj_dalej3:
cmp byte ptr ds:[si],10
jne przeliczaj_dalej4
mov byte ptr ds:[si],5
jmp next
przeliczaj_dalej4:
cmp byte ptr ds:[si],20
jne przeliczaj_dalej5
mov byte ptr ds:[si],100
jmp next
przeliczaj_dalej5:
mov byte ptr ds:[si],0
next:
loop petla_przelicz
call oblicz_stan
pop ax
pop bx
pop cx
pop di
pop si
ret


czy_wygrano:
cmp cx,30
je wygrana_krzyzykow
cmp cx,3
je wygrana_kolek
ret
wygrana_krzyzykow:
lea dx,wygkrzyz
mov ah,9
int 21h
call podswietl_wygrane
mov ah,0
int 16h
mov ax,0003h
int 10h
mov ah,4ch
int 21h
ret
wygrana_kolek:
lea dx,wygkol
mov ah,9
int 21h
call podswietl_wygrane
mov ah,0
int 16h
mov ax,0003h
int 10h
mov ah,4ch
int 21h
ret

podswietl_wygrane:
xor dx,dx
xor cx,cx
cmp bx,3
ja podswietl_d1
mov cx,bx
podswietl_p1:
add dx,40
loop podswietl_p1
mov cx,64
call wylicz_punkt
call zamaluj_pole
add di,64
call zamaluj_pole
add di,64
call zamaluj_pole
ret
podswietl_d1:
cmp bx,6
ja podswietl_d2
sub bx,3
mov cx,bx
xor bx,bx
podswietl_p2:
add bx,64
loop podswietl_p2
mov cx,bx
mov dx,40
call wylicz_punkt
call zamaluj_pole
add dx,40
call wylicz_punkt
call zamaluj_pole
add dx,40
call wylicz_punkt
call zamaluj_pole
ret
podswietl_d2:
cmp bx,7
ja podswietl_d3
mov dx,40
mov cx,64
call wylicz_punkt
call zamaluj_pole
add cx,64
add dx,40
call wylicz_punkt
call zamaluj_pole
add cx,64
add dx,40
call wylicz_punkt
call zamaluj_pole
ret
podswietl_d3:
mov dx,40
mov cx,192
call wylicz_punkt
call zamaluj_pole
sub cx,64
add dx,40
call wylicz_punkt
call zamaluj_pole
sub cx,64
add dx,40
call wylicz_punkt
call zamaluj_pole
ret

;oblicza stan poszczególnych pól
oblicz_stan:
push si
push di
push dx
push cx
push bx
push ax
mov byte ptr gdzie_postawic,0
mov byte ptr najwiekszy_stan,0
mov ax,offset stan_pola
mov bx,offset linie
mov si,bx
mov di,ax
xor cx,cx
xor dx,dx
inc dx
add cl,byte ptr ds:[si+1]
add cl,byte ptr ds:[si+4]
add cl,byte ptr ds:[si+7]
mov byte ptr ds:[di+1],cl
call sprawdz_czy_wolne
xor cx,cx
inc dx
add cl,byte ptr ds:[si+1]
add cl,byte ptr ds:[si+5]
mov byte ptr ds:[di+2],cl
call sprawdz_czy_wolne
xor cx,cx
inc dx
add cl,byte ptr ds:[si+1]
add cl,byte ptr ds:[si+6]
add cl,byte ptr ds:[si+8]
mov byte ptr ds:[di+3],cl
call sprawdz_czy_wolne
xor cx,cx
inc dx
add cl,byte ptr ds:[si+2]
add cl,byte ptr ds:[si+4]
mov byte ptr ds:[di+4],cl
call sprawdz_czy_wolne
xor cx,cx
inc dx
add cl,byte ptr ds:[si+2]
add cl,byte ptr ds:[si+5]
add cl,byte ptr ds:[si+7]
add cl,byte ptr ds:[si+8]
mov byte ptr ds:[di+5],cl
call sprawdz_czy_wolne
xor cx,cx
inc dx
add cl,byte ptr ds:[si+2]
add cl,byte ptr ds:[si+6]
mov byte ptr ds:[di+6],cl
call sprawdz_czy_wolne
xor cx,cx
inc dx
add cl,byte ptr ds:[si+3]
add cl,byte ptr ds:[si+4]
add cl,byte ptr ds:[si+8]
mov byte ptr ds:[di+7],cl
call sprawdz_czy_wolne
xor cx,cx
inc dx
add cl,byte ptr ds:[si+3]
add cl,byte ptr ds:[si+5]
mov byte ptr ds:[di+8],cl
call sprawdz_czy_wolne
xor cx,cx
inc dx
add cl,byte ptr ds:[si+3]
add cl,byte ptr ds:[si+6]
add cl,byte ptr ds:[si+7]
mov byte ptr ds:[di+9],cl
call sprawdz_czy_wolne
pop ax
pop bx
pop cx
pop dx
pop di
pop si
ret

sprawdz_czy_wolne:
push si
push di
push ax
push cx
mov ax,offset pola
mov si,ax
add si,dx
mov ax,offset stan_pola
mov di,ax
add di,dx
mov cl,byte ptr ds:[di]
cmp byte ptr ds:[si],0
jne zajete
cmp byte ptr najwiekszy_stan,cl
ja zajete
mov byte ptr najwiekszy_stan,cl
mov byte ptr gdzie_postawic,dl
zajete:
pop cx
pop ax
pop di
pop si
ret

ustaw_wskaznik:
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

czy_zapelniono_plansze:
push si
push ax
push cx
push bx
mov ax,offset pola
mov si,ax
xor bx,bx
mov cx,9
inc si
czy_zapelniono_p1:
add bl,byte ptr ds:[si]
inc si
loop czy_zapelniono_p1
cmp bl,45
jne nie_zapelniono
mov dx,offset remis
mov ah,9
int 21h
mov ah,0
int 16h
mov ax,0003h
int 10h
mov ah,4ch
int 21h
nie_zapelniono:
pop bx
pop cx
pop ax
pop si
ret

rysuj_kolko:
mov bx,21
lea si,kolko
call sprawdzaj_wspolrzedne
call wylicz_punkt
call czy_wolne_kolko
call czy_zapelniono_plansze
ret

czy_wolne_kolko:
push di
push ax
mov ax,offset pola
mov di,ax
xor ax,ax
mov al,byte ptr pole_flag
add di,ax
mov cl,byte ptr ds:[di]
pop ax
pop di
cmp cl,0
jne ignor
call rysuj_sprajt
mov bx,1
call wypelnij_pole
call oblicz_linie
cmp maszyna,1
jne ignor
call stawiaj_krzyzyk
ignor:
ret

stawiaj_krzyzyk:
push dx
push cx
push bx
push ax
call ustal_wspolrzedne_krzyzyka
call rysuj_krzyzyk
pop ax
pop bx
pop cx
pop dx
ret

ustal_wspolrzedne_krzyzyka:
cmp byte ptr gdzie_postawic,6
jbe ustal_y_d1
mov dx,130
sub byte ptr gdzie_postawic,6
call ustal_x_krzyzyka
ret
ustal_y_d1:
cmp byte ptr gdzie_postawic,3
jbe ustal_y_d2
mov dx,90
sub byte ptr gdzie_postawic,3
call ustal_x_krzyzyka
ret
ustal_y_d2:
mov dx,50
call ustal_x_krzyzyka
ret



ustal_x_krzyzyka:
cmp byte ptr gdzie_postawic,3
jb ustal_x_d1
mov cx,203
ret
ustal_x_d1:
cmp byte ptr gdzie_postawic,2
jb ustal_x_d2
mov cx,139
ret
ustal_x_d2:
mov cx,75
ret

rysuj_krzyzyk:
mov bx,21
lea si,krzyzyk
call sprawdzaj_wspolrzedne
call wylicz_punkt
call czy_wolny_krzyzyk
ret

czy_wolny_krzyzyk:
push di
push ax
mov ax,offset pola
mov di,ax
xor ax,ax
mov al,byte ptr pole_flag
add di,ax
mov cl,byte ptr ds:[di]
pop ax
pop di
cmp cl,0
jne ignork
call rysuj_sprajt
mov bx,10
call wypelnij_pole
call oblicz_linie
ignork:
ret

wylicz_punkt:
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

pozioma:
push cx
mov cx,64
call wylicz_punkt
mov cx,193
petla_linia1:
mov byte ptr es:[di],3
inc di
loop petla_linia1
pop cx
ret

rysuj_poziome:
push dx
push cx
mov dx,40
mov cx,4
petla_poziome:
call pozioma
add dx,40
loop petla_poziome
pop cx
pop dx
ret

pionowa:
push dx
mov dx,40
call wylicz_punkt
mov cx,120
petla_linia3:
mov byte ptr es:[di],3
add di,320
loop petla_linia3
pop dx
ret

rysuj_pionowe:
push dx
push cx
mov cx,4
mov ax,64
petla_pionowe:
push cx
mov cx,ax
call pionowa
pop cx
add ax,64
loop petla_pionowe
pop cx
pop dx
ret

rysuj_pole:
call rysuj_poziome
call rysuj_pionowe
ret

myszka:
mov ax,00h
int 33h
or ax,ax
jz koniec_mycha
call kursor_w_polu
mov ax,01h
int 33h
petla_mycha:
mov dl,0ffh
mov ah,6
int 21h
cmp al,'q'
je koniec_mycha
mov ax,03h
int 33h
test bx,1
jz nie_lewy
shr cx,1
cmp byte ptr mycha_flag,0
jne petla_mycha

cmp byte ptr kik_flag,0
jne czy_krzyzyk
call chowaj_mysz
call rysuj_kolko
mov byte ptr kik_flag,1
mov byte ptr mycha_flag,1
call pokaz_mysz
jmp petla_mycha
czy_krzyzyk:
cmp byte ptr kik_flag,1
jne petla_mycha
call chowaj_mysz
cmp maszyna,2
jne nie_rysuj_krzyzyka
call rysuj_krzyzyk
jmp narysowalem_krzyzyk
nie_rysuj_krzyzyka:
call rysuj_kolko
narysowalem_krzyzyk:
mov byte ptr kik_flag,0
mov byte ptr mycha_flag,1
call pokaz_mysz
jmp petla_mycha
nie_lewy:
mov byte ptr mycha_flag,0
jmp petla_mycha
koniec_mycha:
ret

kursor_w_polu:
mov ax,08h
mov cx,41
mov dx,145
int 33h
mov ax,07h
mov cx,130
mov dx,494
int 33h
ret

chowaj_mysz:
push ax
mov ax,2
int 33h
pop ax
ret

pokaz_mysz:
push ax
mov ax,1
int 33h
pop ax
ret

END start

