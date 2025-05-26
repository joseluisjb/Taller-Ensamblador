.model small
.stack 100h

.data
    playerX db 10
    playerY db 12
    obsX db 79
    obsY db 12
    chrPlayer db 01
    chrObs db 0220
    
    score dw 0                ; dw para soportar score de 9999
    scoreText db 'Score: ', '$'
    scoreBuffer db '0000$'    ; Buffer para convertir el score a texto
    highScore dw 0
    highScoreText db 'HighScore: ', '$'
    highScoreBuffer db '0000$'
    juegoCompletado db "Juego Completado$"
    decoracion db 04h
    
    velocidadActual dw 0FFFFh  ; Valor inicial para espera lenta
    nivelVelocidad db 0        ; Nivel de velocidad actual (1=lento, 2=medio, 3=r?pido)
    
    gameOver db "Game Over$"
    cod1 db "Israel Bulla Rey - 1152358$"
    cod2 db "Jose Luis Jimenez Bayona - 1152384$"
    texto db "Presione enter para empezar$"
    saltoLinea db 13, 10, '$'
    volverEmpezar db "Presione Enter para volver a inicio$"
    salir db "Presione Esc para salir$"
    
    ; Nuevas cadenas para las instrucciones
    titulojuego db "--- TURBO EVADE ---$"
    instrucciones1 db "1. Presione ENTER para iniciar el juego$"
    instrucciones2 db "2. Use las flechas del teclado para mover al personaje$"
    instrucciones3 db "3. Evite los obstaculos que aparecen en pantalla$"
    instrucciones4 db "4. Al morir, presione ENTER para volver a jugar$"
    instrucciones5 db "5. Presione ESC para salir del juego$"
    tituloInstrucciones db "--- INSTRUCCIONES ---$"
    
    obsX1 db 255 ; 255 es un valor muy grande que indica que el obstaculo aun no esta en pantalla 
    obsY1 db 10
    
    obsX2 db 255
    obsY2 db 8

    obsX3 db 255
    obsY3 db 14

    obsX4 db 255
    obsY4 db 6

    obsX5 db 255
    obsY5 db 16
    
    obsX6 db 255
    obsY6 db 23
    
    obsX7 db 255
    obsY7 db 20
    
    obsX8 db 255
    obsY8 db 2
    
    obsX9 db 255
    obsY9 db 4
    
    obsX10 db 255
    obsY10 db 21
    
    obsX11 db 255
    obsY11 db 1
    
    obsX12 db 255
    obsY12 db 3
    
    obsX13 db 255
    obsY13 db 5
    
    obsX14 db 255
    obsY14 db 11
    
    obsX15 db 255
    obsY15 db 7
    
    obsX16 db 255
    obsY16 db 9
    
    obsX17 db 255
    obsY17 db 12
    
    obsX18 db 255
    obsY18 db 13
    
    obsX19 db 255
    obsY19 db 15
    
    obsX20 db 255
    obsY20 db 18
    
    obsX21 db 255
    obsY21 db 24
    
    obsX22 db 255
    obsY22 db 17
    
    obsX23 db 255
    obsY23 db 22
    

.code
start:
    mov ax, @data
    mov ds, ax
    
    ;Inicializamos todo de nuevo:
    mov playerX, 10
    mov playerY, 12
    mov obsX, 79
    mov obsY, 12
    mov chrPlayer, 01
    mov chrObs, 0220
    mov velocidadActual, 0FFFFh
    mov nivelVelocidad, 0
    mov obsX1, 255
    mov obsY1, 10
    mov obsX2, 255
    mov obsY2, 8
    mov obsX3, 255
    mov obsY3, 14
    mov obsX4, 255
    mov obsY4, 6
    mov obsX5, 255
    mov obsY5, 16
    mov obsX6, 255
    mov obsY6, 23
    mov obsX7, 255
    mov obsY7, 20
    mov obsX8, 255
    mov obsY8, 2
    mov obsX9, 255
    mov obsY9, 4
    mov obsX10, 255
    mov obsY10, 21
    mov obsX11, 255
    mov obsY11, 1
    mov obsX12, 255
    mov obsY12, 3
    mov obsX13, 255
    mov obsY13, 5
    mov obsX14, 255
    mov obsY14, 11
    mov obsX15, 255
    mov obsY15, 7
    mov obsX16, 255
    mov obsY16, 9
    mov obsX17, 255
    mov obsY17, 12
    mov obsX18, 255
    mov obsY18, 13
    mov obsX19, 255
    mov obsY19, 15
    mov obsX20, 255
    mov obsY20, 18
    mov obsX21, 255
    mov obsY21, 24
    mov obsX22, 255
    mov obsY22, 17
    mov obsX23, 255
    mov obsY23, 22
    
    ; Modo texto 80x25 con interrupcion BIOS para configurar la pantalla
    mov ah, 0
    mov al, 3
    int 10h
    
    mov score, 0 ; Iniciar el score en 0
    
    ; Mostrar informacion de los autores
    mov dx, offset cod1
    mov ah, 9
    int 21h
    mov ah, 09h
    lea dx, saltoLinea
    int 21h
    mov dx, offset cod2
    mov ah, 9
    int 21h
    mov ah, 09h
    lea dx, saltoLinea
    int 21h
    
    ; Mostrar t?tulo de juego
    mov ah, 02h
    mov bh, 0
    mov dh, 5       ; Fila 5
    mov dl, 30      ; Columna centrada
    int 10h
    mov dx, offset titulojuego
    mov ah, 9
    int 21h
    
    ; Mostrar t?tulo de instrucciones centrado
    mov ah, 02h
    mov bh, 0
    mov dh, 9       ; Fila 9
    mov dl, 29      ; Columna centrada
    int 10h
    mov dx, offset tituloInstrucciones
    mov ah, 9
    int 21h
    
    ; Mostrar instrucci?n 1 centrada
    mov ah, 02h
    mov bh, 0
    mov dh, 12       ; Fila 12
    mov dl, 20      ; Columna centrada
    int 10h
    mov dx, offset instrucciones1
    mov ah, 9
    int 21h
    
    ; Mostrar instrucci?n 2 centrada
    mov ah, 02h
    mov bh, 0
    mov dh, 13       ; Fila 13
    mov dl, 12      ; Columna centrada
    int 10h
    mov dx, offset instrucciones2
    mov ah, 9
    int 21h
    
    ; Mostrar instrucci?n 3 centrada
    mov ah, 02h
    mov bh, 0
    mov dh, 14      ; Fila 14
    mov dl, 15      ; Columna centrada
    int 10h
    mov dx, offset instrucciones3
    mov ah, 9
    int 21h
    
    ; Mostrar instrucci?n 4 centrada
    mov ah, 02h
    mov bh, 0
    mov dh, 15      ; Fila 15
    mov dl, 16      ; Columna centrada
    int 10h
    mov dx, offset instrucciones4
    mov ah, 9
    int 21h
    
    ; Mostrar instrucci?n 5 centrada
    mov ah, 02h
    mov bh, 0
    mov dh, 16      ; Fila 16
    mov dl, 21      ; Columna centrada
    int 10h
    mov dx, offset instrucciones5
    mov ah, 9
    int 21h
    
    ; Mostrar "Presione enter para empezar"
    mov ah, 02h
    mov bh, 0
    mov dh, 20      ; Fila 14
    mov dl, 26      ; Columna centrada
    int 10h
    mov dx, offset texto
    mov ah, 9
    int 21h

