; the code published under Creative Commons (CC-BY-NC) license
; author: hasherezade (hshrzd.wordpress.com)
; contact: hasherezade@op.pl
; compile with tasm

.model tiny
.stack 100h
.data

main db '            ###',13,10,'          ##  ##',13,10,'         ##    ##',13,10,'        ##      #           #####         ###',13,10,'       ##########   #####  ##    #         #    ###',13,10,'       ##       #  ##      #               #     #',13,10,'       ##       #  ###     #       00000   #     #    0      0    0000',13,10,'       ##       #     ##   ##      0    0  #     #    0      0    0  00',13,10,'      ##        #      ##   ###### 00000  ###    #    00000  0   000000 ',13,10,'      ##            #   #          0  00        ###   0   0  0    0',13,10,'     ##             #####          0   00             00000  000  000000','$'
main1 db '100% asm ASCII painter$'
main2 db 'by: hasherezade, 2004$'


main3 db '[PRESS SPACE]$'

napis db "ASCrIIble$"
menu db 'Wyjscie | Otworz | zapiSz | Czysc | wYtnij | coFnij | Zamien | Pedzel$'
menu1 db ' | Tlo $'
pendzel db '*'
tlo db ' '
zapisztx db 'ZAPISZ$'
otworztx db 'OTWORZ$'
zmientx db 'ZMIEN$'
zamien_natx db 'ZAMIEN$'
uwagatx db 'UWAGA!$'
wytnijtxt db 'WYTNIJ$'
wcisniety db 0
opcje_flag db 0
mycha_flag db 0
podaj_nazwe db 'podaj nazwe pliku .txt:$'
nie_ma_pliku db 'Plik o podanej nazwie nie istnieje!$'
nie_ma_pliku2 db 'Wprowadzic nazwe ponownie?$'
plik_istnieje db 'Plik o podanej nazwie juz istnieje!$'
plik_istnieje2 db 'Czy chcesz nadpisac?$'
nie_podano db 'Nie podales nazwy pliku!$'
nie_zapisano db 'Nie zapisano pliku!$'
nie_zapisano2 db 'Sprawdz przyczyne i sprobuj ponownie!$'
tylko_odczyt db 'Zapis do tego pliku jest niemozliwy:$'
tylko_odczyt2 db 'plik tylko do odczytu!$'
zmien_pendzel db 'wpisz nowa wartosc pendzla:$'
zmien_tlo db 'wpisz nowa wartosc tla:$'
zamien_na db 'Zamien znak na znak:$'
znaleziono1 db 'podglad zawiera$'
znaleziono2 db 'plik$'
nie_znaleziono1 db 'W folderze nie ma plikow .txt!$'
wyt_opcje1 db 'wybierz opcje:$'
wyt_opcje2 db '[ ]przezroczyste tlo$'
wyt_opcje3 db '[ ]kopiuj$'
wyt_opcje4 db '[ ]odbicie lustrzane$'
wyt_opcje5 db '[ ]kasuj zaznaczone$'
pwyt_x dw 0
pwyt_x2 dw 0
pwyt_y dw 0
pwyt_y2 dw 0
button_tak db '[TAK]$'
button_nie db '[NIE]$'
button_enter db '[ENTER]$'
handle dw ?
znak db ?
plik db 20 dup(0)
stop_wysw_znal db 0

myData db 43 dup(0)
znajdz db '????????.txt',0
nazwa db 8 dup(' '),'$'
ile_znaleziono dw 0
ile_wyswietlono dw 0
reverse dw 0

.code
assume DS:@data

kopiuj_do_bufora:
push ax
push cx
push ds
push si
push es
push di
mov ax,09000h
mov es,ax
mov di,320
mov ax,0b800h
mov ds,ax
mov si,320
mov cx,2000
rep movsw
pop di
pop es
pop si
pop ds
pop cx
pop ax
ret

rysuj_ramke:
push ax
push cx
push dx
push es
push di
mov cx,20
mov dx,5
call wylicz_punkt
mov ax,0b800h
mov es,ax
mov ah,00010111b
mov al,' '
mov cx,10
rysuj_petla:
push cx
mov cx,40
rep stosw 
add di,160
sub di,80
pop cx
loop rysuj_petla
pop di
pop es
pop dx
pop cx
pop ax
ret

rysuj_ramke_wytnij:
push ax
push cx
push dx
push es
push di
mov cx,22
mov dx,5
call wylicz_punkt
mov ax,0b800h
mov es,ax
mov ah,00010111b
mov al,' '
mov cx,12
rysuj_petla_wyt:
push cx
mov cx,36
rep stosw 
add di,160
sub di,72
pop cx
loop rysuj_petla_wyt
pop di
pop es
pop dx
pop cx
pop ax
ret

ramka_wytnij_opcje:
push cx
push dx
lea si,wytnijtxt
call naglowek
mov cx,30
mov dx,8
call wylicz_punkt
lea si,wyt_opcje1
call wczytuj_napis
mov cx,30
mov dx,10
call wylicz_punkt
lea si,wyt_opcje2
call wczytuj_napis
mov cx,30
mov dx,11
call wylicz_punkt
lea si,wyt_opcje3
call wczytuj_napis
mov cx,30
mov dx,12
call wylicz_punkt
lea si,wyt_opcje4
call wczytuj_napis
mov cx,30
mov dx,13
call wylicz_punkt
lea si,wyt_opcje5
call wczytuj_napis
mov cx,37
mov dx,15
call rysuj_przycisk_enter
pop dx
pop cx
ret

czy_opcja_kasuj:
push ax
push di
mov ax,di
mov cx,31
mov dx,13
call wylicz_punkt
cmp ax,di
jne nie_opcja_kasuj
cmp byte ptr es:[di],'*'
je zgas_inne_opcje
jmp zapal_inne_opcje
nie_opcja_kasuj:
pop di
pop ax
ret


zgas_inne_opcje:
push di
push ax
push bx
push cx
push dx
mov cx,30
mov dx,10
call wylicz_punkt
inc di
mov bl,00011000b
mov cx,21
call tlo_pod_linia
inc di
mov byte ptr es:[di],' '
mov cx,30
mov dx,11
call wylicz_punkt
inc di
mov cx,10
call tlo_pod_linia
inc di
mov byte ptr es:[di],' '
mov cx,30
mov dx,12
call wylicz_punkt
inc di
mov cx,21
call tlo_pod_linia
inc di
mov byte ptr es:[di],' '
pop dx
pop cx
pop bx
pop ax
pop di
jmp nie_opcja_kasuj

zapal_inne_opcje:
push di
push ax
push bx
push cx
push dx
mov cx,30
mov dx,10
call wylicz_punkt
inc di
mov bl,00010111b
mov cx,21
call tlo_pod_linia
mov cx,30
mov dx,11
call wylicz_punkt
inc di
mov cx,10
call tlo_pod_linia
mov cx,30
mov dx,12
call wylicz_punkt
inc di
mov cx,21
call tlo_pod_linia
pop dx
pop cx
pop bx
pop ax
pop di
jmp nie_opcja_kasuj

