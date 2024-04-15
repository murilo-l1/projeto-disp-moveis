<h1>Projeto Programação de dispositivos móveis </h1>
<h2>Introdução</h2>
<p>
    Esse projeto está sendo desenvolvido por Murilo Lusvarghi Garcia e Arthur Marcondes de Barros Rosisca para a disciplina AD35C - AS51 (Programação de dispositivos móveis), visando criar um controlador de despesas "Gerenciee" com uma U.I simples ao usuário com apresentaçãoes visuais dos dados castrados por ele.
</p>

<h2>Tecnologias utilizadas</h2>
<ul>
  <li>Flutter 3.19.5 com a versão 3.3.3 da linguagem Dart <a href="https://docs.flutter.dev/release/archive?tab=windows"</a></li>
  <li>fl_chart 0.67.0 para disposição de gráficos na tela <a href="https://pub.dev/packages/fl_chart"</a></li> 
</ul>

<h2>Desenvolvimento </h2>

<h3>Telas </h3>
<p>
    O projeto consiste de 4 principais telas: HomePage - com a possibilidade de inserção de uma nova despesa distribuída entre 4 categorias, assim como um gráfico de pizza que separa esses gastos percentualmente, 'HistoricalPage' - que armazena os gastos totais do usuário tal qual a disposição das despesas em um gráfico de barras referentes aos meses, 'UserPage' para alternar entre foto, nome, e-mail e senha cadastrados e a 'RegisterPage' que compreende o processo de registro de uma nova conta que vai utilizar o app.  
</p>

<h3>Funcionalidades em produção </h3>

<p>
    O app ainda não conta com a escala de manipulação de banco de dados por estar em fase embrionária, portanto ainda usa dados fictícios para representar os gastos por categoria, por mês e consequentemente o histórico das despesas de cada usuário. Também não contém ainda autenticação de usuário na etapa de registros para vincular seus dados à um e-mail e senha, de forma análoga ainda não tem a capacidade nativa de usar o ícone da câmera para tirar uma foto com o dispositivo móveis, ademais essas e posteriores funcionalidades serão implementadas em seu momento.
</p>


<h2> Como executar esse aplicativo ? </h2>

```
1. Certifique de ter uma máquina que compile aplicações Flutter e um emulador para testes, você pode seguir o tutorial abaixo caso não tenha:
https://fragrant-chanter-261.notion.site/Configura-o-do-Flutter-519beb36ba2a49b3876bb098af556c7a

2. **Clone o repositório:**

git clone https://github.com/murilo-l1/projeto-disp-moveis.git

3. **Atualize as depêndencias e possíveis erros de compatibilidade de sintaxe**

flutter pub get
dart fix --apply

4. **Execute a aplicação**

flutter run

```