esperar_tecla:
    mov ah, 00h ; Leer tecla del teclado
    int 16h
    cmp al, 13 ; Verificar si es Enter
    jne esperar_tecla ; Ir a esperar_tecla si no es Enter
    jmp limpiar_pantalla ; Ir a limpiar_pantalla si es Enter
    
limpiar_pantalla:
    mov ah, 0
    mov al, 3
    int 10h
    jmp main_loop ; Ir al main_loop

; Funcion convertir el score a texto
ConvertirScoreATexto proc
    mov ax, score ; Cargar en ax
    mov bx, 10 ; Divisor para ir separando digitos
    mov cx, 4 ; Contador para los 4 digitos
    mov di, offset scoreBuffer + 3  ; Empezamos desde el ultimo digito del buffer
    
convertir_loop:
    xor dx, dx ; Limpiar dx para dividir
    div bx ; Dividir ax / 10
    add dl, '0' ; Convertir a ASCII
    mov [di], dl ; Guardar en buffer
    dec di ; Mover al digito anterior
    loop convertir_loop ; Repetir hasta terminar
    
    ret
ConvertirScoreATexto endp

ConvertirHighScoreATexto proc ;Aplicar lo mismo para highscore
    mov ax, highScore
    mov bx, 10
    mov cx, 4
    mov di, offset highScoreBuffer + 3

convertir_high_loop:
    xor dx, dx
    div bx
    add dl, '0'
    mov [di], dl
    dec di
    loop convertir_high_loop
    
    ret
ConvertirHighScoreATexto endp

; Funcion para mostrar el score
MostrarScore proc
    ; Posicionar el cursor
    mov ah, 02h
    mov bh, 0
    mov dh, 0       ; Fila 0
    mov dl, 0       ; Columna 0
    int 10h
    
    ; Mostrar en pantalla: Score:
    mov dx, offset scoreText
    mov ah, 09h
    int 21h
    
    ; Convertir el score a texto
    call ConvertirScoreATexto
    
    ; Mostrar el valor del score
    mov dx, offset scoreBuffer
    mov ah, 09h
    int 21h
    
    ; Mostrar HighScore
    mov ah, 02h
    mov bh, 0
    mov dh, 0
    mov dl, 20  ; Mostrar a partir de la columna 20
    int 10h

    mov dx, offset highScoreText
    mov ah, 09h
    int 21h

    call ConvertirHighScoreATexto
    mov dx, offset highScoreBuffer
    mov ah, 09h
    int 21h
    
    ret
MostrarScore endp

; Funcion de incrementar el score con el tiempo
IncrementarScore proc
    inc score
    cmp score, 9999
    jbe no_reset_score
    call ganador
no_reset_score:
    ret
IncrementarScore endp

; Nueva funci?n para actualizar la velocidad
ActualizarVelocidad proc
    cmp nivelVelocidad, 3
    je ya_maxima       ; Si ya esta en maxima velocidad, no hacer nada
    
    cmp score, 1500
    jae velocidad_alta
    cmp score, 1000
    jae velocidad_media
    cmp score, 500
    jae velocidad_baja
    jmp ya_maxima  ; Si score < 100, mantener velocidad actual

velocidad_alta:
    ; Velocidad rapida (nivel 3)
    cmp nivelVelocidad, 3
    je ya_maxima
    mov velocidadActual, 25000
    ; Valor para velocidad rapida
    mov nivelVelocidad, 3
    jmp ya_maxima

velocidad_media:
    ; Velocidad media (nivel 2)
    cmp nivelVelocidad, 2
    je ya_maxima
    mov velocidadActual, 35000  ; Valor para velocidad media
    mov nivelVelocidad, 2
    jmp ya_maxima  
    
velocidad_baja:
    ; Velocidad baja (nivel 1)
    cmp nivelVelocidad, 1
    je ya_maxima
    mov velocidadActual, 45000  ; Valor para velocidad lenta
    mov nivelVelocidad, 1        
      
