# Trabalho Prático | DGT2812 - Desenvolvimento de Aplicativos Móveis com Flutter

Repositório oficial destinado à entrega das **Microatividades (1 a 5)** e do **Trabalho Prático Final** da disciplina **DGT2812 - Desenvolvimento de Aplicativos Móveis com Flutter**, integrante do curso de graduação tecnológica em **Desenvolvimento Full Stack** da **Universidade Estácio de Sá**.

* **Discente:** Ivan de Avila C. F. Mortimer
* **Aplicativo Principal:** Agência de Viagens **"Explore Mundo"** (`lib/main.dart`)
* **Documentação Técnica:** [`Documentacao_Trabalho_Pratico.pdf`](./Documentacao_Trabalho_Pratico.pdf)

---

## 💻 Ambiente de Desenvolvimento Validado

* **Sistema Operacional:** Windows 11 Home 64-bit (Version `23H2` | OS Build `22631.6199`)
* **Hardware:** Lenovo Yoga 710-14IKB (Model `80V4`)
* **Flutter SDK:** `3.47.9` (Canal *Stable*)
* **Dart SDK:** `3.13.7` (com *Sound Null Safety*) | **DevTools:** `2.60.0`
* **Android Toolchain:** Android SDK `37.0.0` • Android Studio Panda 4 (`Medium Phone API 37.0`)
* **Desktop & Web:** Visual Studio Community 2026 (`18.7.2`) • Google Chrome • Microsoft Edge
* **IDE & Terminal:** Visual Studio Code + PowerShell `7.6.9`
* **Controle de Versão:** Git for Windows `2.56.0.windows.4`

---

## 📁 Estrutura de Diretórios e Arquitetura (MVC + Microatividades Isoladas)

Cada microatividade preparatória foi isolada em `lib/microatividades/` com sua própria função `void main()`, permitindo execução independente via flag `-t`. O aplicativo principal (**"Explore Mundo"**) segue o padrão arquitetural **MVC (Model-View-Controller)**, com persistência local via `shared_preferences` + JSON e testes automatizados de widgets.

```text
trabalho_pratico_dgt2812/
├── assets/
│   └── images/
│       ├── ai_generated_mia.jpg          # Avatar circular utilizado na Microatividade 5 (Stack)
│       ├── lake.jpg                      # Destino principal: Oeschinen Lake Campground
│       ├── chapada.jpg                   # Destino do catálogo: Parque Nacional da Chapada Diamantina
│       ├── patagonia.jpg                 # Destino do catálogo: Torres del Paine National Park
│       └── kyoto.jpg                     # Destino do catálogo: Distrito Histórico de Kyoto
├── lib/
│   ├── microatividades/
│   │   ├── microatividade_1.dart         # Microatividade 1: Diagnóstico interativo do ambiente Flutter
│   │   ├── microatividade_2.dart         # Microatividade 2: Widgets básicos (MaterialApp, Scaffold, AppBar)
│   │   ├── microatividade_3.dart         # Microatividade 3: Layouts básicos (Row, Column, Icon, Text)
│   │   ├── microatividade_4.dart         # Microatividade 4: Listas estruturadas (ListView e ListTile)
│   │   └── microatividade_5.dart         # Microatividade 5: Sobreposição de widgets (Stack e Container)
│   ├── models/
│   │   └── explore_models.dart           # Model: Destino, PacoteViagem, Avaliacao, Reserva + toJson/fromJson
│   ├── controllers/
│   │   └── explore_controller.dart       # Controller: ChangeNotifier + persistência local (SharedPreferences)
│   ├── views/
│   │   ├── destino_detalhe_view.dart     # View: Tela base oficial (roteiro) + pacotes e avaliações
│   │   ├── destinos_view.dart            # View: Catálogo pesquisável de destinos e filtro de favoritos
│   │   ├── reservas_view.dart            # View: Consulta e cancelamento de reservas confirmadas
│   │   └── contato_view.dart             # View: Canais institucionais e formulário validado de contato
│   └── main.dart                         # Ponto de entrada: ExploreMundoApp, Drawer e BottomNavigationBar
├── test/
│   └── widget_test.dart                  # Teste automatizado de widgets e persistência (Tema 5)
├── pubspec.yaml                          # Dependências (cupertino_icons, shared_preferences) e assets
├── Documentacao_Trabalho_Pratico.pdf     # Relatório técnico completo da prática (PDF)
└── README.md                             # Guia de arquitetura, validação e execução do projeto
```

