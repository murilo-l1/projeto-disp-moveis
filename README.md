<h1>Projeto Programação de dispositivos móveis </h1>
<h2>Introdução</h2>
<p>
    Esse projeto está sendo desenvolvido por Murilo Lusvarghi Garcia e Arthur Marcondes de Barros Rosisca para a disciplina AD35C - AS51 (Programação de dispositivos móveis), visando criar um controlador de despesas "Gerenciee" com uma U.I simples ao usuário com apresentaçãoes visuais dos dados castrados por ele.
</p>

<h2>Tecnologias utilizadas</h2>
<ul>
  <li>Flutter 3.19.5 com a versão 3.3.3 da linguagem Dart - https://docs.flutter.dev/release/archive?tab=windows</li>
  <li>fl_chart 0.67.0 para disposição de gráficos na tela  - https://pub.dev/packages/fl_chart</li>
</ul>

<h2>Desenvolvimento </h2>

<h3>Telas </h3>
<p>
    1. HomePage: permite a inserção de uma nova despesa distribuída entre 4 categorias, além de exibir um gráfico de pizza que separa esses gastos percentualmente.<br><br>
    2. HistoricalPage: armazena os gastos totais do usuário, assim como a disposição das despesas em um gráfico de barras referentes aos meses.<br><br>
    3. UserPage: permite alternar entre foto, nome, e-mail e senha cadastrados.<br><br>
    4. RegisterPage: compreende o processo de registro de uma nova conta no aplicativo.
</p>

<h3>Funcionalidades em produção </h3>

<p>
    O app ainda não conta com a escala de manipulação de banco de dados por estar em fase embrionária, portanto ainda usa dados fictícios para representar os gastos por categoria, por mês e consequentemente o histórico das despesas de cada usuário. Também não contém ainda autenticação de usuário na etapa de registros para vincular seus dados à um e-mail e senha, de forma análoga ainda não tem a capacidade nativa de usar o ícone da câmera para tirar uma foto com o dispositivo móveis, ademais essas e posteriores funcionalidades serão implementadas em seu momento.
</p>


<h2> Como executar esse aplicativo ? </h2>

Certifique de ter uma máquina que compile aplicações Flutter e um emulador para testes, caso não tenha você pode seguir esse [tutorial](https://fragrant-chanter-261.notion.site/Configura-o-do-Flutter-519beb36ba2a49b3876bb098af556c7a)

```
1. Clone o repositório:

git clone https://github.com/murilo-l1/projeto-disp-moveis.git

2. Atualize as depêndencias e possíveis erros de compatibilidade de sintaxe:

flutter pub get
dart fix --apply

3. Execute a aplicação

flutter run

```
