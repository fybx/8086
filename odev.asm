;
; 	Ferit Yiğit BALABAN
;	BMB3010			Mayıs 12 Ödevi
;


.model small
.stack 100h 		; TLINK.EXE Stack uyarısı vermesin diye
.code
org 100h		; belleği 0x100 pozisyonundan başlat

basla:
    mov dl, 41h		; DL yazmacına "A" karakterinin ASCII sayısal karşılığını taşı
    mov ah, 2h		; AH yazmacına 21h kesmesinin 2h altyordamı için 2h sayısını taşı
    int 21h		; 21h kesmesini çağır (DL yazmacındaki değeri ekrana karakter olarak bas)

dongu:			; burada döngüye girip "Z" değerine kadar ekrana yazdırma yapılacak
    inc dl		; karakterin ASCII karşılığını 1 arttır (A => B, B=>C ...)
    int 21h		; kesmeyi çağır (karakteri ekrana bas)
    cmp dl, 5Ah		; DL yazmacındaki değeri 5A ile kıyasla (karakter Z mi?)
    jnz dongu		; karakter Z değilse döngünün başına dön (dongu etiketine atla)

cikis:			; burada programdan hatasız çıkmak için kesme yapılacak
    mov ah, 4Ch		; AH yazmacına 4Ch değerini taşı
    int 21h		; 21h kesmesini çağır (4Ch altyordamı ile program sona erer)

end basla