kontrola_mychy_opcjewyt:
push cx
push dx
push di
push es
push ds
mov ax,0003h
int 33h
test bx,1
jz nielewy_kontrola_mychy_opcjewyt
cmp byte ptr mycha_flag,0
jne koniec_kontrola_mychy_opcjewyt
shr cx,3
shr dx,3
call wylicz_punkt
cmp byte ptr es:[di-2],'[' 
jne koniec_kontrola_mychy_opcjewyt
cmp byte ptr es:[di+2],']' 
jne koniec_kontrola_mychy_opcjewyt
cmp byte ptr es:[di-1],00010111b
jne koniec_kontrola_mychy_opcjewyt
cmp byte ptr es:[di],'*'
je checked
call ukryj_mysz
mov byte ptr es:[di],'*'
mov byte ptr mycha_flag,1
jmp koniec_kontrola_mychy_opcjewyt
checked:
call ukryj_mysz
mov byte ptr es:[di],' '
mov byte ptr mycha_flag,1
jmp koniec_kontrola_mychy_opcjewyt
nielewy_kontrola_mychy_opcjewyt:
mov byte ptr mycha_flag,0
koniec_kontrola_mychy_opcjewyt:
call czy_opcja_kasuj
call pokaz_mysz
pop ds
pop es
pop di
pop dx
pop cx
ret

ustaw_opcje:
push dx
push cx
mov cx,31
mov dx,10
call wylicz_punkt
cmp byte ptr es:[di],'*'
jne dalej_sprawdzaj_opcje1
or byte ptr opcje_flag,1
dalej_sprawdzaj_opcje1:
inc dx
call wylicz_punkt
cmp byte ptr es:[di],'*'
jne dalej_sprawdzaj_opcje2
or byte ptr opcje_flag,2
dalej_sprawdzaj_opcje2:
inc dx
call wylicz_punkt
cmp byte ptr es:[di],'*'
jne dalej_sprawdzaj_opcje3
or byte ptr opcje_flag,4
dalej_sprawdzaj_opcje3:
inc dx
call wylicz_punkt
cmp byte ptr es:[di],'*'
jne koniec_ustaw_opcje
or byte ptr opcje_flag,8
koniec_ustaw_opcje:
pop cx
pop dx
ret

zaznacz_opcje:
push ax
petla_zaznacz_opcje:
call kontrola_mychy_opcjewyt
mov ah,6
mov dl,0ffh
int 21h
cmp al,13
jne petla_zaznacz_opcje
call ustaw_opcje
pop ax
ret


rysuj_ramke_oz:
push ax
push cx
push dx
push es
push di
mov cx,19
mov dx,5
call wylicz_punkt
mov ax,0b800h
mov es,ax
mov ah,00010111b
mov al,' '
mov cx,17
rysuj_petla_oz:
push cx
mov cx,43
rep stosw 
add di,160
sub di,86
pop cx
loop rysuj_petla_oz
call rysuj_pole_na_pliki
pop di
pop es
pop dx
pop cx
pop ax
ret

zacznij_szukac_plikow:
push ax
push dx
push ds
mov ax,seg myData
mov ds,ax
lea dx,myData
mov ah,1ah
int 21h
mov ax,seg znajdz
mov ds,ax
lea dx,znajdz
mov ah,4eh
int 21h
pop ds
pop dx
pop ax
ret

czysc_nazwe:
push ax
push cx
push di
push es
mov ax,seg nazwa
mov es,ax
mov di,offset nazwa
mov al,' '
mov ah,' '
mov cx,4
rep stosw
pop es
pop di
pop cx
pop ax
ret

kopiuj_znaleziony:
push ax
push cx
push ds
push si
push es
push di
mov ax,seg myData
mov ds,ax
lea si,myData+30
mov ax,seg nazwa
mov es,ax
mov di,offset nazwa
cld
mov cx,8
petla_znalezione:
cmp byte ptr ds:[si],'.'
je koniec_znalezione
movsb
loop petla_znalezione
koniec_znalezione:
pop di
pop es
pop si
pop ds
pop cx
pop ax
ret

petla1_rysuj_pole:
inc di
inc di
mov byte ptr es:[di],0c4h
loop petla1_rysuj_pole
ret

srodek_rysuj_pole:
mov cx,25
inc dx
call wylicz_punkt
mov byte ptr es:[di],0b3h
add cx,15
call wylicz_punkt
mov byte ptr es:[di],0b3h
add cx,16
call wylicz_punkt
inc di
mov byte ptr es:[di],01110000b
ret

rysuj_pole_na_pliki:
push ax
push cx
push dx
push es
push di
mov ax,0b800h
mov es,ax
mov cx,25
mov dx,9
call wylicz_punkt
mov byte ptr es:[di],0dah
mov cx,15
call petla1_rysuj_pole
mov byte ptr es:[di],0c2h
mov cx,15
call petla1_rysuj_pole
inc di
inc di
mov byte ptr es:[di],0bfh
call srodek_rysuj_pole
dec di
mov byte ptr es:[di],18h
mov cx,5
petla2_rysuj_pole:
push cx
call srodek_rysuj_pole
pop cx
loop petla2_rysuj_pole
call srodek_rysuj_pole
dec di
mov byte ptr es:[di],19h
mov cx,25
mov dx,17
call wylicz_punkt
mov byte ptr es:[di],0c0h
mov cx,15
call petla1_rysuj_pole
mov byte ptr es:[di],0c1h
mov cx,15
call petla1_rysuj_pole
inc di
inc di
mov byte ptr es:[di],0d9h
pop di
pop es
pop dx
pop cx
pop ax
ret

wpisuj_do_bufora_znaleziony:
push si
push cx
lea si,nazwa
mov cx,8
rep movsb
pop cx
pop si
ret

buforuj_znalezione:
push es
push di
push cx
push ax
mov cl,2
mov word ptr ile_znaleziono,0
mov ax,09000h
mov es,ax
mov di,4002
call zacznij_szukac_plikow
jc koniec_buforuj_znalezione
call czysc_nazwe
call kopiuj_znaleziony
call wpisuj_do_bufora_znaleziony
add word ptr ile_znaleziono,1
mov cx,699
buforuj_kolejne:
mov ah,4fh
int 21h
jc koniec_buforuj_znalezione
call czysc_nazwe
call kopiuj_znaleziony
call wpisuj_do_bufora_znaleziony
add word ptr ile_znaleziono,1
loop buforuj_kolejne
koniec_buforuj_znalezione:
call czysc_nazwe
call wpisuj_do_bufora_znaleziony
pop ax
pop cx
pop di
pop es
ret

znaleziony_z_bufora_do_nazwa:
push ds
push es
push di
push ax
push cx
mov ax,09000h
mov ds,ax
mov ax,seg nazwa
mov es,ax
lea di,nazwa
mov cx,8
rep movsb
pop cx
pop ax
pop di
pop es
pop ds
ret