ya_maxima:
    ret
ActualizarVelocidad endp

main_loop:
    ; Mostrar el score
    call MostrarScore
    
    ; Incrementar el score cada ciclo
    call IncrementarScore
    
    ; Verificar y actualizar velocidad seg?n el score
    call ActualizarVelocidad
    
    ; Ver si se presiono una tecla
    mov ah, 01h
    int 16h
    jz continue_logic   ; Si no hay tecla seguir a la logica
    ; Si hay tecla, leerla y mover al jugador
    mov ah, 00h
    int 16h
    mov bl, ah

    call BorrarJugador ; Al mover es necesario eliminar el simbolo de la posicion anterior

    ; Flechas, se compara la tecla para mover al player
    cmp bl, 4Bh ; izquierda
    je mover_izq
    cmp bl, 4Dh ; derecha
    je mover_der
    cmp bl, 48h ; arriba
    je mover_arriba
    cmp bl, 50h ; abajo
    je mover_abajo
    jmp continue_logic

mover_izq:
    cmp playerX, 0 ; Movimiento desde la columna 0
    je continue_logic
    dec playerX
    jmp continue_logic
mover_der:
    cmp playerX, 79 ; Movimiento hasta la columna 79
    je continue_logic
    inc playerX
    jmp continue_logic
mover_arriba:
    cmp playerY, 1 ; 1 para evitar la fila del score que es 0
    je continue_logic
    dec playerY
    jmp continue_logic
mover_abajo:
    cmp playerY, 24 ; Movimiento hasta la fila 24
    je continue_logic
    inc playerY
    jmp continue_logic
    
continue_logic:; Siempre se llama, decremento obsX
    ; Se eliminan los simbolos de la consola de los obstaculos del ciclo anterior
    call BorrarObstaculo
    call BorrarObstaculo1
    call BorrarObstaculo2
    call BorrarObstaculo3
    call BorrarObstaculo4
    call BorrarObstaculo5
    call BorrarObstaculo6
    call BorrarObstaculo7
    call BorrarObstaculo8
    call BorrarObstaculo9
    call BorrarObstaculo10
    call BorrarObstaculo11
    call BorrarObstaculo12
    call BorrarObstaculo13
    call BorrarObstaculo14
    call BorrarObstaculo15
    call BorrarObstaculo16
    call BorrarObstaculo17
    call BorrarObstaculo18
    call BorrarObstaculo19
    call BorrarObstaculo20
    call BorrarObstaculo21
    call BorrarObstaculo22
    call BorrarObstaculo23
    dec obsX ; Mover obstaculo principal
    cmp obsX, 0
    jge skip_reset
    mov obsX, 79 ; Si llega el obstaculo al borde izquierdo, reinciar y enviarlo al principio
   
skip_reset:
    ; Activar mas obstaculos cuando obsX cruce ciertas posiciones
    cmp obsX, 65
    jne activar1
    mov obsX1, 79 
activar1:
    cmp obsX, 50
    jne activar2
    mov obsX2, 79 

activar2:
    cmp obsX, 35
    jne activar3
    mov obsX3, 79

activar3:
    cmp obsX, 20
    jne activar4
    mov obsX4, 79 

activar4:
    cmp obsX, 10
    jne activar5
    mov obsX5, 79 
    
activar5:
    cmp obsX, 22
    jne activar6
    mov obsX6, 79
    
activar6:
    cmp obsX, 30
    jne activar7
    mov obsX7, 79
    
activar7:
    cmp obsX, 40
    jne activar8
    mov obsX8, 79
    
activar8:
    cmp obsX, 45
    jne activar9
    mov obsX9, 79
    
activar9:
    cmp obsX, 55
    jne activar10
    mov obsX10, 79
   
activar10:
    cmp obsX, 15
    jne activar11
    mov obsX11, 79
    
activar11:
    cmp obsX, 64
    jne activar12
    mov obsX12, 79

activar12:
    cmp obsX, 60
    jne activar13
    mov obsX13, 79

activar13:
    cmp obsX, 70
    jne activar14
    mov obsX14, 79
    
activar14:
    cmp obsX, 21
    jne activar15
    mov obsX15, 79
    
activar15:
    cmp obsX, 53
    jne activar16
    mov obsX16, 79
    
activar16:
    cmp obsX, 71
    jne activar17
    mov obsX17, 79
    
activar17:
    cmp obsX, 67
    jne activar18
    mov obsX18, 79
    
activar18:
    cmp obsX, 7
    jne activar19
    mov obsX19, 79
    
activar19:
    cmp obsX, 9
    jne activar20
    mov obsX20, 79
    
activar20:
    cmp obsX, 19
    jne activar21
    mov obsX21, 79
    
activar21:
    cmp obsX, 46
    jne activar22
    mov obsX22, 79
    
activar22:
    cmp obsX, 71
    jne fin_activacion
    mov obsX23, 79

fin_activacion:
    cmp obsX1, 80 ; Comparar si el caracter esta en columna >= 80
    jae mover1 ; Si si, No hacer nada
    dec obsX1 ; Si no, moverlo a la izquierda decrementando el valor de la columna  
mover1:
    
    cmp obsX2, 80 
    jae mover2
    dec obsX2
mover2:

    cmp obsX3, 80
    jae mover3
    dec obsX3
mover3:

    cmp obsX4, 80
    jae mover4
    dec obsX4
mover4:

    cmp obsX5, 80
    jae mover5
    dec obsX5
mover5:

    cmp obsX6, 80
    jae mover6
    dec obsX6
mover6:

    cmp obsX7, 80
    jae mover7
    dec obsX7
mover7:

    cmp obsX8, 80
    jae mover8
    dec obsX8
