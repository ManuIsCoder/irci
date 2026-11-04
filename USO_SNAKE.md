# Uso de los Snake para RTM32

En esta carpeta hay dos versiones del juego. Cada archivo se ensambla por separado con `rtm32.asm` y se ejecuta con el simulador RTM32.

## Ensamblar

Desde esta carpeta, compila los dos juegos con GNU Make:

```sh
chmod +x ../../rtm32/RTM32/x86_64-linux-musl-rtm32.asm
make ASM=../../rtm32/RTM32/x86_64-linux-musl-rtm32.asm
```

El comando anterior corresponde a Linux x86_64 y presupone que el ensamblador tiene permiso de ejecución. Si ya tienes `rtm32.asm` en el `PATH`, basta con ejecutar `make`. Para compilar solo uno, usa `make snake_16x10` o `make snake_32x16`, manteniendo el argumento `ASM` cuando corresponda.

También puedes ensamblar cada archivo manualmente:

```sh
rtm32.asm snake_16x10.rtm -o snake_16x10.bin
rtm32.asm snake_32x16.rtm -o snake_32x16.bin
```

El directorio externo `rtm32\RTM32` incluye binarios de ensamblador para Linux y macOS. El manual también documenta un binario para Windows x86_64, pero ese archivo no está incluido. En Windows necesitas conseguir una versión compatible del ensamblador y GNU Make; luego puedes pasar su ruta con `make "ASM=C:\ruta\rtm32.asm"`.

## `snake_16x10.rtm`

Implementa un tablero de 16 columnas por 10 filas. Usa `w`, `a`, `s` y `d` en minúscula para moverse. La comida aparece como `*`, el cuerpo como `o` y la cabeza como `@`. El número mostrado corresponde al largo de la serpiente. Al chocar, muestra el puntaje final y detiene el juego.

Para jugar, inicia el simulador RTM32 con 4 KiB de memoria usando `rtm32 -d telnet -m 4K`. Ese simulador no viene en la carpeta `rtm32\RTM32`; debe estar instalado por separado. Conecta una terminal serie al dispositivo UART anunciado por el simulador y otra al debugger Telnet, normalmente en el puerto `4444`. En el debugger, carga `snake_16x10.bin` y escribe `c` para ejecutarlo. La terminal serie muestra el tablero y recibe las teclas. Esta versión revisa el bit `0x02` del registro de estado UART.

## `snake_32x16.rtm`

Implementa un tablero de 32 columnas por 16 filas con las paredes dentro del tablero. Usa `w`, `a`, `s` y `d` para moverse, acepta mayúsculas y minúsculas, y no permite girar directamente en sentido opuesto. Al perder o completar las 420 celdas interiores, permite reiniciar con `r` o salir con `q`.

Necesita 64 KiB de memoria y una terminal de al menos 32 filas. Inicia el simulador con `rtm32 -d telnet -m 64K`. Conecta la terminal serie al dispositivo UART anunciado por el simulador y otra terminal al debugger Telnet. Carga `snake_32x16.bin` en el debugger y escribe `c`. Esta versión revisa el bit `0x01` del registro de estado UART.

## Notas de ejecución

- Los comandos de ensamblado y los destinos del Makefile verifican la sintaxis y generan un `.bin`; el simulador debe poder acceder a ese archivo.
- El ensamblador y el simulador son programas distintos. Tener el ensamblador permite producir los `.bin`, pero para jugar también necesitas instalar el simulador `rtm32`.
- Las dos versiones consultan bits UART distintos. Si el teclado no responde, verifica que el simulador use el bit de estado que espera el archivo elegido.