sprawdz_czy_nazwa:
cmp byte ptr nazwa,' '
jne koniec_sprawdz_czy_nazwa
mov byte ptr stop_wysw_znal,1
koniec_sprawdz_czy_nazwa:
ret

pisz_kolumne_plikow:
push ax
push bx
push cx
mov bx,cx
mov cx,7
petla_wyswietlaj_kol:
cmp byte ptr stop_wysw_znal,1
je koniec_pisz_kolumne_plikow
call czysc_nazwe
call znaleziony_z_bufora_do_nazwa
push si
lea si, nazwa
call sprawdz_czy_nazwa
call wczytuj_napis
pop si
push cx
mov cx,bx
inc dx
call wylicz_punkt
pop cx
loop petla_wyswietlaj_kol
koniec_pisz_kolumne_plikow:
pop cx
pop bx
pop ax
ret


int_to_str:
push ax
push bx
push di
mov bl,10
petla_itos:
dec di
dec di
div bl
add ah,30h
mov byte ptr es:[di],ah
xor ah,ah
cmp al,0
jne petla_itos
pop di
pop ax
pop bx
ret 

ile_plikow:
xor ax,ax
mov ax,word ptr ile_znaleziono
add di,4
cmp ax,100
jb mniejsze_od_100
add di,2
mniejsze_od_100:
cmp ax,10
jb mniejsze_od_10
add di,2
mniejsze_od_10:
call int_to_str
inc di
inc di
lea si,znaleziono2
call wczytuj_napis
cmp word ptr ile_znaleziono,5
jb mniej_niz_5
mov byte ptr es:[di],'o'
inc di
inc di
mov byte ptr es:[di],'w'
ret
mniej_niz_5:
cmp word ptr ile_znaleziono,2
jb koniec_ile_plikow
mov byte ptr es:[di],'i'
koniec_ile_plikow:
ret


wypisz_ile_znaleziono:
push dx
push cx
push si
push es
push di
mov dx,8
mov cx,25
call wylicz_punkt
cmp word ptr ile_znaleziono,0
jne dalej_wypisuj_znalezione
lea si,nie_znaleziono1
call wczytuj_napis
jmp koniec_wypisuj_znalezione
dalej_wypisuj_znalezione:
lea si,znaleziono1
call wczytuj_napis
call ile_plikow
koniec_wypisuj_znalezione:
pop di
pop es
pop si
pop cx
pop dx
ret


wyswietl_znalezione:
push ax
push bx
push cx
push dx
call wypisz_ile_znaleziono
mov byte ptr stop_wysw_znal,0
cmp word ptr ile_znaleziono,0
je koniec_wyswietl_znalezione
mov dx,10
mov cx,27
call wylicz_punkt
call pisz_kolumne_plikow
mov dx,10
mov cx,42
call wylicz_punkt
call pisz_kolumne_plikow
koniec_wyswietl_znalezione:
pop dx
pop cx
pop bx
pop ax
ret

czysc_pole_plikow:
push ax
push bx
push cx
push dx
mov dx,10
mov cx,27
call wylicz_punkt
mov cx,7
petla_czysc_kol1:
call czysc_nazwe
push si
lea si, nazwa
call wczytuj_napis
pop si
push cx
inc dx
mov cx,27
call wylicz_punkt
pop cx
loop petla_czysc_kol1
mov dx,10
mov cx,42
call wylicz_punkt
mov cx,7
petla_czysc_kol2:
call czysc_nazwe
push si
lea si, nazwa
call wczytuj_napis
pop si
push cx
inc dx
mov cx,42
call wylicz_punkt
pop cx
loop petla_czysc_kol2
pop dx
pop cx
pop bx
pop ax
ret

odtwarzaj_z_bufora:
push ax
push cx
push es
push di
push ds
push si
mov ax,0b800h
mov es,ax
mov di,320
mov ax,09000h
mov ds,ax
mov si,320
mov cx,2000
rep movsw
pop si
pop ds
pop di
pop es
pop cx
pop ax
ret

ramka_oz:
push cx
push dx
call naglowek
mov cx,25
mov dx,18
call wylicz_punkt
lea si,podaj_nazwe
call wczytuj_napis
call pole_wpisu
mov cx,37
mov dx,20
call rysuj_przycisk_enter
pop dx
pop cx
ret

ramka_zmien:
push cx
push dx
mov cx,25
mov dx,8
call wylicz_punkt
call wczytuj_napis
lea si,zmientx
call naglowek
mov cx,25
mov dx,10
call pole_wpisu_zamien
mov cx,36
mov dx,12
call rysuj_przycisk_enter
pop dx
pop cx
ret



ramka_zamien_na:
push cx
push dx
mov cx,25
mov dx,8
call wylicz_punkt
lea si, zamien_na
call wczytuj_napis
lea si,zamien_natx
call naglowek
mov cx,25
mov dx,10
call pole_wpisu_zamien
mov cx,27
mov dx,10
call wylicz_punkt
mov byte ptr es:[di],'-'
add di,2
mov byte ptr es:[di],'>'
mov cx,30
mov dx,10
call pole_wpisu_zamien
mov cx,36
mov dx,12
call rysuj_przycisk_enter
pop dx
pop cx
ret

ramka_pobierz_znak_na_znak:
push ax
push cx
push dx
push di
push es
mov cx,25
mov dx,10
call wylicz_punkt
mov cx,2
petla_pobierz_znz:
mov ah,8
int 21h
cmp al,13
je koniec_pobierania_znz
cmp al,8
jne pobierz_znz_d2
backspace_znz:
cmp cx,2
je nie_backspace_znz
sub di,10
mov byte ptr es:[di],' '
inc cx
nie_backspace_znz:
jmp petla_pobierz_znz
pobierz_znz_d2:
cmp al,20h
jb petla_pobierz_znz
cmp al,7eh
ja petla_pobierz_znz
mov es:[di],al
add di,10
loop petla_pobierz_znz
akceptuj_znz:
mov ah,8
int 21h
cmp al,8
je backspace_znz
cmp al,13
jne akceptuj_znz
koniec_pobierania_znz:
pop es
pop di
pop dx
pop cx
pop ax
ret

zamien_znak_na_znak:
mov dx,2
znzpetla_y:
mov cx,0   ;cx=x
znzpetla_x:
push cx
push dx
call wylicz_punkt
mov al,byte ptr es:[di]
cmp al,bh
jne znz_d1
mov byte ptr es:[di],bl
znz_d1:
pop dx
pop cx
inc cx
cmp cx,80
jb znzpetla_x
inc dx
cmp dx,25
jb znzpetla_y
ret

pole_wpisu:
push bx
push di
mov cx,49
mov dx,18
call wylicz_punkt
inc di
mov bl,00111111b
mov cx,8
call tlo_pod_linia
pop di
pop bx
ret

pole_wpisu_zamien:
push bx
push di
call wylicz_punkt
inc di
mov bl,00111111b
mov cx,1
call tlo_pod_linia
pop di
pop bx
ret

