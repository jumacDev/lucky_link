# Etapa de construcción

# Entorno en debian
FROM debian:latest AS build-env

# Dependencias de flutter
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    unzip \
    libgconf-2-4 \
    gdb \
    libstdc++6 \
    libglu1-mesa \
    fonts-droid-fallback \
    lib32stdc++6 \
    python3 \
    sed \
    && apt-get clean

# Instalación de flutter
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

ENV PATH="${PATH}:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin"

# Revisión de flutter y actualización de la versión
RUN flutter doctor -v
RUN flutter channel master
RUN flutter upgrade

# Crear y trabajar en el directorio de la aplicación
RUN mkdir /app
COPY . /app
WORKDIR /app

# Construir app en modo web desde flutter
RUN flutter build web

# Etapa de publicación

# Utilizar nginx para servir la aplicación
FROM nginx:1.21.1-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Exponer el puerto 80
EXPOSE 80

# Comando por defecto para iniciar nginx
CMD ["nginx", "-g", "daemon off;"]
