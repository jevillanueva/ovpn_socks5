# Conectarse a una VPN y crear un tunel SSH mediante SOCKS5

Para configurar 
copiar al directorio el archivo .ovpn

En caso de necesitar password editar el archivo y adicionar  askpass /vpn/pass.txt al final del archivo .ovpn

```bash
askpass /vpn/pass.txt
```

el archivo pass.txt debe contener el password de la VPN

# Para conectarse a la VPN ejecutar el siguiente comando
```bash
ssh  -D 1080 -q -C -N vpnuser@localhost -p 10022
```

Para abrir un navegador con el proxy SOCKS5, se puede usar el siguiente comando desde CMD no powershell:

```bash
"C:\Program Files\Google\Chrome\Application\chrome.exe" --proxy-server="socks5://localhost:1080"
```

Recuerda que el puerto debe coincidir con el que se configuró en el contenedor SOCKS5.