odswierz_liste_plikow:
push si
push di
push ax
mov byte ptr mycha_flag,1
mov ax,2
int 33h
call czysc_pole_plikow
call wyswietl_znalezione
mov ax,1
int 33h
pop ax
pop di
pop si
ret

kontrola_mychy_pobierzn:
push cx
push dx
push di
push es
push ds
mov ax,0003h
int 33h
test bx,1
jz nielewy_kontrola_mychy_pobierzn
cmp byte ptr mycha_flag,0
jne koniec_kontrola_mychy_pobierzn
shr cx,3
shr dx,3
call wylicz_punkt
cmp byte ptr es:[di],19h ;down
jne sprawdz_up
mov ax,word ptr ile_wyswietlono
cmp ax,word ptr ile_znaleziono
jae koniec_kontrola_mychy_pobierzn
cmp byte ptr stop_wysw_znal,1
je koniec_kontrola_mychy_pobierzn
add si,112
add word ptr ile_wyswietlono,14
call odswierz_liste_plikow
jmp koniec_kontrola_mychy_pobierzn

sprawdz_up:
cmp byte ptr es:[di],18h ;up
jne dalej_mycha_pobierzn

cmp si,4002
jbe koniec_kontrola_mychy_pobierzn
sub si,112
sub word ptr ile_wyswietlono,14
call odswierz_liste_plikow
jmp koniec_kontrola_mychy_pobierzn

nielewy_kontrola_mychy_pobierzn:
mov byte ptr mycha_flag,0
dalej_mycha_pobierzn:
call czy_kliknieto_nazwe
koniec_kontrola_mychy_pobierzn:
pop ds
pop es
pop di
pop dx
pop cx
ret

czy_kliknieto_nazwe:
cmp byte ptr es:[di],' '
je nie_nazwa
cmp byte ptr es:[di],18h
je nie_nazwa
cmp byte ptr es:[di],19h
je nie_nazwa
cmp byte ptr es:[di],0dah
je nie_nazwa
cmp byte ptr es:[di],0c2h
je nie_nazwa
cmp byte ptr es:[di],0c4h
je nie_nazwa
cmp byte ptr es:[di],0bfh
je nie_nazwa
cmp byte ptr es:[di],0c0h
je nie_nazwa
cmp byte ptr es:[di],0c1h
je nie_nazwa
cmp byte ptr es:[di],0b3h
je nie_nazwa
cmp byte ptr es:[di],0d9h
je nie_nazwa
mov ax,9
call przechwyc_nazwe
ret
nie_nazwa:
mov ax,0
ret

przewin_do_poczatku_nazwy:
petla_przew_do_pocz:
cmp byte ptr es:[di],' '
je przewiniete
dec di
dec di
jmp petla_przew_do_pocz
przewiniete:
inc di
inc di
ret

przechwyc_nazwe:
push si
push es
push di
push ax
mov ax,0b800h
mov es,ax
call przewin_do_poczatku_nazwy
mov si,di
mov cx,49
mov dx,18
call wylicz_punkt
mov cx,8
przekopiuj_nazwe_w_pole:
mov al,byte ptr es:[si]
mov byte ptr es:[di],al
inc di
inc di
inc si
inc si
loop przekopiuj_nazwe_w_pole
pop ax
pop di
pop es
pop si
ret

przewin_do_konca_nazwy:
petla_przew_do_konca:
cmp byte ptr es:[di],' '
je przewiniete_konc
inc di
inc di
dec cx
jmp petla_przew_do_konca
przewiniete_konc:
ret

nazwa_wskazana_mysza:
push ax
push dx
cmp cx,9
jb koniec_nazwa_wskazana
mov ax,di
push cx
mov cx,49
mov dx,18
call wylicz_punkt
pop cx
cmp byte ptr es:[di],' '
je nie_wskazana
call przewin_do_konca_nazwy
jmp koniec_nazwa_wskazana
nie_wskazana:
mov di,ax
koniec_nazwa_wskazana:
pop dx
pop ax
ret

ramka_pobierz_nazwe:
push ax
push cx
push dx
push di
push es
push si
mov cx,49
mov dx,18
call wylicz_punkt
mov cx,9
mov si,4002
petla_pobierz:
call kontrola_mychy_pobierzn
cmp ax,9
jne pobierz_d4
mov cx,49
mov dx,18
call wylicz_punkt
mov cx,ax
pobierz_d4:
call nazwa_wskazana_mysza
mov dl,0ffh
mov ah,6
int 21h
cmp al,13
je koniec_pobierania
cmp al,' '
jne pobierz_d1 
mov al,'_'
pobierz_d1:
cmp al,8
jne pobierz_d2
backspace:
cmp byte ptr es:[di-2],' '
je nie_backspace
dec di
dec di
mov byte ptr es:[di],' '
inc cx
nie_backspace:
jmp petla_pobierz
pobierz_d2:
cmp al,'_'
je ok1
cmp al,30h
jb petla_pobierz
cmp al,3ah
jb ok1
cmp al,40h
jb petla_pobierz
cmp al,5ah
jb ok1
cmp al,61h
jb petla_pobierz
cmp al,7ah
ja petla_pobierz
ok1:
cmp cx,2
jb petla_pobierz
mov byte ptr es:[di],al
inc di
inc di
loop petla_pobierz
akceptuj:
mov ah,8
int 21h
cmp al,8
je backspace
cmp al,13
jne akceptuj
koniec_pobierania:
pop si
pop es
pop di
pop dx
pop cx
pop ax
ret

ramka_bufwczytaj_nazwe:
push ax
push cx
push dx
push si
push di
mov cx,49
mov dx,18
call wylicz_punkt
lea dx,plik
petla_bufwczytaj:
mov al,byte ptr es:[di]
cmp al,' '
je koniec_bufwczytaj
mov si,dx
mov byte ptr ds:[si],al
inc di
inc di
inc dx
jmp petla_bufwczytaj
koniec_bufwczytaj:
mov si,dx
mov byte ptr ds:[si],'.'
inc si
mov byte ptr ds:[si],'t'
inc si
mov byte ptr ds:[si],'x'
inc si
mov byte ptr ds:[si],'t'
inc si
mov byte ptr ds:[si],0
pop di
pop si
pop dx
pop cx
pop ax
ret

ramka_pobierz_pendzel:
push ax
push cx
push dx
push di
push es
mov cx,25
mov dx,10
call wylicz_punkt
mov cx,1
petla_pobierzp:
mov ah,8
int 21h
cmp al,13
je koniec_pobieraniap
cmp al,8
jne pobierzp_d2
backspacep:
cmp cx,1
je nie_backspacep
dec di
dec di
mov byte ptr es:[di],' '
inc cx
nie_backspacep:
jmp petla_pobierzp
pobierzp_d2:
cmp al,20h
jb petla_pobierzp
cmp al,7eh
ja petla_pobierzp
mov es:[di],al
inc di
inc di
loop petla_pobierzp
akceptujp:
mov ah,8
int 21h
cmp al,8
je backspacep
cmp al,13
jne akceptujp
koniec_pobieraniap:
pop es
pop di
pop dx
pop cx
pop ax
ret

