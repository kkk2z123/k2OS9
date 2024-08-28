; bootloader.asm
[BITS 16]
[ORG 0x7C00]

; BIOS のブートセクタからの初期設定
cli
hlt

; カーネルを読み込む
mov ah, 0x02    ; ドライブ読み込みの機能番号
mov al, 0x01    ; セクタの数
mov ch, 0       ; シリンダー
mov cl, 0x02    ; セクタ
mov dh, 0       ; ヘッド
mov dl, 0x80    ; ドライブ番号 (第一ハードディスク)
int 0x13        ; BIOS インタラプト

; カーネルをメモリに転送
mov ax, 0x1000   ; カーネルの読み込み先アドレス
mov es, ax
mov di, 0x1000
mov cx, 0x0200
rep movsb

; カーネルを実行する
jmp 0x1000

times 510 - ($ - $$) db 0
dw 0xAA55
