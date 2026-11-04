# Uso de los Snake para RTM32

Esta carpeta contiene dos versiones independientes del juego. Para ensamblarlas se necesita `rtm32-asm`; para ejecutarlas, el simulador `rtm32`. Ambos comandos deben estar disponibles en el entorno desde el que se trabaje.

## `snake_16x10.rtm`

Versión con tablero de 16 columnas por 10 filas, borde cerrado y borrado ANSI de pantalla. La serpiente se mueve con `w`, `a`, `s` y `d` en minúscula. No se puede dar media vuelta directamente. La comida aparece como `*`, el cuerpo como `o` y la cabeza como `@`. El número mostrado como puntaje corresponde al largo de la serpiente. Al chocar, imprime el puntaje final y detiene el programa; no tiene opción para reiniciar.

En una terminal con las herramientas RTM32:

```sh
rtm32-asm snake_16x10.rtm -o snake_16x10.bin
rtm32 -d telnet -m 4K
```

Con el simulador abierto, conecta una terminal serie al dispositivo UART que indique el simulador y otra al debugger por Telnet, normalmente en el puerto `4444`. En el debugger, carga `snake_16x10.bin` y ejecuta `c`. Si el dispositivo UART no acepta las teclas, verifica que el simulador use el bit `0x02` del registro de estado para indicar que hay una tecla disponible.

## `snake_32x16.rtm`

Versión con tablero de 32 columnas por 16 filas y paredes dentro del tablero. Usa `w`, `a`, `s` y `d` para moverse; acepta mayúsculas y minúsculas. `q` sale del juego. Al perder o llenar las 420 celdas interiores, permite jugar otra vez con `r` o salir con `q`. El puntaje aumenta al comer.

Necesita una memoria de 64 KiB y una terminal de al menos 32 filas:

```sh
rtm32-asm snake_32x16.rtm -o snake_32x16.bin
rtm32 -d telnet -m 64K
```

Como en la otra versión, conecta una terminal serie al dispositivo UART que informe el simulador y otra al debugger Telnet, normalmente en el puerto `4444`. En el debugger, carga `snake_32x16.bin` y ejecuta `c`. Esta versión detecta teclas disponibles mediante el bit `0x01` del registro de estado UART.

## Ejecutar con el debugger y la UART

El flujo usual requiere tres terminales:

1. Iniciar el simulador con el comando correspondiente y anotar el dispositivo UART que informa.
2. Abrir ese dispositivo con un cliente serie, por ejemplo `picocom` en Linux.
3. Conectar al debugger con `telnet localhost 4444`, cargar el `.bin` generado y escribir `c`.

Las rutas de los `.bin` deben ser accesibles desde el debugger. La terminal serie muestra el tablero y recibe los controles; el debugger se usa para cargar y ejecutar el programa.

## Windows

Los comandos anteriores son para un entorno donde se puedan ejecutar las herramientas RTM32. El directorio `rtm32\RTM32` del proyecto contiene binarios del ensamblador para Linux y macOS, pero no una versión nativa de Windows. En Windows se necesita una versión compatible del ensamblador y del simulador, o un entorno Linux/macOS configurado para ejecutarlos. Una vez disponibles, abre la terminal desde esta carpeta `irci\rtm32` para usar los comandos tal como aparecen arriba.

## Diferencias de compatibilidad

Las versiones consultan bits distintos del registro de estado de la UART (`0x02` en `snake_16x10.rtm` y `0x01` en `snake_32x16.rtm`). Si el teclado no responde en una de ellas, comprueba la convención UART del simulador que estás usando. No son dos archivos intercambiables: cada `.rtm` se ensambla y ejecuta por separado.