ukryj_mysz:
push ax
mov ax,02h
int 33h
pop ax
ret

pokaz_mysz:
push ax
mov ax,01h
int 33h
pop ax
ret

ramka_plik_już_istnieje:
push cx
push dx
push si
call odtwarzaj_z_bufora
call rysuj_ramke
lea si,uwagatx
call naglowek
mov cx,23
mov dx,8
call wylicz_punkt
lea si,plik_istnieje
call wczytuj_napis
mov cx,23
mov dx,9
call wylicz_punkt
lea si,plik_istnieje2
call wczytuj_napis
call ramka_sprawdz_klawiature
pop si
pop dx
pop cx
ret

ramka_nie_ma_pliku:
push cx
push dx
push si
call odtwarzaj_z_bufora
call rysuj_ramke
lea si,uwagatx
call naglowek
mov cx,23
mov dx,8
call wylicz_punkt
lea si,nie_ma_pliku
call wczytuj_napis
mov cx,23
mov dx,9
call wylicz_punkt
lea si,nie_ma_pliku2
call wczytuj_napis
call ramka_sprawdz_klawiature
pop si
pop dx
pop cx
ret

ramka_nie_podano_nazwy:
push cx
push dx
push si
call odtwarzaj_z_bufora
call rysuj_ramke
lea si,uwagatx
call naglowek
mov cx,23
mov dx,8
call wylicz_punkt
lea si,nie_podano
call wczytuj_napis
mov cx,23
mov dx,9
call wylicz_punkt
lea si,nie_ma_pliku2 
call wczytuj_napis
call ramka_sprawdz_klawiature
pop si
pop dx
pop cx
ret

ramka_nie_zapisano:
push ax
push cx
push dx
push si
mov ax,02h
int 33h
call odtwarzaj_z_bufora
call rysuj_ramke
lea si,uwagatx
call naglowek
mov cx,22
mov dx,8
call wylicz_punkt
lea si,nie_zapisano
call wczytuj_napis
mov cx,22
mov dx,9
call wylicz_punkt
lea si,nie_zapisano2 
call wczytuj_napis
call rs_button_enter
mov ax,01h
int 33h
pop si
pop dx
pop cx
pop ax
ret

ramka_tylko_odczyt:
push ax
push cx
push dx
push si
mov ax,02h
int 33h
call odtwarzaj_z_bufora
call rysuj_ramke
lea si,uwagatx
call naglowek
mov cx,22
mov dx,8
call wylicz_punkt
lea si,tylko_odczyt
call wczytuj_napis
mov cx,22
mov dx,9
call wylicz_punkt
lea si,tylko_odczyt2 
call wczytuj_napis
call rs_button_enter
mov ax,01h
int 33h
pop si
pop dx
pop cx
pop ax
ret

naglowek:
mov cx,37
mov dx,6
call wylicz_punkt
push bx
inc di
mov bl,00011111b
mov cx,6
call tlo_pod_linia
dec di
pop bx
call wczytuj_napis
ret

ramka_sprawdz_klawiature:
mov cx,25
mov dx,12
call wylicz_punkt
add di,3
mov byte ptr es:[di],00011111b
sub di,3
lea si,button_tak
call wczytuj_napis
mov cx,48
mov dx,12
call wylicz_punkt
add di,3
mov byte ptr es:[di],00011111b
sub di,3
lea si,button_nie
call wczytuj_napis
mov ah,8
petla_rs_klawiature:
int 21h
cmp al,'t'
jne rs_klawiature_d1
jmp rs_klawiature_koniec
rs_klawiature_d1:
cmp al,'n'
jne rs_klawiature_d2
jmp rs_klawiature_koniec
rs_klawiature_d2:
jmp petla_rs_klawiature
rs_klawiature_koniec:
ret

rysuj_przycisk_enter:
call wylicz_punkt
push bx
push di
add di,3
mov bl,00011111b
mov cx,5
call tlo_pod_linia
pop di
pop bx
lea si,button_enter
call wczytuj_napis
ret

rs_button_enter:
push ax
mov cx,36
mov dx,12
call rysuj_przycisk_enter
mov ah,8
petla_button_enter:
int 21h
cmp al,13
jne petla_button_enter
pop ax
ret

wczytuj_napis:
cmp byte ptr ds:[si],'$'
je dalej
mov al,byte ptr ds:[si]
mov byte ptr es:[di],al
add di,2
inc si
jmp wczytuj_napis
dalej:
ret

tlo_pod_linia:
push cx
push di
petla:
mov byte ptr es:[di],bl
add di,2
loop petla
pop di
pop cx
ret

zapal_cofnij:
push di
push ax
push bx
push cx
push dx
mov cx,45
mov dx,1
call wylicz_punkt
inc di
mov bl,00011111b
mov cx,7
call tlo_pod_linia
pop dx
pop cx
pop bx
pop ax
pop di
ret

zgas_cofnij:
push di
push ax
push bx
push cx
push dx
mov cx,45
mov dx,1
call wylicz_punkt
inc di
mov bl,00010111b
mov cx,7
call tlo_pod_linia
pop dx
pop cx
pop bx
pop ax
pop di
ret

plansza_startowa:
push di
push ax
push bx
push cx
push dx
;ustawiam kursor
mov bh,0
mov dh,4
mov dl,0
mov ah,2
int 10h
;wypisuje logo
lea dx,main
mov ah,9
int 21h
;maluje tło

mov di,1
mov cx,2000
petla_plansza:
cmp byte ptr es:[di-1],'#'
jne niehasz
mov bl,01110010b
jmp dhasz
niehasz:
cmp byte ptr es:[di-1],'0'
jne nieznak2
mov bl,01111110b
jmp dhasz
nieznak2:
mov bl,00011001b
dhasz:
mov byte ptr es:[di],bl
inc di
inc di
loop petla_plansza
;ustawiam kursor
mov bh,0
mov dh,17
mov dl,35
mov ah,2
int 10h
;wypisuje by
lea dx,main2
mov ah,9
int 21h
;ustawiam kursor
mov bh,0
mov dh,16
mov dl,30
mov ah,2
int 10h
;wypisuje ascii painter
lea dx,main1
mov ah,9
int 21h
;ustawiam kursor
mov bh,0
mov dh,23
mov dl,35
mov ah,2
int 10h
;wypisuje press space
lea dx,main3
mov ah,9
int 21h
mov cx,35
mov dx,23
call wylicz_punkt
push bx
inc di
mov bl,10011111b
mov cx,13
call tlo_pod_linia
dec di
pop bx
;czekaj na start
mov ah,8
czekaj_na_start:
int 21h
cmp al,' '
jne czekaj_na_start
call wyczysc
pop dx
pop cx
pop bx
pop ax
pop di
ret