mover8:

    cmp obsX9, 80
    jae mover9
    dec obsX9
mover9:

    cmp obsX10, 80
    jae mover10
    dec obsX10
mover10:

    cmp obsX11, 80
    jae mover11
    dec obsX11
mover11:

    cmp obsX12, 80
    jae mover12
    dec obsX12
mover12:

    cmp obsX13, 80
    jae mover13
    dec obsX13
mover13:

    cmp obsX14, 80
    jae mover14
    dec obsX14
mover14:

    cmp obsX15, 80
    jae mover15
    dec obsX15
mover15:

    cmp obsX16, 80
    jae mover16
    dec obsX16
mover16:

    cmp obsX17, 80
    jae mover17
    dec obsX17
mover17:
    
    cmp obsX18, 80
    jae mover18
    dec obsX18
mover18:
    
    cmp obsX19, 80
    jae mover19
    dec obsX19
mover19:
    
    cmp obsX20, 80
    jae mover20
    dec obsX20
mover20:
    
    cmp obsX21, 80
    jae mover21
    dec obsX21
mover21:
    
    cmp obsX22, 80
    jae mover22
    dec obsX22
mover22:
    
    cmp obsX23, 80
    jae mover23
    dec obsX23
mover23:
    
    ; Detectar si el player colisiono con algun obstaculo
    call DetectarColisionX
    call DetectarColisionX1
    call DetectarColisionX2
    call DetectarColisionX3
    call DetectarColisionX4
    call DetectarColisionX5
    call DetectarColisionX6
    call DetectarColisionX7
    call DetectarColisionX8
    call DetectarColisionX9
    call DetectarColisionX10
    call DetectarColisionX11
    call DetectarColisionX12
    call DetectarColisionX13
    call DetectarColisionX14
    call DetectarColisionX15
    call DetectarColisionX16
    call DetectarColisionX17
    call DetectarColisionX18
    call DetectarColisionX19
    call DetectarColisionX20
    call DetectarColisionX21
    call DetectarColisionX22
    call DetectarColisionX23
    ; Redibujar todo
    call DibujarObstaculo
    call DibujarObstaculo1
    call DibujarObstaculo2
    call DibujarObstaculo3
    call DibujarObstaculo4
    call DibujarObstaculo5
    call DibujarObstaculo6
    call DibujarObstaculo7
    call DibujarObstaculo8
    call DibujarObstaculo9
    call DibujarObstaculo10
    call DibujarObstaculo11
    call DibujarObstaculo12
    call DibujarObstaculo13
    call DibujarObstaculo14
    call DibujarObstaculo15
    call DibujarObstaculo16
    call DibujarObstaculo17
    call DibujarObstaculo18
    call DibujarObstaculo19
    call DibujarObstaculo20
    call DibujarObstaculo21
    call DibujarObstaculo22
    call DibujarObstaculo23
    call DibujarJugador
    call Espera ; Espera del programa para frenar la velocidad
    jmp main_loop ; Reiniciar el ciclo
    
DibujarJugador:
    ; Asegurarse que el jugador no esta en la fila 0
    cmp playerY, 0
    jne posicion_valida
    mov playerY, 1      ; Si por algun error esta en fila 0, mover a fila 1
posicion_valida:
    mov dl, playerX
    mov dh, playerY
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, chrPlayer
    int 10h
    ret

; Funcion para borrar el jugador
BorrarJugador:
    mov dl, playerX
    mov dh, playerY
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret

;Funcion para dibujar primer obstaculo
DibujarObstaculo:
    cmp obsX, 0 ; Verificar si esta fuera de la pantalla, antes de 0
    jl No_DibujarObstaculo ; Si si no dibujar
    cmp obsX, 79 ; Verificar si esta fuera de la pantalla, luego de 79
    jg No_DibujarObstaculo
    
    ; Posicionar el cursor en obsX, obsY
    mov dl, obsX
    mov dh, obsY
    mov ah, 02h ; Mover cursor
    mov bh, 0 ; Pagina de video 0
    int 10h ; Interrumpir
    ; Dibujar el caracter (|)
    mov ah, 09h          ; funci?n para mostrar car?cter con atributo
    mov al, chrObs       ; car?cter a imprimir (por ejemplo '|')
    mov bh, 0            ; p?gina de video
    mov bl, 01h          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo:
    ret ; Salir si no se tiene que dibujar

BorrarObstaculo:
    ;Para los casos borrar obstaculo
    cmp obsX, 0 ; Verificar si el obstaculo esta en columna <0
    jl No_BorrarObstaculo
    cmp obsX, 79 ; Verificar si el obstaculo esta en columna >79
    jg No_BorrarObstaculo
    
    ; Mover cursor  
    mov dl, obsX
    mov dh, obsY
    mov ah, 02h
    mov bh, 0
    int 10h
    ; Borrar obstaculo con espacio: ' '
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo:
    ret
  
DibujarObstaculo1:
    cmp obsX1, 0
    jl No_DibujarObstaculo1
    cmp obsX1, 79
    jg No_DibujarObstaculo1

    mov dl, obsX1
    mov dh, obsY1
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 02h          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret
    
No_DibujarObstaculo1:
    ret

BorrarObstaculo1:
    cmp obsX1, 0
    jl No_BorrarObstaculo1
    cmp obsX1, 79
    jg No_BorrarObstaculo1
    
    mov dl, obsX1
    mov dh, obsY1
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo1:
    ret
    
DibujarObstaculo2:
    cmp obsX2, 0
    jl No_DibujarObstaculo2
    cmp obsX2, 79
    jg No_DibujarObstaculo2
    
    mov dl, obsX2
    mov dh, obsY2
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 03h          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret
    
