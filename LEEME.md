# rEFInd-Chriskt78

Paquete de instalación de multiarranque para Windows de sistemas Retrogaming. (rEFInd)\

Basado en https://www.rodsbooks.com/refind \
Tema basado en https://github.com/PillTime/rEFInd-minimal-dark \

Empaquetado y personalizado por Christ78

1) Verificar si Windows utiliza el modo de arranque UEFI (ordenadores modernos) o BIOS (antiguo sistema):
- Pulsa Win+R
- Escribe ``msinfo32``, pulsa Enter
- En la parte derecha de la pantalla de "Información del sistema", busca "BIOS mode"
- Si el valor es UEFI, dirigiros hacia la sección de configuración UEFI (3).
- Si el valor es "herited", necesitas convertir la partición de arranque de vuestro disco duro de MRB al nuevo sistema GPT (2).

2) Cómo convertir tu disco duro de MRB a GPT:

- Localiza tu número de disco:
	- Click derecho en el botón de Windows
	- Selecciona/ejecuta el "Disk Manager"
	- Selecciona el disco duro que contiene Windows (C:) y toma nota de su número (más tarde en este tutorial deberás reemplazar `` <disknumber>``  por tu número)
- Convierte el disco MBR a GPT :
	- Haz click en el botón de Windows
	- Escribe ``cmd``
	- Click derecho, selecciona "ejecutar como administrator"
	- Escribe ``mbr2gpt /validate /disk:<disknumber> /allowFullOS`` y pulsa Enter
	- Si no se produce ningún error, escribe ``mbr2gpt convert /disk:<disknumber> /allowFullOS`` y pulsa Enter. Debes reemplazar ``<disknumber>`` por tu número de disco obtenido anteriormente.

3) Configurar UEFI:
- Asegúrate que el "BIOS mode" está puesto en "UEFI"
- Desactiva "Secure Boot"
- Desactiva "Compatibility Support Module (CSM)". Es una opción que permite arrancar usando el antiguo método si el arranque UEFI falla. Se puede llamar diferente dependiendo de vuestro ordenador.

4) Installa la aplicación rEFInd-Chriskt78 :
- Descomprime el zip
- Para instalar, click derecho sobre ``install.bat`` para "ejecutarlo como administrador".
- En la ventana que se abrirá, verifica que no hay mensajes de error y que los ficheros copiados no son 0.
- Reinicia el ordenador y comprueba que rEFIind se ejecuta correctamente y que es capaz de lanzar Windows igual que Recalbox o cualquier otro sistema de retrogaming que tengas instalado. Puedes utilizar las fechas del teclado (izquierda/derecha/arriba/abajo) para seleccionar, junto con el ratón o la patalla tácil de vuestro ordenador (atención: el touchpad no funciona).

5) Para desinstalar rEFInd-Chriskt78:
- Descomprimir el zip
- Click derecho sobre ``uninstall.bat`` para "ejecutarlo como administrador".
- Verifica los posibles mensajes de error
- Reinicia y comprueba que arrancas directamente en Windows.