tlo_pod_menu:
mov di,1
mov bl,00011110b
mov cx,80
call tlo_pod_linia
mov di,161
mov bl,00011111b
call tlo_pod_linia
;na zielono ASCII
mov di,75
mov bl,00011010b
mov cx,3
call tlo_pod_linia
mov di,83
mov cx,2
call tlo_pod_linia
ret

start:
mov ax,@data
mov ds,ax
;robimy fullscreena :)
;mov ax,0013h
;int 10h
mov ax,0003h
int 10h

;chowaj kursor
mov ah,1
mov ch,15h
int 10h

mov ax,0b800h
mov es,ax

call plansza_startowa

call tlo_pod_menu
call pisz_menu
call zgas_cofnij
mov ax,0000h
int 33h
or ax,ax
jz koniec
mov ax,0001h
int 33h
call kursor_w_polu_rysowania

mov ax,0b800h
mov es,ax

petla2:
mov ax,0003h
int 33h
cmp dx,16
jb petla2
shr cx,3
shr dx,3

call wylicz_punkt
jmp kontrola_klawiatury

kontynuuj:

call kontrola_mychy
jmp petla2


czy_wcisniety1:
push ax
cmp byte ptr wcisniety,0
jne pomin
call ukryj_mysz
call kopiuj_do_bufora
call zapal_cofnij
mov byte ptr es:[di],al
call pokaz_mysz
mov byte ptr wcisniety,1
pomin:
pop ax
ret

koniec:
call pokaz_kursor
call sprzataj_ekran
mov ah,4ch
int 21h

kontrola_klawiatury:
mov ah,06h
mov dl,0ffh
int 21h
cmp al,'s'
jne nie_zapisuj
call modul_zapisz
jmp kontynuuj
nie_zapisuj:
cmp al,'w'
je koniec
cmp al,'c'
jne nie_wyczysc
mov ax,2
int 33h
call kopiuj_do_bufora
call wyczysc
call zapal_cofnij
mov ax,1
int 33h
jmp kontynuuj
nie_wyczysc:
cmp al,'p'
jne nie_zmienp
call modul_zmienp
jmp kontynuuj
nie_zmienp:
cmp al,'t'
jne nie_zmient
call modul_zmient
jmp kontynuuj
nie_zmient:
cmp al,'o'
jne nie_otwieraj
call modul_otworz
jmp kontynuuj
nie_otwieraj:
cmp al,'f'
jne nie_cofaj
mov ax,2
int 33h
call odtwarzaj_z_bufora
mov ax,1
int 33h
call zgas_cofnij
jmp kontynuuj
nie_cofaj:
cmp al,'z'
jne nie_zamieniaj_znakow
call modul_znz
jmp kontynuuj
nie_zamieniaj_znakow:
cmp al,'y'
jne nie_wycinaj
call modul_wycinaj
jmp kontynuuj
nie_wycinaj:
jmp kontynuuj

modul_wycinaj:
push ax
push bx

mov byte ptr opcje_flag,0
call ukryj_mysz
call kopiuj_do_bufora
call rysuj_ramke_wytnij
call ramka_wytnij_opcje
call pokaz_mysz
call zaznacz_opcje
pop bx
pop ax
call ukryj_mysz
call odtwarzaj_z_bufora
call pokaz_mysz
mov byte ptr mycha_flag,0
call zaznacz
call zaznacz2
call zaznacz3
call zapal_cofnij
ret


zaznacz:
PUSH AX
PUSH BX
PUSH CX
PUSH DX
PUSH SI
petla_zaznacz:
mov ax,03h
int 33h
cmp dx,16
jb za_male_y
shr dx,3
shr cx,3
call wylicz_punkt
mov word ptr pwyt_x,cx
mov word ptr pwyt_y,dx
test bx,1
jz nie_kliknieto_lewym
inc di
mov ax,2
int 33h
mov byte ptr es:[di],01010000b
mov ax,1
int 33h
jmp koniec_zaznacz
za_male_y:
jmp petla_zaznacz
nie_kliknieto_lewym:
jmp petla_zaznacz
koniec_zaznacz:
mov byte ptr mycha_flag,1
POP SI
pop dx
POP CX
POP bx
POP ax
ret

zaznacz2:
PUSH AX
PUSH BX
PUSH CX
PUSH DX
PUSH SI
petla_zaznacz2:
mov ax,03h
int 33h
cmp dx,16
jb za_male_y2
shr dx,3
shr cx,3
call wylicz_punkt
test bx,1
jz nie_kliknieto_lewym2
cmp byte ptr mycha_flag,1
je petla_zaznacz2
mov ax,0b800h
mov es,ax
inc di
mov ax,2
int 33h
mov byte ptr es:[di],01110000b
call porzadkuj_wspolrzedne
call maluj_zaznaczone
mov ax,1
int 33h
jmp koniec_zaznacz2
za_male_y2:
jmp petla_zaznacz2
nie_kliknieto_lewym2:
mov byte ptr mycha_flag,0
jmp petla_zaznacz2
koniec_zaznacz2:
mov byte ptr mycha_flag,1
POP SI
pop dx
POP CX
POP bx
POP ax
ret

porzadkuj_wspolrzedne:
push ax
cmp cx,word ptr pwyt_x
jae x2_wiekszerowne_x1
mov ax,word ptr pwyt_x
mov word ptr pwyt_x,cx
mov word ptr pwyt_x2,ax
jmp porzadkuj_y
x2_wiekszerowne_x1:
mov word ptr pwyt_x2,cx
porzadkuj_y:
cmp dx,word ptr pwyt_y
jae y2_wiekszerowne_y1
mov ax,word ptr pwyt_y
mov word ptr pwyt_y,dx
mov word ptr pwyt_y2,ax
jmp koniec_porzadkuj
y2_wiekszerowne_y1:
mov word ptr pwyt_y2,dx
koniec_porzadkuj:
pop ax
ret

maluj_zaznaczone:
push ax
push bx
push cx
push dx
mov cx,word ptr pwyt_x
mov dx,word ptr pwyt_y
call wylicz_punkt
inc di
mov ax,word ptr pwyt_x2
inc ax
sub ax,cx
petla_maluj:
push cx
mov cx,ax
mov bl,00000111b
call tlo_pod_linia
mov cx,word ptr pwyt_x
inc dx
call wylicz_punkt
pop cx
inc di
cmp dx,word ptr pwyt_y2
jna petla_maluj
pop dx
pop cx
pop bx
pop ax
ret

zaznacz3:
PUSH AX
PUSH BX
PUSH CX
PUSH DX
PUSH SI
petla_zaznacz3:
mov ax,03h
int 33h
cmp dx,16
jb za_male_y3
shr dx,3
shr cx,3
call wylicz_punkt
test bx,1
jz nie_kliknieto_lewym3
cmp byte ptr mycha_flag,1
je petla_zaznacz3
inc di
mov ax,2
int 33h
call czysc_wklejone
test byte ptr opcje_flag,8
jnz bez_wklejania
call wklejaj_w_miejsce
bez_wklejania:
mov ax,1
int 33h
jmp koniec_zaznacz3
za_male_y3:
jmp petla_zaznacz3
nie_kliknieto_lewym3:
mov byte ptr mycha_flag,0
jmp petla_zaznacz3
koniec_zaznacz3:
mov byte ptr mycha_flag,1
POP SI
pop dx
POP CX
POP bx
POP ax
ret

