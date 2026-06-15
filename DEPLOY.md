# Guia de Deploy - Painel SGA

## Visão Geral

Este documento descreve como fazer o deploy do Painel SGA usando Docker e Portainer.

## Pré-requisitos

- Docker e Docker Compose instalados
- Portainer configurado e rodando
- Acesso ao repositório Git
- Servidor Linux com Docker

## Deploy Local (Desenvolvimento)

### 1. Clonar o Repositório

```bash
git clone https://github.com/denilson-arguelho/painel-sga.git
cd painel-sga
```

### 2. Construir a Imagem Docker

```bash
docker build -t painel-web:latest .
```

### 3. Executar com Docker Compose

```bash
docker-compose up -d
```

A aplicação estará disponível em `http://localhost`

## Deploy via Portainer

### 1. Acessar Portainer

1. Abra seu navegador e acesse `http://seu-servidor:9000`
2. Faça login com suas credenciais

### 2. Adicionar Stack

1. Vá para **Stacks** no menu lateral
2. Clique em **Add Stack**
3. Escolha **Git repository** como source
4. Preencha os campos:
   - **Name**: `painel-sga`
   - **Repository URL**: `https://github.com/denilson-arguelho/painel-sga.git`
   - **Repository ref**: `main` (ou sua branch)
   - **Compose file path**: `docker-compose.yml`

### 3. Configurar Variáveis de Ambiente (Opcional)

Se necessário, adicione variáveis de ambiente:

1. Clique em **Environment variables**
2. Adicione as variáveis conforme necessário (veja `.env.example`)

### 4. Deploy

1. Clique em **Deploy the stack**
2. Aguarde o deploy completar
3. Verifique o status em **Containers**

## Configuração Pós-Deploy

### 1. Acessar a Aplicação

Acesse `http://seu-servidor` (ou a porta configurada)

### 2. Configurar Painel

1. Clique no ícone de engrenagem (⚙️) no canto superior esquerdo
2. Vá para a aba **Servidor**
3. Configure:
   - **URL do Servidor**: URL do seu NovoSGA
   - **Usuário**: Seu usuário
   - **Senha**: Sua senha
   - **Client ID**: ID do cliente OAuth
   - **Client Secret**: Secret do cliente OAuth

### 3. Selecionar Unidade

1. Vá para a aba **Serviços**
2. Selecione a unidade desejada
3. Escolha os serviços que deseja monitorar

### 4. Personalizar Layout

1. Vá para a aba **Interface**
2. Selecione o tema (Modern ou Default)
3. Customize as cores usando o color picker
4. Configure o logo e texto do rodapé
5. Clique em **Salvar**

## Temas Disponíveis

### Modern (Recomendado)

- Design limpo e moderno
- Layout responsivo
- Melhor visualização em telas grandes
- Color picker integrado

### Default

- Layout clássico
- Compatível com versões anteriores

## Gerenciamento via Portainer

### Atualizar Stack

1. Vá para **Stacks**
2. Selecione `painel-sga`
3. Clique em **Pull and redeploy**
4. Confirme a ação

### Visualizar Logs

1. Vá para **Containers**
2. Selecione `painel-sga-web`
3. Clique em **Logs**

### Reiniciar Serviço

1. Vá para **Containers**
2. Selecione `painel-sga-web`
3. Clique em **Restart**

### Remover Stack

1. Vá para **Stacks**
2. Selecione `painel-sga`
3. Clique em **Remove**
4. Confirme a ação

## Troubleshooting

### Container não inicia

1. Verifique os logs: `docker logs painel-sga-web`
2. Verifique se a porta 80 está disponível
3. Verifique se há espaço em disco

### Aplicação não carrega

1. Limpe o cache do navegador (Ctrl+Shift+Delete)
2. Verifique a conexão com o servidor NovoSGA
3. Verifique os logs do container

### Cores não salvam

1. Verifique se há espaço em disco
2. Verifique as permissões do container
3. Tente novamente após reiniciar

## Segurança

### Recomendações

1. Use HTTPS em produção (configure reverse proxy com SSL)
2. Restrinja acesso à porta do Portainer
3. Use senhas fortes para OAuth
4. Mantenha as imagens Docker atualizadas
5. Configure firewall adequadamente

### Exemplo com Nginx Reverse Proxy

```nginx
server {
    listen 443 ssl http2;
    server_name seu-dominio.com;

    ssl_certificate /caminho/para/certificado.crt;
    ssl_certificate_key /caminho/para/chave.key;

    location / {
        proxy_pass http://localhost;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## Performance

### Otimizações Implementadas

- Compressão Gzip habilitada
- Cache de assets estáticos (1 ano)
- Minificação de código
- Healthcheck configurado
- Multi-stage Docker build

### Monitoramento

1. Verifique uso de CPU e memória em **Containers**
2. Configure alertas no Portainer se necessário
3. Monitore logs regularmente

## Atualizações

### Atualizar para Nova Versão

1. Vá para **Stacks** no Portainer
2. Selecione `painel-sga`
3. Clique em **Pull and redeploy**
4. Aguarde o deploy completar

### Rollback

Se algo der errado após atualização:

1. Vá para **Containers**
2. Selecione `painel-sga-web`
3. Clique em **Restart**
4. Se necessário, remova a stack e reimplante uma versão anterior

## Suporte

Para problemas ou dúvidas:

1. Verifique a documentação do NovoSGA
2. Consulte os logs do container
3. Abra uma issue no repositório GitHub

## Changelog

### v2.1.0 - Modernização

- ✨ Novo layout moderno (Modern)
- 🎨 Color picker visual
- 🎯 Interface de configuração melhorada
- 📱 Design responsivo
- 🐳 Docker Stack para Portainer
- 🔒 Headers de segurança
- ⚡ Otimizações de performance

---

**Última atualização**: 2024
**Versão**: 2.1.0
