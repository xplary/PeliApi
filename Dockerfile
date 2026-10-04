FROM node:18-bullseye

# Instalar dependencias del sistema requeridas por Puppeteer (Chromium), FFmpeg y utilidades de red
RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    python3-pip \
    wget \
    curl \
    ca-certificates \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgbm1 \
    libgcc1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    lsb-release \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# Instalar yt-dlp globalmente para el respaldo de extracción de video
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp

# Directorio de trabajo en el contenedor
WORKDIR /app

# Copilar dependencias de Node
COPY package*.json ./

# Instalar dependencias del proyecto (incluyendo puppeteer)
RUN npm install

# Copiar el resto del código fuente
COPY . .

# Render asigna un puerto dinámico, pero por defecto usaremos el 5555
ENV PORT=5555
EXPOSE 5555

# Comando para iniciar el servidor
CMD ["npm", "run", "start"]