No_DibujarObstaculo2:
    ret

BorrarObstaculo2:
    cmp obsX2, 0
    jl No_BorrarObstaculo2
    cmp obsX2, 79
    jg No_BorrarObstaculo2
    
    mov dl, obsX2
    mov dh, obsY2
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo2:
    ret ; Si no se tiene que borrar salir

DibujarObstaculo3:
    cmp obsX3, 0
    jl No_DibujarObstaculo3
    cmp obsX3, 79
    jg No_DibujarObstaculo3
    mov dl, obsX3
    mov dh, obsY3
    mov ah, 02h
    mov bh, 0
    int 10h
    ; Mostrar caracter con atributo de color
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 0Fh          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo3:
    ret

BorrarObstaculo3:
    cmp obsX3, 0
    jl No_BorrarObstaculo3
    cmp obsX3, 79
    jg No_BorrarObstaculo3
    
    mov dl, obsX3
    mov dh, obsY3
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
 
No_BorrarObstaculo3:
    ret
    
DibujarObstaculo4:
    cmp obsX4, 0
    jl No_DibujarObstaculo4
    cmp obsX4, 79
    jg No_DibujarObstaculo4
    
    mov dl, obsX4
    mov dh, obsY4
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 04h          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret
    
No_DibujarObstaculo4:
    ret

BorrarObstaculo4:
    cmp obsX4, 0
    jl No_BorrarObstaculo4
    cmp obsX4, 79
    jg No_BorrarObstaculo4
    
    mov dl, obsX4
    mov dh, obsY4
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo4:
    ret
    
DibujarObstaculo5:
    cmp obsX5, 0
    jl No_DibujarObstaculo5
    cmp obsX5, 79
    jg No_DibujarObstaculo5
    
    mov dl, obsX5
    mov dh, obsY5
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 05h          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo5:
    ret
    
BorrarObstaculo5:
    cmp obsX5, 0
    jl No_BorrarObstaculo5
    cmp obsX5, 79
    jg No_BorrarObstaculo5
    
    mov dl, obsX5
    mov dh, obsY5
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo5:
    ret
    
DibujarObstaculo6:
    cmp obsX6, 0
    jl No_DibujarObstaculo6
    cmp obsX6, 79
    jg No_DibujarObstaculo6
    
    mov dl, obsX6
    mov dh, obsY6
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 06h          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo6:
    ret
    
BorrarObstaculo6:
    cmp obsX6, 0
    jl No_BorrarObstaculo6
    cmp obsX6, 79
    jg No_BorrarObstaculo6
    
    mov dl, obsX6
    mov dh, obsY6
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo6:
    ret
    
DibujarObstaculo7:
    cmp obsX7, 0
    jl No_DibujarObstaculo7
    cmp obsX7, 79
    jg No_DibujarObstaculo7
    
    mov dl, obsX7
    mov dh, obsY7
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 07h          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo7:
    ret
    
BorrarObstaculo7:
    cmp obsX7, 0
    jl No_BorrarObstaculo7
    cmp obsX7, 79
    jg No_BorrarObstaculo7
    
    mov dl, obsX7
    mov dh, obsY7
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo7:
    ret
    
DibujarObstaculo8:
    cmp obsX8, 0
    jl No_DibujarObstaculo8
    cmp obsX8, 79
    jg No_DibujarObstaculo8
    
    mov dl, obsX8
    mov dh, obsY8
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 08h          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo8:
    ret
    
BorrarObstaculo8:
    cmp obsX8, 0
    jl No_BorrarObstaculo8
    cmp obsX8, 79
    jg No_BorrarObstaculo8
    
    mov dl, obsX8
    mov dh, obsY8
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo8:
    ret
    
DibujarObstaculo9:
    cmp obsX9, 0
    jl No_DibujarObstaculo9
    cmp obsX9, 79
    jg No_DibujarObstaculo9
    
    mov dl, obsX9
    mov dh, obsY9
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 09h          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo9:
    ret
    
BorrarObstaculo9:
    cmp obsX9, 0
    jl No_BorrarObstaculo9
    cmp obsX9, 79
    jg No_BorrarObstaculo9
    
    mov dl, obsX9
    mov dh, obsY9
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo9:
    ret
    
DibujarObstaculo10:
    cmp obsX10, 0
    jl No_DibujarObstaculo10
    cmp obsX10, 79
    jg No_DibujarObstaculo10
    
    mov dl, obsX10
    mov dh, obsY10
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 0Ah          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret
No_DibujarObstaculo10:
    ret
    
BorrarObstaculo10:
    cmp obsX10, 0
    jl No_BorrarObstaculo10
    cmp obsX10, 79
    jg No_BorrarObstaculo10
    
    mov dl, obsX10
    mov dh, obsY10
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo10:
    ret

DibujarObstaculo11:
    cmp obsX11, 0
    jl No_DibujarObstaculo11
    cmp obsX11, 79
    jg No_DibujarObstaculo11
    
    mov dl, obsX11
    mov dh, obsY11
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 0Bh          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo11:
    ret
    
BorrarObstaculo11:
    cmp obsX11, 0
    jl No_BorrarObstaculo11
    cmp obsX11, 79
    jg No_BorrarObstaculo11
    
    mov dl, obsX11
    mov dh, obsY11
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo11:
    ret
    
DibujarObstaculo12:
    cmp obsX12, 0
    jl No_DibujarObstaculo12
    cmp obsX12, 79
    jg No_DibujarObstaculo12
    
    mov dl, obsX12
    mov dh, obsY12
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar car?cter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 0Ch          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo12:
    ret
    