odwracaj_parzyste:
cmp bl,'>'
jne odwracaj_parzyste_d1
mov bl,'<'
jmp koniec_odwracaj_parzyste
odwracaj_parzyste_d1:
cmp bl,'<'
jne odwracaj_parzyste_d2
mov bl,'>'
jmp koniec_odwracaj_parzyste
odwracaj_parzyste_d2:
cmp bl,'}'
jne odwracaj_parzyste_d3
mov bl,'{'
jmp koniec_odwracaj_parzyste
odwracaj_parzyste_d3:
cmp bl,'{'
jne odwracaj_parzyste_d4
mov bl,'}'
jmp koniec_odwracaj_parzyste
odwracaj_parzyste_d4:
cmp bl,')'
jne odwracaj_parzyste_d5
mov bl,'('
jmp koniec_odwracaj_parzyste
odwracaj_parzyste_d5:
cmp bl,'('
jne odwracaj_parzyste_d6
mov bl,')'
jmp koniec_odwracaj_parzyste
odwracaj_parzyste_d6:
cmp bl,'/'
jne odwracaj_parzyste_d7
mov bl,'\'
jmp koniec_odwracaj_parzyste
odwracaj_parzyste_d7:
cmp bl,'\'
jne odwracaj_parzyste_d8
mov bl,'/'
jmp koniec_odwracaj_parzyste
odwracaj_parzyste_d8:
cmp bl,']'
jne odwracaj_parzyste_d9
mov bl,'['
jmp koniec_odwracaj_parzyste
odwracaj_parzyste_d9:
cmp bl,'['
jne koniec_odwracaj_parzyste
mov bl,']'
koniec_odwracaj_parzyste:
ret

licz_szerokosc_zaznaczonego:
mov cx,word ptr pwyt_x
mov bx,word ptr pwyt_x2
sub bx,cx
inc bx
mov word ptr reverse,bx
ret

wklejaj_w_miejsce:
push bx
push si
call wylicz_punkt
mov si,di
call licz_szerokosc_zaznaczonego
mov dx,word ptr pwyt_y
mov cx,word ptr pwyt_x
call wylicz_punkt
petla_wklejaj_y:
petla_wklejaj_x:
call wylicz_punkt
push ax
push es
push di
mov ax,09000h
mov es,ax
test byte ptr opcje_flag,4
jz nie_odwracaj
add di,word ptr reverse
sub word ptr reverse,2
add di,word ptr reverse
nie_odwracaj:
mov bl,byte ptr es:[di]
test byte ptr opcje_flag,4
jz nie_odwracaj2
call odwracaj_parzyste
nie_odwracaj2:
pop di
pop es
pop ax
test byte ptr opcje_flag,1
jz nie_przezroczyste
cmp bl,byte ptr tlo
je tla_nie_rysuj
nie_przezroczyste:
mov byte ptr es:[si],bl
tla_nie_rysuj:
inc cx
inc si
inc si
cmp cx,word ptr pwyt_x2
jna petla_wklejaj_x
call licz_szerokosc_zaznaczonego
add si,160
shl bx,1
sub si,bx
inc dx
cmp dx,word ptr pwyt_y2
jna petla_wklejaj_y
pop si
pop bx
ret

czysc_wklejone:
push cx
push dx
mov dx,word ptr pwyt_y
mov cx,word ptr pwyt_x
call wylicz_punkt
petla_czyscw_y:
petla_czyscw_x:
call wylicz_punkt
test opcje_flag,2
jnz nie_zamazuj
mov al,byte ptr tlo
mov byte ptr es:[di],al
nie_zamazuj:
inc di
mov byte ptr es:[di],01110000b
inc cx
cmp cx,word ptr pwyt_x2
jna petla_czyscw_x
mov cx,word ptr pwyt_x
inc dx
cmp dx,word ptr pwyt_y2
jna petla_czyscw_y
pop dx
pop cx
ret

modul_znz:
mov ax,2
int 33h
call kopiuj_do_bufora
call rysuj_ramke
call ramka_zamien_na
call ramka_pobierz_znak_na_znak
push ax
push bx
mov ax,0b800h
mov es,ax
mov cx,25
mov dx,10
call wylicz_punkt
mov bh,byte ptr es:[di]
add di,10
mov bl,byte ptr es:[di]
call odtwarzaj_z_bufora
call zamien_znak_na_znak
pop bx
pop ax
call pokaz_mysz
call zapal_cofnij
ret

czy_otworzyc_menu:
ret

kontrola_mychy:
lea dx,pendzel
test bx,1
jz nie_lewy
cmp byte ptr mycha_flag,1
jne rysuj_pendzlem
mov byte ptr wcisniety,1
jmp koniec_mychy
rysuj_pendzlem:
mov al,byte ptr pendzel
call czy_wcisniety1
mov byte ptr es:[di],al
jmp koniec_mychy
nie_lewy:
test bx,2
jnz p_prawy
push dx
push ax
cmp byte ptr wcisniety,1
jne pomin2
mov byte ptr wcisniety,0
mov byte ptr mycha_flag,0
pomin2:
pop ax
pop dx
jmp koniec_mychy
p_prawy:
mov al,byte ptr tlo
call czy_wcisniety1
mov byte ptr es:[di],al
koniec_mychy:
ret

wylicz_punkt:
push ax
mov ax,dx
shl ax,2
add ax,dx
shl ax,4
add ax,cx
shl ax,1
mov di,ax
pop ax
ret

modul_zmienp:
mov ax,2
int 33h
call kopiuj_do_bufora
call rysuj_ramke
push si
lea si,zmien_pendzel
call ramka_zmien
pop si
call ramka_pobierz_pendzel
push si
lea si,pendzel
call zmien
pop si
call odtwarzaj_z_bufora
mov ax,1
int 33h
ret

modul_zmient:
mov ax,2
int 33h
call kopiuj_do_bufora
call rysuj_ramke
push si
lea si,zmien_tlo
call ramka_zmien
pop si
call ramka_pobierz_pendzel
push si
lea si,tlo
call zmien
pop si
call odtwarzaj_z_bufora
mov ax,1
int 33h
ret


utworz_plik:
mov cx,0
mov ax,seg plik
mov ds,ax
mov dx,offset plik
mov ah,3ch
int 21h
ret

zamknij_plik:
mov ah,3eh
lea dx,handle
mov bx,word ptr handle
int 21h
ret

