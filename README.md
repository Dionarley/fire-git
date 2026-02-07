🔥 fire-git

A forma mais rápida e fácil de configurar o seu Git em qualquer distribuição Linux.

O fire-git é uma ferramenta de linha de comando (CLI) desenhada para automatizar a configuração inicial do Git (user.name e user.email). Seja numa instalação limpa ou num ambiente isolado, o fire-git garante que você esteja pronto para dar o seu primeiro commit em segundos.

✨ Funcionalidades
Configuração Automática: Define nome e email globalmente com um único script.

Suporte Flatpak: Funciona perfeitamente em ambientes sandbox (como o SteamOS ou Fedora Silverblue).

Agnóstico a Distros: Detecta automaticamente se precisa de instalar o Git ou se ele já está presente.


Licença MIT: Software livre e aberto para a comunidade.

📦 Instalação
Opção 1: Flatpak (Recomendado)
A forma mais segura e portátil. Você pode baixar o ficheiro .flatpak na nossa aba de Releases.

Bash
# Instalar o bundle
flatpak install --user fire-git.flatpak

# Executar
flatpak run com.github.dionarley.fire-git
Opção 2: Script Direto (Bash)
Se preferir rodar o script diretamente no seu terminal:

Bash
```bash
chmod +x firegit.sh;
./firegit.sh
```
🛠️ Como funciona o Flatpak?
O manifesto Flatpak deste projeto utiliza o runtime org.freedesktop.Platform para garantir leveza e compatibilidade. Ele possui permissão de acesso à pasta home para que possa modificar o ficheiro .gitconfig do seu utilizador real, mesmo estando dentro de uma sandbox.

📄 Licença
Este projeto está sob a licença MIT. Consulte o ficheiro LICENSE para mais detalhes.