BorrarObstaculo12:
    cmp obsX12, 0
    jl No_BorrarObstaculo12
    cmp obsX12, 79
    jg No_BorrarObstaculo12
    
    mov dl, obsX12
    mov dh, obsY12
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo12:
    ret
    
DibujarObstaculo13:
    cmp obsX13, 0
    jl No_DibujarObstaculo13
    cmp obsX13, 79
    jg No_DibujarObstaculo13
    
    mov dl, obsX13
    mov dh, obsY13
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 0Dh          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo13:
    ret
    
BorrarObstaculo13:
    cmp obsX13, 0
    jl No_BorrarObstaculo13
    cmp obsX13, 79
    jg No_BorrarObstaculo13
    
    mov dl, obsX13
    mov dh, obsY13
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo13:
    ret
 
DibujarObstaculo14:
    cmp obsX14, 0
    jl No_DibujarObstaculo14
    cmp obsX14, 79
    jg No_DibujarObstaculo14
    
    mov dl, obsX14
    mov dh, obsY14
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funci?n para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 0Eh          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo14:
    ret
    
BorrarObstaculo14:
    cmp obsX14, 0
    jl No_BorrarObstaculo14
    cmp obsX14, 79
    jg No_BorrarObstaculo14
    
    mov dl, obsX14
    mov dh, obsY14
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo14:
    ret

DibujarObstaculo15:
    cmp obsX15, 0
    jl No_DibujarObstaculo15
    cmp obsX15, 79
    jg No_DibujarObstaculo15
    
    mov dl, obsX15
    mov dh, obsY15
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 0Fh          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo15:
    ret
    
BorrarObstaculo15:
    cmp obsX15, 0
    jl No_BorrarObstaculo15
    cmp obsX15, 79
    jg No_BorrarObstaculo15
    
    mov dl, obsX15
    mov dh, obsY15
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo15:
    ret
    
DibujarObstaculo16:
    cmp obsX16, 0
    jl No_DibujarObstaculo16
    cmp obsX16, 79
    jg No_DibujarObstaculo16
    
    mov dl, obsX16
    mov dh, obsY16
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 01h          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo16:
    ret
    
BorrarObstaculo16:
    cmp obsX16, 0
    jl No_BorrarObstaculo16
    cmp obsX16, 79
    jg No_BorrarObstaculo16
    
    mov dl, obsX16
    mov dh, obsY16
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo16:
    ret

DibujarObstaculo17:
    cmp obsX17, 0
    jl No_DibujarObstaculo17
    cmp obsX17, 79
    jg No_DibujarObstaculo17
    
    mov dl, obsX17
    mov dh, obsY17
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 02h          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo17:
    ret
    
BorrarObstaculo17:
    cmp obsX17, 0
    jl No_BorrarObstaculo17
    cmp obsX17, 79
    jg No_BorrarObstaculo17
    
    mov dl, obsX17
    mov dh, obsY17
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo17:
    ret

DibujarObstaculo18:
    cmp obsX18, 0
    jl No_DibujarObstaculo18
    cmp obsX18, 79
    jg No_DibujarObstaculo18
    
    mov dl, obsX18
    mov dh, obsY18
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 03h          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo18:
    ret
    
BorrarObstaculo18:
    cmp obsX18, 0
    jl No_BorrarObstaculo18
    cmp obsX18, 79
    jg No_BorrarObstaculo18
    
    mov dl, obsX18
    mov dh, obsY18
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo18:
    ret    

DibujarObstaculo19:
    cmp obsX19, 0
    jl No_DibujarObstaculo19
    cmp obsX19, 79
    jg No_DibujarObstaculo19
    
    mov dl, obsX19
    mov dh, obsY19
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 04h          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo19:
    ret
    
BorrarObstaculo19:
    cmp obsX19, 0
    jl No_BorrarObstaculo19
    cmp obsX19, 79
    jg No_BorrarObstaculo19
    
    mov dl, obsX19
    mov dh, obsY19
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo19:
    ret
    
DibujarObstaculo20:
    cmp obsX20, 0
    jl No_DibujarObstaculo20
    cmp obsX20, 79
    jg No_DibujarObstaculo20
    
    mov dl, obsX20
    mov dh, obsY20
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 05h          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo20:
    ret
    
BorrarObstaculo20:
    cmp obsX20, 0
    jl No_BorrarObstaculo20
    cmp obsX20, 79
    jg No_BorrarObstaculo20
    
    mov dl, obsX20
    mov dh, obsY20
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo20:
    ret

DibujarObstaculo21:
    cmp obsX21, 0
    jl No_DibujarObstaculo21
    cmp obsX21, 79
    jg No_DibujarObstaculo21
    
    mov dl, obsX21
    mov dh, obsY21
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 06h          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret
No_DibujarObstaculo21:
    ret
    
BorrarObstaculo21:
    cmp obsX21, 0
    jl No_BorrarObstaculo21
    cmp obsX21, 79
    jg No_BorrarObstaculo21
    
    mov dl, obsX21
    mov dh, obsY21
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo21:
    ret
    
DibujarObstaculo22:
    cmp obsX22, 0
    jl No_DibujarObstaculo22
    cmp obsX22, 79
    jg No_DibujarObstaculo22
    
    mov dl, obsX22
    mov dh, obsY22
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 07h          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo22:
    ret
    
BorrarObstaculo22:
    cmp obsX22, 0
    jl No_BorrarObstaculo22
    cmp obsX22, 79
    jg No_BorrarObstaculo22
    
    mov dl, obsX22
    mov dh, obsY22
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo22:
    ret
    