zapisz:
lea dx,plik
mov ah,3dh
mov al,1
int 21h
jnc plik_otwarto
call utworz_plik
jc quitz
plik_otwarto:
lea dx,handle
mov word ptr handle,ax
mov ah,42h
mov al,2
xor dx,dx
xor cx,cx
int 21h
mov ax,0b800h
mov es,ax
mov dx,2   ;dx=y
petla_y:
mov cx,0   ;cx=x
petla_x:
push cx
push dx
call wylicz_punkt
lea dx,znak
mov al,byte ptr es:[di]
mov byte ptr znak,al
mov bx,word ptr handle
mov ah,40h
mov cx,1
int 21h
pop dx
pop cx
inc cx
cmp cx,80
jb petla_x
inc dx
push dx
lea dx,znak
mov al,13
mov byte ptr znak,al
mov bx,word ptr handle
mov ah,40h
mov cx,1
int 21h
lea dx,znak
mov al,10
mov byte ptr znak,al
mov bx,word ptr handle
mov ah,40h
mov cx,1
int 21h
pop dx
cmp dx,25
jb petla_y
quitz:
call zamknij_plik
ret

info_o_pliku:
lea dx,plik
mov ax,4300h
int 21h
jnc info_d1
cmp ax,5
jne info_d2
call ramka_nie_zapisano  ;dostep nie możliwy
call odtwarzaj_z_bufora
jmp mzapisz_d3
info_d2:
jmp mzapisz_d1 ;nie ma pliku (jeszcze)
info_d1:
and cx,01h
cmp cx,00h
jne info_nie_zywkly
call ramka_plik_już_istnieje
call odtwarzaj_z_bufora
cmp al,'n'
je petla_mzapisz
jmp mzapisz_d1
info_nie_zywkly:
cmp cx,02h
jne info_nie_ukryty
call ramka_plik_już_istnieje ;ukryty
call odtwarzaj_z_bufora
cmp al,'n'
je petla_mzapisz
jmp mzapisz_d1
info_nie_ukryty:
call ramka_tylko_odczyt ;tylko do odczytu
call odtwarzaj_z_bufora
jmp mzapisz_d3


modul_zapisz:
push ax
push bx
call kursor_w_polu_plikow
call ukryj_mysz
call kopiuj_do_bufora
petla_mzapisz:
mov word ptr ile_wyswietlono,14
call rysuj_ramke_oz
call buforuj_znalezione
mov si,4002
call wyswietl_znalezione
push si
lea si,zapisztx
call ramka_oz
pop si
call pokaz_mysz
call ramka_pobierz_nazwe
call ramka_bufwczytaj_nazwe
lea dx,plik
push di
mov di,dx
cmp byte ptr ds:[di],'.'
pop di
jne mzapisz_d2
call ukryj_mysz
call ramka_nie_podano_nazwy
cmp al,'n'
jne petla_mzapisz
call odtwarzaj_z_bufora
call pokaz_mysz
jmp mzapisz_d3
mzapisz_d2:
call ukryj_mysz
jmp info_o_pliku
mzapisz_d1:
call odtwarzaj_z_bufora
call zapisz
mzapisz_d3:
call kursor_w_polu_rysowania
call pokaz_mysz
pop bx
pop ax
ret

otworz:
lea dx,plik
mov ah,3dh
mov al,0
int 21h
jnc next
ret
next:
lea dx,handle
mov word ptr handle,ax
mov ah,42h
mov al,0
xor dx,dx
xor cx,cx
int 21h
mov ax,0b800h
mov es,ax
mov dx,2   ;dx=y
push cx
push dx
opetla_y:
pop dx
pop cx
mov cx,0   ;cx=x
opetla_x:
push cx
push dx
call wylicz_punkt
lea dx,znak
mov bx,word ptr handle
mov cx,1
mov ah,3fh
int 21h
cmp ax,cx
jne quit
mov al,byte ptr znak
cmp al,13
je d1
cmp al,10
je d3
mov byte ptr es:[di],al
pop dx
pop cx
inc cx
push cx
push dx
d1:
pop dx
pop cx
cmp cx,80
jbe opetla_x
push cx
push dx
d3:
pop dx
pop cx
inc dx
push cx
push dx
cmp dx,25
jbe opetla_y
quit:
pop dx
pop cx
call zamknij_plik
ret

kursor_W_polu_plikow:
mov ax,08h
mov cx,72
mov dx,140
int 33h
mov ax,07h
mov cx,200
mov dx,448
int 33h
ret

kursor_w_polu_rysowania:
mov ax,08h
mov cx,16
mov dx,199
int 33h
mov ax,07h
mov cx,0
mov dx,632
int 33h
ret

modul_otworz:
push ax
push bx
call kursor_w_polu_plikow
call ukryj_mysz
call kopiuj_do_bufora
petla_otworz:
mov byte ptr mycha_flag,1
mov word ptr ile_wyswietlono,14
call rysuj_ramke_oz
call buforuj_znalezione
mov si,4002
call wyswietl_znalezione
push si
lea si,otworztx
call ramka_oz
pop si
call pokaz_mysz
call ramka_pobierz_nazwe
call ramka_bufwczytaj_nazwe
push di
lea di,plik
cmp byte ptr ds:[di],'.'
pop di
jne motworz_d2
call ukryj_mysz
call ramka_nie_podano_nazwy
cmp al,'n'
jne petla_otworz
call odtwarzaj_z_bufora
call pokaz_mysz
jmp motworz_d1
motworz_d2:
call ukryj_mysz
call wyczysc
call otworz
call pokaz_mysz
jnc motworz_d1
call ukryj_mysz
call ramka_nie_ma_pliku
cmp al,'t'
je petla_otworz
call ukryj_mysz
call odtwarzaj_z_bufora
call pokaz_mysz
motworz_d1:
call zapal_cofnij
call kursor_w_polu_rysowania
call pokaz_mysz
pop bx
pop ax
ret

wyczysc:
mov ax,02h
int 33h
mov ax,0b800h
mov es,ax
mov dx,2
mov cx,0
call wylicz_punkt
lea dx,tlo
mov al,byte ptr tlo
mov ah,01110000b
mov cx,1840
rep stosw
mov ax,01h
int 33h
ret

pisz_menu:
mov di,74
lea si,napis
call wczytuj_napis
mov di,162
lea si,menu
call wczytuj_napis
mov di,302
lea dx,pendzel
mov al,byte ptr pendzel
mov byte ptr es:[di],al
mov al,10111110b
mov byte ptr es:[di+1],al
mov di,304
lea si,menu1
call wczytuj_napis
mov di,316
lea dx,tlo
mov al,byte ptr tlo
mov byte ptr es:[di],al
mov al,10111110b
mov byte ptr es:[di+1],al
ret

zmien:
push ax
push cx
push dx
push di
mov cx,25
mov dx,10
call wylicz_punkt
mov al,byte ptr es:[di]
mov byte ptr ds:[si],al
call pisz_menu
pop di
pop dx
pop cx
pop ax
ret

pokaz_kursor:
mov ah,1
mov ch,6
mov cl,7
int 10h
ret


sprzataj_ekran:
mov ax,2
int 33h
mov ax,0b800h
mov es,ax
mov di,0
mov al,' '
mov ah,00000111b
mov cx,2000
rep stosw
ret

END start