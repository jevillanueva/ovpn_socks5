FROM dperson/openvpn-client

# Instalar OpenSSH
RUN apk update && apk add --no-cache openssh

# Crear usuario y establecer contraseña
RUN adduser -D -s /bin/sh vpnuser && echo "vpnuser:password123" | chpasswd

# Configurar SSH: permitir root login y autenticación por contraseña
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    echo "AllowTcpForwarding yes" >> /etc/ssh/sshd_config && \
    echo "GatewayPorts yes" >> /etc/ssh/sshd_config && \
    echo "PermitTunnel yes" >> /etc/ssh/sshd_config && \
    echo "PermitOpen any" >> /etc/ssh/sshd_config

# Generar claves SSH
RUN ssh-keygen -A

# Crear carpeta para SSH y establecer permisos
RUN mkdir -p /run/sshd && chmod 700 /run/sshd

# Exponer el puerto SSH
EXPOSE 22

# Ejecutar OpenVPN y SSH al iniciar el contenedor
CMD ["/sbin/tini", "--", "sh", "-c", "/usr/bin/openvpn.sh -d & /usr/sbin/sshd -D"]