DibujarObstaculo23:
    cmp obsX23, 0
    jl No_DibujarObstaculo23
    cmp obsX23, 79
    jg No_DibujarObstaculo23
    
    mov dl, obsX23
    mov dh, obsY23
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 09h          ; funcion para mostrar caracter con atributo
    mov al, chrObs       ; caracter a imprimir (por ejemplo '|')
    mov bh, 0            ; pagina de video
    mov bl, 08h          ; atributo de color (0Fh = blanco brillante sobre negro)
    mov cx, 1            ; imprimir solo una vez
    int 10h
    ret

No_DibujarObstaculo23:
    ret
    
BorrarObstaculo23:
    cmp obsX23, 0
    jl No_BorrarObstaculo23
    cmp obsX23, 79
    jg No_BorrarObstaculo23
    
    mov dl, obsX23
    mov dh, obsY23
    mov ah, 02h
    mov bh, 0
    int 10h
    mov ah, 0Eh
    mov al, ' '
    int 10h
    ret
    
No_BorrarObstaculo23:
    ret

Espera: ; Espera simple para frenar la velocidad 
    mov cx, velocidadActual
espera_loop:
    nop
    loop espera_loop
    ret
    
DetectarColisionX:
    mov al, playerX
    cmp al, obsX
    jne Fin
    mov al, playerY
    cmp al, obsY
    jne Fin
    call Game_Over
    
Fin:
    ret
   
;Detectar las colisiones del player con algun obstaculo comparando las coordenadas de ambos
DetectarColisionX1:
    mov al, playerX
    cmp al, obsX1
    jne Fin
    mov al, playerY
    cmp al, obsY1
    jne Fin
    call Game_Over
    
DetectarColisionX2:
    mov al, playerX
    cmp al, obsX2
    jne Fin
    mov al, playerY
    cmp al, obsY2
    jne Fin
    call Game_Over
    
DetectarColisionX3:
    mov al, playerX
    cmp al, obsX3
    jne Fin
    mov al, playerY
    cmp al, obsY3
    jne Fin
    call Game_Over
    
DetectarColisionX4:
    mov al, playerX
    cmp al, obsX4
    jne Fin
    mov al, playerY
    cmp al, obsY4
    jne Fin
    call Game_Over

DetectarColisionX5:
    mov al, playerX
    cmp al, obsX5
    jne Fin
    mov al, playerY
    cmp al, obsY5
    jne Fin
    call Game_Over

DetectarColisionX6:
    mov al, playerX
    cmp al, obsX6
    jne Fin
    mov al, playerY
    cmp al, obsY6
    jne Fin
    call Game_Over
    
DetectarColisionX7:
    mov al, playerX
    cmp al, obsX7
    jne Fin1
    mov al, playerY
    cmp al, obsY7
    jne Fin1
    call Game_Over

DetectarColisionX8:
    mov al, playerX
    cmp al, obsX8
    jne Fin1
    mov al, playerY
    cmp al, obsY8
    jne Fin1
    call Game_Over
    
DetectarColisionX9:
    mov al, playerX
    cmp al, obsX9
    jne Fin1
    mov al, playerY
    cmp al, obsY9
    jne Fin1
    call Game_Over
    
    
Fin1: 
    ret
    
DetectarColisionX10:
    mov al, playerX
    cmp al, obsX10
    jne Fin1
    mov al, playerY
    cmp al, obsY10
    jne Fin1
    call Game_Over
    
DetectarColisionX11:
    mov al, playerX
    cmp al, obsX11
    jne Fin1
    mov al, playerY
    cmp al, obsY11
    jne Fin1
    call Game_Over
    
DetectarColisionX12:
    mov al, playerX
    cmp al, obsX12
    jne Fin1
    mov al, playerY
    cmp al, obsY12
    jne Fin1
    call Game_Over
    
DetectarColisionX13:
    mov al, playerX
    cmp al, obsX13
    jne Fin1
    mov al, playerY
    cmp al, obsY13
    jne Fin1
    call Game_Over
    
DetectarColisionX14:
    mov al, playerX
    cmp al, obsX14
    jne Fin1
    mov al, playerY
    cmp al, obsY14
    jne Fin1
    call Game_Over
    
DetectarColisionX15:
    mov al, playerX
    cmp al, obsX15
    jne Fin1
    mov al, playerY
    cmp al, obsY15
    jne Fin1
    call Game_Over
    
Fin2:
    ret
    
DetectarColisionX16:
    mov al, playerX
    cmp al, obsX16
    jne Fin2
    mov al, playerY
    cmp al, obsY16
    jne Fin2
    call Game_Over
    
DetectarColisionX17:
    mov al, playerX
    cmp al, obsX17
    jne Fin2
    mov al, playerY
    cmp al, obsY17
    jne Fin2
    call Game_Over

DetectarColisionX18:
    mov al, playerX
    cmp al, obsX18
    jne Fin2
    mov al, playerY
    cmp al, obsY18
    jne Fin2
    call Game_Over
    
DetectarColisionX19:
    mov al, playerX
    cmp al, obsX19
    jne Fin2
    mov al, playerY
    cmp al, obsY19
    jne Fin2
    call Game_Over
    
DetectarColisionX20:
    mov al, playerX
    cmp al, obsX20
    jne Fin2
    mov al, playerY
    cmp al, obsY20
    jne Fin2
    call Game_Over
    
DetectarColisionX21:
    mov al, playerX
    cmp al, obsX21
    jne Fin2
    mov al, playerY
    cmp al, obsY21
    jne Fin2
    call Game_Over
    
Fin3:
    ret
    
DetectarColisionX22:
    mov al, playerX
    cmp al, obsX22
    jne Fin3
    mov al, playerY
    cmp al, obsY22
    jne Fin3
    call Game_Over

DetectarColisionX23:
    mov al, playerX
    cmp al, obsX23
    jne Fin3
    mov al, playerY
    cmp al, obsY23
    jne Fin3
    call Game_Over
    
