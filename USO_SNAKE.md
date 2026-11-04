# Uso de los Snake para RTM32

En esta carpeta hay dos versiones del juego. Cada archivo se ensambla y ejecuta por separado con las herramientas RTM32 (`rtm32-asm` y `rtm32`).

## `snake_16x10.rtm`

Implementa un tablero de 16 columnas por 10 filas. Usa `w`, `a`, `s` y `d` en minúscula para moverse. La comida aparece como `*`, el cuerpo como `o` y la cabeza como `@`. El número mostrado corresponde al largo de la serpiente. Al chocar, muestra el puntaje final y detiene el juego.

Desde una terminal ubicada en esta carpeta:

```sh
rtm32-asm snake_16x10.rtm -o snake_16x10.bin
rtm32 -d telnet -m 4K
```

Conecta una terminal serie al dispositivo UART anunciado por el simulador y otra al debugger Telnet, normalmente en el puerto `4444`. En el debugger, carga `snake_16x10.bin` y escribe `c` para ejecutarlo. La terminal serie muestra el tablero y recibe las teclas. Esta versión revisa el bit `0x02` del registro de estado UART.

## `snake_32x16.rtm`

Implementa un tablero de 32 columnas por 16 filas con las paredes dentro del tablero. Usa `w`, `a`, `s` y `d` para moverse, acepta mayúsculas y minúsculas, y no permite girar directamente en sentido opuesto. Al perder o completar las 420 celdas interiores, permite reiniciar con `r` o salir con `q`.

Necesita 64 KiB de memoria y una terminal de al menos 32 filas:

```sh
rtm32-asm snake_32x16.rtm -o snake_32x16.bin
rtm32 -d telnet -m 64K
```

Conecta la terminal serie al dispositivo UART anunciado por el simulador y otra terminal al debugger Telnet. Carga `snake_32x16.bin` en el debugger y escribe `c`. Esta versión revisa el bit `0x01` del registro de estado UART.
