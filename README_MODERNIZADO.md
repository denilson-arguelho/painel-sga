# 🎨 Painel Web SGA - Versão Modernizada

> Painel web moderno e responsivo para o sistema [NovoSGA](http://novosga.org)

## ✨ O que há de novo na v2.1.0

### 🎯 Novo Layout Moderno

O novo layout **Modern** oferece uma experiência visual completamente renovada:

- **Cabeçalho Profissional**: Logo, título e data/hora em um cabeçalho elegante
- **Área Central Ampla**: Chamada de senha em destaque com tipografia grande
- **Sidebar Inteligente**: Histórico de chamadas e relógio em um painel lateral
- **Design Responsivo**: Adapta-se perfeitamente a diferentes tamanhos de tela
- **Animações Suaves**: Transições fluidas entre chamadas

### 🎨 Color Picker Visual

Customize as cores de forma intuitiva:

- **Paleta Predefinida**: 24 cores prontas para usar
- **Seletor Nativo**: Use o color picker do navegador
- **Histórico de Cores**: Acesso rápido às cores recentemente usadas
- **Validação em Tempo Real**: Veja as mudanças instantaneamente

### ⚙️ Interface de Configuração Redesenhada

Painel de configurações completamente modernizado:

- **Sidebar de Navegação**: Navegação intuitiva entre abas
- **Organização Visual**: Cores agrupadas por seção (Page, Featured, History, etc)
- **Preview em Tempo Real**: Veja as mudanças enquanto configura
- **Melhor UX**: Menos cliques, mais eficiência

### 🔊 Vocalização Aprimorada

Melhorias na síntese de fala:

- **Suporte Multilíngue**: Português, Inglês e Espanhol
- **Controle de Velocidade**: Ajuste a velocidade de fala
- **Múltiplas Vozes**: Escolha diferentes vozes do sistema
- **Testes Integrados**: Teste antes de usar em produção

### 🐳 Docker Stack para Portainer

Deploy simplificado em seu servidor Linux:

- **docker-compose.yml**: Stack pronto para Portainer
- **Dockerfile Otimizado**: Build multi-stage com Node 18
- **nginx.conf**: Configuração web otimizada
- **Healthcheck**: Monitoramento automático
- **Segurança**: Headers de segurança configurados

## 🚀 Como Usar

### Instalação Local

```bash
# Clonar repositório
git clone https://github.com/denilson-arguelho/painel-sga.git
cd painel-sga

# Instalar dependências
npm install

# Executar em desenvolvimento
npm run dev

# Build para produção
npm run build:web
```

### Deploy com Docker

```bash
# Build
docker build -t painel-web:latest .

# Executar
docker-compose up -d

# Acessar em http://localhost
```

### Deploy via Portainer

1. Acesse seu Portainer
2. Vá para **Stacks**
3. Clique em **Add Stack**
4. Selecione **Git repository**
5. Configure:
   - **Name**: painel-sga
   - **Repository URL**: https://github.com/denilson-arguelho/painel-sga.git
   - **Compose file path**: docker-compose.yml
6. Clique em **Deploy the stack**

Veja [DEPLOY.md](./DEPLOY.md) para instruções detalhadas.

## 🎨 Temas

### Modern (Novo - Recomendado)

```
┌─────────────────────────────────────────────┐
│  Logo    Título                    Data/Hora│
├─────────────────────────────────────────────┤
│                                             │
│          CHAMADA DE SENHA                   │ │
│                                             │ │ Sidebar
│          Senha: A 123                       │ │ com
│          Local: Mesa 5                      │ │ histórico
│                                             │ │ e relógio
│                                             │ │
└─────────────────────────────────────────────┘
```

### Default (Clássico)

```
┌─────────────────────────────────────────────┐
│                                             │
│          CHAMADA DE SENHA                   │ Histórico
│                                             │ e Relógio
│          Senha: A 123                       │
│          Local: Mesa 5                      │
│                                             │
├─────────────────────────────────────────────┤
│  Logo    Título                             │
└─────────────────────────────────────────────┘
```

## 🎯 Configuração

### Primeira Execução

1. Clique no ícone ⚙️ (engrenagem)
2. Configure o servidor NovoSGA
3. Insira credenciais OAuth
4. Selecione unidade e serviços
5. Customize cores e tema
6. Clique em **Salvar**

### Personalizar Cores

1. Vá para **Interface** → **Cores**
2. Para cada seção (Page, Featured, History, etc):
   - Clique no quadrado de cor
   - Escolha uma cor da paleta ou use o seletor
   - Veja a mudança em tempo real
3. Clique em **Salvar**

### Selecionar Tema

1. Vá para **Interface** → **Tema**
2. Escolha entre:
   - **Modern** (novo, recomendado)
   - **Default** (clássico)
3. Clique em **Salvar**

## 📊 Comparação de Versões

| Recurso | v2.0 | v2.1 (Novo) |
|---------|------|-----------|
| Layout Moderno | ❌ | ✅ |
| Color Picker | ❌ | ✅ |
| Interface Redesenhada | ❌ | ✅ |
| Docker Stack | ❌ | ✅ |
| Portainer Ready | ❌ | ✅ |
| Responsivo | ✅ | ✅✅ |
| Vocalização | ✅ | ✅✅ |
| Alertas Sonoros | ✅ | ✅ |
| Temas | ✅ | ✅✅ |

## 🔒 Segurança

- ✅ Headers de segurança (X-Frame-Options, X-Content-Type-Options, etc)
- ✅ Compressão Gzip habilitada
- ✅ Cache de assets estáticos
- ✅ Healthcheck automático
- ✅ Sem exposição de tokens

## ⚡ Performance

- ✅ Build multi-stage otimizado
- ✅ Node 18 Alpine (imagem menor)
- ✅ Nginx com compressão
- ✅ Cache agressivo de assets
- ✅ Minificação automática

## 📁 Arquivos Novos

```
painel-sga/
├── src/renderer/
│   ├── layouts/
│   │   └── novosga.modern.vue          # Novo layout moderno
│   ├── components/
│   │   └── ColorPicker.vue             # Novo color picker
│   └── pages/
│       └── SettingsModern.vue          # Nova página de settings
├── docker-compose.yml                   # Stack Docker
├── nginx.conf                           # Configuração Nginx
├── .dockerignore                        # Otimização Docker
├── .env.example                         # Variáveis de ambiente
├── DEPLOY.md                            # Guia de deploy
└── README_MODERNIZADO.md                # Este arquivo
```

## 🛠️ Desenvolvimento

### Estrutura de Componentes

```
ColorPicker.vue
├── Props
│   ├── value: String (cor hex)
│   └── label: String (rótulo)
├── Data
│   ├── showPicker: Boolean
│   ├── recentColors: Array
│   └── colorPresets: Array
└── Methods
    ├── togglePicker()
    ├── selectColor()
    └── updateColor()
```

### Novo Layout

```
novosga.modern.vue
├── Template
│   ├── Header (logo, título, data/hora)
│   ├── Featured Area (chamada de senha)
│   └── Sidebar (histórico + relógio)
├── Script
│   ├── Componentes (Clock, Featured, History)
│   ├── Data (messageQueue, isCalling)
│   └── Methods (call(), playAudio(), color())
└── Styles
    ├── Responsivo
    ├── Animações
    └── Temas
```

## 📚 Documentação

- [DEPLOY.md](./DEPLOY.md) - Guia completo de deploy com Portainer
- [README.md](./README.md) - Documentação original
- [NovoSGA](http://novosga.org) - Documentação do sistema base

## 🐛 Troubleshooting

### Cores não salvam

1. Verifique espaço em disco
2. Verifique permissões do container
3. Tente novamente após reiniciar

### Layout não aparece corretamente

1. Limpe cache do navegador (Ctrl+Shift+Delete)
2. Verifique se o tema está selecionado
3. Verifique console do navegador (F12)

### Container não inicia

1. Verifique logs: `docker logs painel-sga-web`
2. Verifique se porta 80 está disponível
3. Verifique espaço em disco

## 🤝 Contribuindo

Melhorias e sugestões são bem-vindas!

1. Faça fork do projeto
2. Crie uma branch (`git checkout -b feature/melhorias`)
3. Commit suas mudanças (`git commit -m 'Add melhorias'`)
4. Push (`git push origin feature/melhorias`)
5. Abra um Pull Request

## 📄 Licença

MIT License - veja [LICENSE](LICENSE)

## 👨‍💻 Autor Original

**Rogério Lino**
- Website: [rogeriolino.com](http://rogeriolino.com)
- Email: rogeriolino@gmail.com

## 🎉 Changelog v2.1.0

- ✨ Novo layout moderno (Modern)
- 🎨 Color picker visual com paleta e histórico
- 🎯 Interface de configuração completamente redesenhada
- 📱 Design responsivo melhorado
- 🐳 Docker Stack pronto para Portainer
- 🔒 Headers de segurança adicionados
- ⚡ Otimizações de performance (Node 18, multi-stage build)
- 📚 Documentação de deploy expandida
- 🔊 Melhorias na vocalização
- 🎨 Novo tema "Modern" como padrão

---

**Versão**: 2.1.0  
**Status**: ✅ Pronto para Produção  
**Última atualização**: 2024
