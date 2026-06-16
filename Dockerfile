# Estágio de Build
FROM node:20-alpine AS build

WORKDIR /app

# Copia os arquivos de pacotes
COPY package*.json ./

# Instala ferramentas essenciais de compilação (evita erros de pacotes nativos/node-gyp)
RUN apk add --no-cache python3 make g++

# Instala as dependências do projeto
RUN npm install --verbose

# Copia o código fonte
COPY . .

# Cria a versão web
RUN npm run build:web

# Estágio de Produção
FROM nginx:alpine

# Instala o curl para o healthcheck
RUN apk add --no-cache curl

# Copia os arquivos buildados
COPY --from=build --chown=nginx:nginx /app/dist/web /usr/share/nginx/html

# Copia a configuração do nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expõe a porta interna
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Inicia o nginx
CMD ["nginx", "-g", "daemon off;"]
