<div  align="center">
<h1>📦 SysView - Instalação / Installation</h1>

<p align="center">
  <h3 align="center">🌍 Escolha o idioma / Choose your language</h3>
  <img src="img_demo/install.png" width="60%" />
</p>
</div>




<h3>🇧🇷 Instalação via Git  |  🇺🇸 Installation via Git</h3>

<p>Clone o repositório e execute o instalador  |  Clone the repository and run the installer:</p>

<pre>
<code>
git clone https://github.com/mar1nho/SysView.git
cd SysView
bash install.sh
</code>
</pre>

<p>Após a instalação, use o comando desejado  |  After installation, run your preferred version:</p>

<pre>
<code>
sysviewpt  # Versão em português
sysviewen  # English Version
</code>
</pre>


<h2 align="center">🧰 Tecnologias e Comandos Utilizados / Technologies and Commands Used</h2>

<h3 align="center">🔧 Comandos nativos do Linux / Native Linux Commands</h3>
<div  align="center">
<table>
  <thead>
    <tr>
      <th>Comando<br><small>Command</small></th>
      <th>Função (Português)</th>
      <th>Function (English)</th>
    </tr>
  </thead>
  <tbody>
    <tr><td><code>free</code></td><td>Exibe informações da memória RAM</td><td>Displays RAM usage info</td></tr>
    <tr><td><code>df</code></td><td>Mostra o uso de espaço em disco</td><td>Shows disk usage</td></tr>
    <tr><td><code>du</code></td><td>Calcula tamanho de diretórios</td><td>Calculates folder size</td></tr>
    <tr><td><code>ping</code></td><td>Testa a conexão com a internet</td><td>Tests internet connection</td></tr>
    <tr><td><code>grep</code>, <code>awk</code></td><td>Manipula e extrai dados</td><td>Extracts and processes text</td></tr>
    <tr><td><code>sort</code>, <code>head</code></td><td>Ordena e limita os resultados</td><td>Sorts and limits results</td></tr>
    <tr><td><code>gpg</code></td><td>Criptografa e descriptografa arquivos</td><td>Encrypts and decrypts files</td></tr>
    <tr><td><code>rm</code></td><td>Remove arquivos</td><td>Removes files</td></tr>
    <tr><td><code>read</code></td><td>Lê entrada do usuário</td><td>Reads user input</td></tr>
    <tr><td><code>chmod</code></td><td>Altera permissões de arquivos</td><td>Changes file permissions</td></tr>
    <tr><td><code>sync</code>, <code>tee</code></td><td>Limpa o cache da memória</td><td>Clears memory cache</td></tr>
  </tbody>
</table>

<h3>🌐 Dependências externas / External Dependencies</h3>

<table>
  <thead>
    <tr>
      <th>Ferramenta<br><small>Tool</small></th>
      <th>Uso (Português)</th>
      <th>Use (English)</th>
      <th>Instalação automática<br><small>Auto install</small></th>
    </tr>
  </thead>
  <tbody>
    <tr><td><code>speedtest-cli</code></td><td>Teste de velocidade da internet</td><td>Internet speed test</td><td>✅ Sim / Yes</td></tr>
    <tr><td><code>sudo</code></td><td>Necessário para funções administrativas</td><td>Required for elevated actions</td><td>✅ Sim / Yes</td></tr>
  </tbody>
</table>
</div>

<h4>💡 Observações / Notes</h4>
<ul>
  <li><code>speedtest-cli</code> será instalado automaticamente se não estiver presente.<br><i>It will be installed automatically if missing.</i></li>
  <li>Algumas funções requerem <code>sudo</code>.<br><i>Some actions require sudo access.</i></li>
  <li>O script é 100% offline, exceto quando faz testes ou instala dependências.<br><i>The script works offline except when testing internet or installing dependencies.</i></li>
</ul>


<p align="center">
  <img src="img_demo/pt.png" width="47%" />
  <img src="img_demo/en.png" width="47%" />
</p>

