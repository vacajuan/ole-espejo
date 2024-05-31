server {
    listen 80;
    server_name ole-noticias.com;

    # Redirecciona todas las solicitudes HTTP a HTTPS
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name ole-noticias.com;
    
    ssl_certificate         /etc/ssl/cert.pem;
    ssl_certificate_key     /etc/ssl/private/key.pem;

    

    # Configuración para proxy_pass a tu aplicación en el puerto 3001
    location / {
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_pass http://localhost:3001;
        proxy_buffering off;
        proxy_request_buffering off;
    }
}
