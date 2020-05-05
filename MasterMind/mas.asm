.model tiny
.stack 100h
.data

;ramka
komunikat_ramka1 db 'Master Mind Game                                   ','$'               
komunikat_ramka2 db 'by hAsh, 2002                               ','$'

licznik db 0
komunikat_zgadles db 'Gratulacje, zgadles!',10,13,'$'
komunikat_znak db 'Ciag ma zawierac 4 znaki z zakresu od a do g',10,13,'$'
zlapany db 4 dup(0),'$'
pobrany db 5 dup(0)
bufor db 5,0,4 dup('$')
seed db 1111b

.code

;PROCEDURY LOSUJ¥CE CI¥G

pobierz_sekunde:
mov al,0
out 70h,al
in al,71h
mov bl,al
and al,00001111b
shr bl,4
add al,bl
ret

losuj:
push ax
mov ax,seg seed
mov ds,ax
mov dx,offset seed
pop ax
mov bl,seed
add bl,al
rol bl,3
or bl,5
mov bh,al
rol al,5
xor bl,bh
shr bl,1
mov byte ptr seed,bl
mov al,bl
dec al
and al,00000111b
add al,61h
ret


lapciag:
mov ax, seg zlapany
mov ds,ax
mov si,offset zlapany
mov cx,4
petlas:
call pobierz_sekunde
call losuj
mov ds:[si],al
inc si
loop petlas
ret

;POBIERANIE CI¥GU OD U¯YTKOWNIKA:

pobieraj:
mov ax,seg pobrany
mov es,ax
mov di,offset pobrany
push ds
push dx
mov ax,seg bufor
mov ds,ax
mov dx,offset bufor
mov ah,0ah
int 21h
mov si,offset bufor+2
mov cx,4
rep movsb
mov al,'$'
mov es:[di],al
pop dx
pop ds
ret

;PROCEDURY WYPISUJ¥CE:	

;ramka pocz¹tkowa
odstep_ramki:
mov al,0bah
int 10h
mov cx,58
mov al,0ffh
l2:
int 10h
loop l2
mov al,0bah
int 10h
call wypisz_Enter
ret

buduj_ramke:
mov al,0c9h
mov ah,0eh
int 10h
mov cx,58
mov al,0cdh
mov ah,0eh
l1:
int 10h
loop l1
mov al,0bbh
int 10h
call wypisz_Enter
call odstep_ramki
mov al,0bah
int 10h
mov al,0ffh
mov cx,3
p3:
int 10h
loop p3
mov ax,seg komunikat_ramka1
mov ds,ax
mov dx,offset komunikat_ramka1
mov ah,9
int 21h
mov al,0ffh
mov ah,0eh
mov cx,4
p4:
int 10h
loop p4
mov al,0bah
int 10h
call wypisz_Enter
call odstep_ramki
mov al,0bah
int 10h
mov al,0ffh
mov cx,4
p5:
int 10h
loop p5
mov cx,3
p6:
int 10h
loop p6
mov ax,seg komunikat_ramka2
mov ds,ax
mov dx,offset komunikat_ramka2
mov ah,9
int 21h
mov al,0ffh
mov ah,0eh
mov cx,7
p7:
int 10h
loop p7
mov al,0bah
int 10h
call wypisz_Enter
call odstep_ramki
mov al,0c8h
mov ah,0eh
int 10h
mov cx,58
mov al,0cdh
mov ah,0eh
l8:
int 10h
loop l8
mov al,0bch
int 10h
call wypisz_Enter
ret

;zacznij kolejny wiersz
wypisz_Enter:
mov al,10
mov ah,0eh
int 10h
mov al,13
mov ah,0eh
int 10h
ret

;wyswietl separator
wypisz_linie:
push cx
mov cx,60
mov al,'_'
mov ah,0eh
linia:
int 10h
loop linia
pop cx
ret

;PROCEDURY SPRAWDZAJ¥CE POPRAWNOÆ WPROWADZONYCH DANYCH:

kontroluj_pobierane:
mov ax,seg pobrany
mov es,ax
mov di,offset pobrany
mov cx,4
pkontrola:
mov al,'a'
cmp es:[di],al
jl zly_znak
jg kontroluj2
dalej_kontrola:
inc di
loop pkontrola
ret


kontroluj2:
push ax
mov al,'h'
cmp es:[di],al
pop ax
jg zly_znak
jmp dalej_kontrola


zly_znak:
push ds
push dx
push ax
mov ax,seg komunikat_znak
mov ds,ax
mov dx,offset komunikat_znak
mov ah,9
int 21h
call wypisz_linie
pop ax
pop dx
pop ds
pop bx
jmp dalej_start

;PROCEDURY SPRAWDZAJ¥CE CZY CI¥G ZOSTA£ ODGADNIÊTY:

sprawdzaj:
xor bx,bx
mov ax,seg pobrany
mov es,ax
mov di,offset pobrany

mov ax,seg zlapany
mov ds,ax
mov si,offset zlapany

mov cx,4
petla1:
cmpsb
je trafione1
jne sprawdz2
sprawdzaj_dalej:
loop petla1
ret

sprawdz2:
push si
push di
push cx
cld
dec si
dec di
mov ax,offset zlapany
mov si,ax
mov cx,4
xor ax,ax
mov al,es:[di]
petla2:
cmp al,ds:[si]
je trafione2
inc si
loop petla2
jmp nie_traf

trafione1:
mov al,2
mov ah,0eh
int 10h
inc bx
mov ax,4
cmp bx,ax
je zgadles
jmp sprawdzaj_dalej

trafione2:
mov al,1
mov ah,0eh
int 10h
pop cx
pop di
pop si
jmp sprawdzaj_dalej

nie_traf:
mov al,'-'
mov ah,0eh
int 10h
pop cx
pop di
pop si
jmp sprawdzaj_dalej

zgadles:
mov ax,seg komunikat_zgadles
mov ds,ax
mov dx,offset komunikat_zgadles
call wypisz_Enter
mov ah,9
int 21h
jmp koniec_start


start:
call buduj_ramke
call lapciag

mov cx,7
pglowna:
push cx
call pobieraj
call wypisz_Enter
call kontroluj_pobierane
call wypisz_Enter
call sprawdzaj

call wypisz_Enter
call wypisz_linie
dalej_start:
call wypisz_Enter
pop cx
loop pglowna
koniec_start:
call wypisz_Enter
mov ax,seg zlapany
mov ds,ax
mov dx,offset zlapany
mov ah,9
int 21h
mov ah,0
int 16h
mov ah,4ch
int 21h
END start