---

## 🚀 Como Executar e Validar o Projeto

### 1. Pré-requisitos, Dependências e Qualidade

1. Valide a configuração do ambiente executando `flutter doctor`.
2. Clone este repositório (ou abra a pasta `trabalho_pratico_dgt2812` no VS Code) e instale as dependências:

```powershell
flutter pub get
```

3. Execute a análise estática (Dart Linter) e os testes automatizados de widgets:

```powershell
flutter analyze
flutter test
```

### 2. Executando o Trabalho Prático Final (App "Explore Mundo")

Para iniciar a aplicação principal localizada em `lib/main.dart`, execute na raiz do projeto:

```powershell
flutter run
```

Para escolher explicitamente a plataforma-alvo:

```powershell
flutter run -d windows   # Aplicativo nativo Windows Desktop
flutter run -d chrome    # Execução Web no Google Chrome
```

### 3. Executando Cada Microatividade Isoladamente (`-t` / `--target`)

Cada microatividade pode ser executada diretamente sem modificar `lib/main.dart`:

* **Microatividade 1 (Preparação e Diagnóstico do Ambiente):**
  ```powershell
  flutter run -t lib/microatividades/microatividade_1.dart
  ```
* **Microatividade 2 (Widgets Básicos — `MaterialApp`, `Scaffold` e `AppBar`):**
  ```powershell
  flutter run -t lib/microatividades/microatividade_2.dart
  ```
* **Microatividade 3 (Layouts Básicos — `Row`, `Column`, `Icon` e `Text`):**
  ```powershell
  flutter run -t lib/microatividades/microatividade_3.dart
  ```
* **Microatividade 4 (Listas — `ListView`, `Card` e `ListTile`):**
  ```powershell
  flutter run -t lib/microatividades/microatividade_4.dart
  ```
* **Microatividade 5 (Sobreposição — `Stack`, `Container` e `ClipOval`):**
  ```powershell
  flutter run -t lib/microatividades/microatividade_5.dart
  ```

---

## 🎯 Funcionalidades Implementadas no Aplicativo "Explore Mundo"

* **Tela Principal de Destaque (Conformidade Integral com o Roteiro Oficial):**
  * Corpo principal estruturado em `ListView` para rolagem responsiva em telas móveis, tablets e desktop.
  * Banner de imagem (`assets/images/lake.jpg`) com `BoxFit.cover` e tratamento preventivo via `errorBuilder`.
  * `titleSection` (*Oeschinen Lake Campground*, *Kandersteg, Switzerland*) com estrela interativa de favoritos (`41` ↔ `40`).
  * `buttonSection` (`CALL`, `ROUTE`, `SHARE`) gerada por `_buildButtonColumn`, com diálogos interativos de central de atendimento, rotas/coordenadas GPS e feedback via `SnackBar`.
  * `textSection` com espaçamento uniforme e `softWrap: true`.
* **Recursos Interativos da Agência "Explore Mundo":**
  * **Navegação Híbrida (Tema 2):** `BottomNavigationBar` (com `IndexedStack` e `Badge` dinâmico de reservas), menu lateral (`Drawer`) e navegação por rotas (`Navigator.push`).
  * **Catálogo Pesquisável:** Quatro destinos cadastrados (Suíça, Chapada Diamantina, Patagônia e Kyoto) com busca em tempo real e filtro por favoritos.
  * **Pacotes, Reservas e Avaliações:** Formulários validados (`Form`/`TextFormField`) para reservar pacotes com cálculo automático por viajante, cancelar reservas e publicar comentários com nota em estrelas.
  * **Persistência Local Multiplataforma (Tema 3):** Armazenamento automático de favoritos, avaliações e reservas em formato JSON utilizando `shared_preferences`, preservando o estado entre reinicializações no Android, Windows e Web.
  * **Arquitetura MVC e Testes (Tema 5):** Separação clara entre `models`, `controllers` (`ChangeNotifier`) e `views`, acompanhada de teste automatizado em `test/widget_test.dart`.

---

## 🔄 Nota sobre Compatibilidade com o Flutter 3.x+

Todo o código segue rigorosamente o **Flutter 3.x+** e **Dart Sound Null Safety**, empregando `const`, construtores com `{super.key}` e widgets modernos do Material Design 3 (`ElevatedButton`, `TextButton`, `OutlinedButton` e `InkWell`) em substituição ao legado `RaisedButton` mencionado nos objetivos gerais do roteiro didático.