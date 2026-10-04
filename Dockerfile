FROM node:18

# Instalar FFmpeg, utilidades de red y Chromium (que instala automáticamente todas las librerías de Puppeteer)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    python3-pip \
    wget \
    curl \
    ca-certificates \
    chromium \
    && rm -rf /var/lib/apt/lists/*

# Configurar variables para que Puppeteer use el Chromium instalado en el sistema operativo
ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Instalar yt-dlp globalmente para el procesamiento de video
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp

# Directorio de trabajo
WORKDIR /app

# Copiar archivos de dependencias
COPY package*.json ./

# Instalar dependencias de Node.js
RUN npm install

# Copiar el resto del código del proyecto
COPY . .

# Puerto por defecto
ENV PORT=5555
EXPOSE 5555

# Comando de inicio
CMD ["npm", "run", "start"]