Game_Over: 
    call beep
    ; Limpiar pantalla
    mov ah, 0 ; Funcion BIOS modo de video
    mov al, 3 ; Modo texto 80x25
    int 10h ; Interrupcion de video
    
    ; Comparar y actualizar highScore
    mov ax, score
    cmp ax, highScore
    jbe no_update_highscore    
    mov highScore, ax
    
no_update_highscore:

    ; Posicionar cursor para GAME OVER
    mov ah, 02h ; Posicionar cursor
    mov bh, 0 ; Pagina de video 0
    mov dh, 10       ; Fila 10
    mov dl, 35       ; Columna 35
    int 10h ; Mover cursor
    
    ; Mostrar GAME OVER
    mov dx, offset gameOver
    mov ah, 9        
    int 21h

    ; Posicionar cursor para Score final:
    mov ah, 02h
    mov bh, 0
    mov dh, 12       ; Fila 12
    mov dl, 34       ; Columna 34
    int 10h
    
    ; Mostrar Score final:
    mov dx, offset scoreText
    mov ah, 9 ; Imprimir cadena
    int 21h ; Mostrar

    ; Convertir y mostrar el score final
    call ConvertirScoreATexto
    mov dx, offset scoreBuffer  
    mov ah, 9 ; Imprimir cadena
    int 21h ; Mostrar
    
    ; Posicionar cursor para HighScore
    mov ah, 02h
    mov bh, 0
    mov dh, 14       ; Fila 14
    mov dl, 32       ; Columna 32
    int 10h

    ; Mostrar HighScore
    mov dx, offset highScoreText
    mov ah, 9
    int 21h

    call ConvertirHighScoreATexto
    mov dx, offset highScoreBuffer
    mov ah, 9
    int 21h
    
    mov ah, 09h
    lea dx, saltoLinea
    int 21h
    
    mov ah, 09h
    lea dx, saltoLinea
    int 21h
    
    mov dx, offset volverEmpezar
    mov ah, 9
    int 21h
    
    mov ah, 09h
    lea dx, saltoLinea
    int 21h
    
    mov dx, offset salir
    mov ah, 9
    int 21h
    
EsperarEnterEscape:
    mov ah, 0          ; Esperar a que se presione una tecla
    int 16h            ; AL = ASCII, AH = scan code
    cmp al, 13         ; ENTER
    je VolveraEmpezar
    cmp al, 27         ; ESC
    je SalirPrograma
    jmp EsperarEnterEscape ; Si se presiona otra tecla, volver a esperar

VolveraEmpezar:
    mov dx, offset volverEmpezar
    mov ah, 9
    int 21h
    mov ah, 0
    mov al, 3
    int 10h
    jmp start

SalirPrograma:
    ; Salir del programa
    mov ah, 4Ch ; Funcion DOS para terminar el programa
    mov al, 0 ; Exito en finalizacion
    int 21h ; Salir 

beep:
    ; Configurar PIT canal 2, modo 3 (square wave)
    mov al, 0B6h
    out 43h, al
    ; Frecuencia ? 3500 Hz ? divisor = 341 (1193180 / 3500)
    mov ax, 341
    out 42h, al            ; LSB
    mov al, ah
    out 42h, al            ; MSB
    ; Encender speaker (activar bits 0 y 1 del puerto 61h)
    in al, 61h
    or al, 03h
    out 61h, al
    ; Peque?a espera para que se escuche
    mov cx, 0FFFFh
esperar:
    nop
    loop esperar
    ; Apagar speaker (desactivar bits 0 y 1)
    in al, 61h
    and al, 0FCh
    out 61h, al
    ret    

ganador:
    ;Limpiar Pantalla
    mov ah, 0 
    mov al, 3 
    int 10h
    ;Comparamos el HighScore
    mov ax, score
    cmp ax, highScore
    jbe no_update_highscore1    
    mov highScore, ax
    
no_update_highscore1:
    ; Posicionar cursor para indicar que gano
    mov ah, 02h ; Posicionar cursor
    mov bh, 0 ; Pagina de video 0
    mov dh, 10       ; Fila 10
    mov dl, 32       ; Columna 35
    int 10h ; Mover cursor
    
    ; Mostrar Juego Completado
    mov dx, offset juegoCompletado
    mov ah, 9        
    int 21h

    ; Posicionar cursor para Score final:
    mov ah, 02h
    mov bh, 0
    mov dh, 12       ; Fila 12
    mov dl, 34       ; Columna 34
    int 10h
    
    ; Mostrar Score final:
    mov dx, offset scoreText
    mov ah, 9 ; Imprimir cadena
    int 21h ; Mostrar

    ; Convertir y mostrar el score final
    call ConvertirScoreATexto
    mov dx, offset scoreBuffer  
    mov ah, 9 ; Imprimir cadena
    int 21h ; Mostrar
    
    ; Posicionar cursor para HighScore
    mov ah, 02h
    mov bh, 0
    mov dh, 14       ; Fila 14
    mov dl, 32       ; Columna 32
    int 10h

    ; Mostrar HighScore
    mov dx, offset highScoreText
    mov ah, 9
    int 21h

    call ConvertirHighScoreATexto
    mov dx, offset highScoreBuffer
    mov ah, 9
    int 21h
    
    mov ah, 09h
    lea dx, saltoLinea
    int 21h
    
    mov ah, 09h
    lea dx, saltoLinea
    int 21h
    
    mov dx, offset volverEmpezar
    mov ah, 9
    int 21h
    
    mov ah, 09h
    lea dx, saltoLinea
    int 21h
    
    mov dx, offset salir
    mov ah, 9
    int 21h
    call EsperarEnterEscape

end start