# Resumo RobComp
---
## Sumário {#sumario#}
  - [ROS2](#ros2)
    - [Executando o ROS2](#executando-o-ros2)
    - [Executando o Teleop](#executando-o-teleop)
    - [Executando o rqt_image_view](#executando-o-rqt_image_view)
    - [Tópicos e Mensagens](#topicos-e-mensagens)
        - [Listar os Tópicos](#listar-os-topicos)
        - [Listar o Tipo de Mensagem](#listar-o-tipo-de-mensagem)
        - [Visualizar Mensagens](#visualizar-mensagens)
        - [Visualizando a Estrutura das Mensagens](#visualizando-a-estrutura-das-mensagens)
    - [Criar um Novo Pacote](#criar-um-novo-pacote)
    - [Compilar Pacote](#compilar-pacote)
    - [Máquina de Estados](#maquina-de-estados)
    - [Arquivos de Base](#arquivos-de-base)
        - [Nó Base](#no-base)
        - [Nó Base de Controle](#no-base-de-controle)
  - [OpenCV2](#opencv2)
    - [Ler a Imagem](#ler-a-imagem)
    - [Mostrar a imagem na tela](#mostrar-a-imagem-na-tela)
    - [Imagens como matrizes](#imagens-como-matrizes)
    - [Conversão de cores](#conversao-de-cores)
    - [Copiar uma imagem](#copiar-uma-imagem)
    - [Criar uma imagem vazia](#criar-uma-imagem-vazia)
    - [Cortar uma imagem](#cortar-uma-imagem)
    - [Mínimo, Máximo, Média, etc](#minimo-maximo-media-etc)
    - [Operações Condicionais](#operações-condicionais)
    - [Área](#area)
    - [Máscaras](#mascaras)
        - [Calcular a área da máscara](#calcular-a-area-da-mascara)
        - [Máscara de imagens em preto e branco](#mascara-de-imagens-em-preto-e-branco)
        - [Máscara de imagens coloridas](#mascara-de-imagens-coloridas)
    - [Indentificação de Obejtos](#indentificacao-de-obejtos)
        - [Filtrando o Objeto](#filtrando-o-objeto)
    - [Contornos](#contornos)
        - [Desenhar Contornos](#desenhar-contornos)
        - [Medidas Dos Contornos](#medidas-dos-contornos)
        - [Maior Contorno](#maior-contorno)
        - [Desenhando o Maior Contorno](#desenhando-o-maior-contorno)
        - [Centro de Massa do Maior Contorno](#centro-de-massa-do-maior-contorno)
        - [Caixa Delimitadora](#caixa-delimitadora)
    - [Ferramenta de Imagem](#ferramenta-de-imagem)
    - [Funções Extras](#funcoes-extras)
        - [Remover borda preta](#remover-borda-preta)
        - [Desenhar Crosshair](#desenhar-crosshair)
  
---

## ROS 2 {#ros2#}

---

#

### Executando o ROS2

```bash
ros2 launch my_gazebo pista-23B.launch.py
```

### Executando o Teleop
```bash
ros2 run teleop_twist_keyboard teleop_twist_keyboard 
```
### Executando o rqt_image_view
```bash
ros2 run rqt_image_view rqt_image_view
```

[Voltar ao Sumário](#sumario)
#
### Tópicos e Mensagens {#topicos-e-mensagens#}
- **Nodes (Nós):** Um nó é um processo que executa uma tarefa especifica na ROS. No nosso caso, um nó é um script python que vamos chamar diretamente.

 - **Topics (Tópicos):** Os tópicos na ROS são barramentos onde a informação é trocada entre nós. Através de tópicos, nós podemos publicar e se inscrever para enviar e receber mensagens. Quando um nó publica uma mensagem ela é enviada para todos os nós que estão inscritos nesta mensagem. Tópicos são identificados por strings únicas.

- **Messages (Mensagens):** As mensagens são estruturas de dados que carregam informações. Elas são podem ser compostas por tipos primitivos, como inteiros, floats, strings, etc. ou por outras mensagens. As mensagens são usadas para publicar e receber informações nos tópicos.
#
### Listar os Tópicos {#listar-os-topicos#}
Você pode listar os tópicos disponíveis com o seguinte o comando:
```bash
ros2 topic list
```
O comando **list** retorna a lista de tópicos disponíveis na ROS no momento. Cada tópico transporta uma mensagem de um tipo específico. Para saber qual o tipo de mensagem que um tópico transporta, execute o seguinte comando:
#
### Listar o Tipo de Mensagem
```bash
ros2 topic info {"Nome do Tópico"}
```
O comando **info** informa o tipo de mensagem que o tópico transporta. 
#
### Visualizar Mensagens
```bash
ros2 topic echo {"Nome do Tópico"}
```
O comando **echo** exibe as mensagens que estão sendo publicadas no tópico.
#
### Visualizando a Estrutura das Mensagens

```bash
ros2 interface show  {"Nome do Pacote"}/msg/{"Nome da Mensagem"}
```
[Voltar ao Sumário](#sumario)
#
### Criar um Novo Pacote

Deve ser criado dentro do diretório */colcon_ws/src* do workspace. Para criar um novo pacote, execute o comando abaixo.



```bash
cd ~/colcon_ws/src
ros2 pkg create --build-type ament_python "Nome do pacote" --dependencies rclpy std_msgs geometry_msgs my_package
```
#
**Onde**: <br>
- **ros2** é o comando para executar o ROS2 <br>
- **pkg create** é o comando para criar um novo pacote <br>
- **--build-type ament_python** é o tipo de pacote que será criado, nesse caso, um pacote em Python <br>
- **"Nome do pacote"** é o nome do pacote que será criado <br>
- **--dependencies rclpy std_msgs geometry_msgs** são as dependências do pacote que será criado, nesse caso, o pacote depende do **rclpy**, **std_msgs** e **geometry_msgs** e **my_package** é um pacote externo que foi criado anteriormente
#
### Compilar Pacote

Após criar um pacote, é necessário compilá-lo; utilizando o comando abaixo.
```bash
cb
```
[Voltar ao Sumário](#sumario)

#
### Máquina de Estados {#maquina-de-estados#}

Uma máquina de estados é um modelo que descreve como um robô ou sistema se comporta. Ela é composta por estados, que são condições do sistema, e transições, que são as mudanças entre esses estados.
Usando como exemplo um robô que segue uma linha, podemos definir os seguintes estados e as seguintes transições:

**Estados**:

- **Andar pra frente:** O robô anda pra frente rodando os dois motores em velocidade máxima.

- **Virar pra direita:** O robô vira para a direita rodando o motor esquerdo em velocidade máxima e o motor direito em velocidade mínima.

- **Virar pra esquerda:** O robô vira para a esquerda rodando o motor direito em velocidade máxima e o motor esquerdo em velocidade mínima.

- **Parar:** O robô para ambos os motores.

**Transições**:

- **Andar pra frente:** O robô entra neste estado quando ambos os sensores estão detectando a linha.

- **Virar pra direita:** O robô entra neste estado quando apenas o sensor direito está detectando a linha.

- **Virar pra esquerda:** O robô entra neste estado quando apenas o sensor esquerdo está detectando a linha.

- **Parar:** O robô entra neste estado quando nenhum dos sensores está detectando a linha.

**Nesse exemplo, a estrutura do código seria algo como:**

```python
    def __init__(self):
        ...

        self.robot_state = 'frente'
        self.state_machine = {
            'frente': self.andar_frente,
            'direita': self.virar_direita,
            'esquerda': self.virar_esquerda,
            'parar': self.parar
        }

    def frente(self):
        # Código para andar pra frente
    def direita(self):
        # Código para virar pra direita
    def esquerda(self):
        # Código para virar pra esquerda
    def parar(self):
        # Código para parar

    def control(self):
        self.state_machine[self.robot_state]()

        # Código para verificar se o estado deve ser alterado

```
#
**Onde**:

- **self.robot_state** é o estado atual do robô
- **self.state_machine** é um dicionário que mapeia os estados para as funções que devem ser executadas
- **self.control()** é a função que executa a máquina de estados
- **self.state_machine [self.robot_state] ()** executa a função correspondente ao estado atual do robô

[Voltar ao Sumário](#sumario)

### Arquivos de Base {#arquivos-de-base#}

São arquivos que servem de base para a criação de novos nós. 

- **Nó Base:** [base.py](arquivos-de-base/base.md)
- **Nó Base de Controle:** [base_control.py](arquivos-de-base/base_control.md)
#
#### Nó Base {#no-base#}

Quando executado, ele chama a função ``control()`` a cada 0,25 segundos. Este script é útil para criar um nó que se inscreve em um tópico e executa uma função a cada nova mensagem recebida, publicando uma mensagem em outro tópico.
#
#### Nó Base de Controle {#no-base-de-controle#}

Neste script, definimos a máquina de estados do robô (no dicionário ``self.state_machine``), o estado inicial (no atributo `self.robot_state`) e a função de controle (no método `self.control()`), que a cada 0,25 segundos, executa a função `self.state_machine[self.robot_state]()` e publica a ação de controle no tópico `cmd_vel` (``self.cmd_vel_pub.publish(self.twist)``).

**Dica:** Em uma máquina de estados bem definida, a função de controle não precisa ser alterada, sendo ela a única função que publica no tópico `cmd_vel`
#
[Voltar ao Sumário](#sumario)

---

## OpenCV2

---
#

### Ler a Imagem

```python
img = cv2.imread("path","exemplo.png")
```
#
### Mostrar a Imagem na Tela

```python
cv2.imshow("Imagem", img)
cv2.waitKey()
cv2.destroyAllWindows()
```

# Adicionar Texto na Imagem

```python
cv2.putText(img, texto, (Posição) cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 0, 0), 2, cv2.LINE_AA)
```
#
**Onde**:

- **Img:** A imagem onde será escrito o texto.
- **texto:** O texto a ser escrito.
- **Posição:** A posição do texto.
- **cv2.FONT_HERSHEY_SIMPLEX:** O tipo de fonte do texto, neste caso, a fonte é a `cv2.FONT_HERSHEY_SIMPLEX`.
- **1:** O tamanho do texto.
- **(255, 0, 0):** A cor do texto, neste caso, a cor é azul.
- **2:** A espessura do texto.
- **cv2.LINE_AA:** O tipo de linha do texto, neste caso, a linha é `cv2.LINE_AA`.

#
### Imagens como Matrizes
No OpenCV as imagens são matrizes do numpy
```python
mini_grid = cv2.imread("path/exemplo.png")
print(mini_grid.shape)
```

```plaintext
# Output
(linhas, colunas, canais)
```
[Voltar ao Sumário](#sumario)
#
### Conversão de Cores {#conversao-de-cores#}
A ordem dos sub-pixels das imagens no OpenCV é **BGR**, em vez de **RGB**.

- **BGR para RGB**
```python
img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
```

- **BGR para Escala de Cinza**

```python
img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
```

- **BGR para HSV**

```python
img_hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
```
[Voltar ao Sumário](#sumario)
#

### Copiar uma Imagem

```python
img_copy = img.copy()
```
#
### Criar uma Imagem Vazia

```python
img_vazia = np.zeros((imagem, np.uint8))
```
#
### Cortar uma Imagem
```python
horizontal = img.copy()
vertical = img.copy()

height, width = img.shape

# Corte Horizontal
horizontal[:int(height/2), :] = 0

# Corte Vertical
vertical[:, int(width/2):] = 0
```
[Voltar ao Sumário](#sumario)
#
### Mínimo, Máximo, Média, etc. {#minimo-maximo-media-etc#}
Com o Numpy é fácil obter estatísticas da imagem. 

Aqui vamos trabalhar com uma imagem em tons de cinza, mas desta vez vamos enviar um argumento para a função `cv2.imread` para ler a imagem diretamente em tons de cinza.

```python
img_gray = cv2.imread("path/exemplo.png", cv2.IMREAD_GRAYSCALE)

minimo = np.min(img_gray)
maximo = np.max(img_gray)
media = np.mean(img_gray)

print("Minimo: ", minimo)
print("Maximo: ", maximo)
print("Media: ", media)
```
[Voltar ao Sumário](#sumario)
#
### Operações Condicionais {#operacoes-condicionais#}

O Numpy permite fazer operações condicionais em arrays (imagens).

Por exemplo, podemos fazer uma operação que retorna torna todos os pixels maiores que a média sejam convertivos para 255 e os menores que a média para 0.

```python
img_gray = cv2.imread("path/exemplo.png", cv2.IMREAD_GRAYSCALE)

codicionado = img_gray.copy()
codicionado[codicionado < media] = 0
codicionado[codicionado >= media] = 255
```
[Voltar ao Sumário](#sumario)
#
### Área {#area#}
Após a condição, a imagem resultante é binária, ou seja, possui apenas dois valores: `0 e 255`. Isso nos permite calcular a área da parte branca da imagem.
    
```python
area = np.sum(codicionado)
print("Area: ", area)
```
[Voltar ao Sumário](#sumario)
#
### Máscaras {#mascaras#}
Uma máscara é uma imagem binária que é usada para selecionar uma parte da imagem original.
Podemos criar uma máscara com a função `cv2.inRange` que define os limites para seleção.


```python
# Lendo a imagem
img = cv2.imread("path/exemplo.png")
img_rgb = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

# Definindo os limites da máscara
inferior = (0,80,0)
superior = (20,255,50)

# Criando a máscara
mask = cv2.inRange(img_rgb, inferior, superior)
```
#
### Calcular a área da máscara{#calcular-a-area-da-mascara#}
Para calcular a área da máscara, basta somar todos os pixels brancos da imagem binária. Para isso utilizamos a função `cv2.countNonZero()` que retorna o número de pixels diferentes de zero na imagem.

```python
area = cv2.countNonZero(mask)
```

#
### Máscara de Imagens em Preto e Branco{#mascara-de-imagens-em-preto-e-branco#}
A função `cv2.inRange` realiza a operação de limiarização.

Para o caso de imagens preto e branco, a função `cv2.inRange` recebe como parâmetros a imagem de entrada, o **valor mínimo** e o **valor máximo** do intervalo de valores que serão considerados para a limiarização. 

O resultado da função é uma imagem binária, onde os pixels que estão dentro do intervalo são brancos e os pixels que estão fora do intervalo são pretos.

```python
# Lendo a imagem
img_gray = cv2.imread("path/exemplo.png", cv2.IMREAD_GRAYSCALE)

# Criando a máscara 
mask = cv2.inRange(img, 0, 30)
```
#
### Máscara de Imagens Coloridas {#mascara-de-imagens-coloridas#}
Para imagens coloridades deve-se trabalhar com a imagem no espaço de cores **HSV**.

- **HSV - Hue, Saturation, Value**

A imagem abaixo mostra claramente como o canal H varia de acordo com a cor, seguindo o círculo de cores.

![](https://upload.wikimedia.org/wikipedia/commons/8/8f/HSV_cylinder.jpg)

#
Onde o canal **Hue** indica a cor dentro do círculo de cores.
O canal **Saturation** indica a saturação da cor.
O canal **Value** indica a luminosidade da cor.

#
**Importante:**

 No circulo acima, lembre-se de dividir o valor `H` por `2` no momento que estiver determinando seu filtro na OpenCV.
`S` e `V` são valores percentuais de `0%` até `100%`, lembre-se de converter para valores de `0 - 255` no momento que estiver determinando seu filtro na OpenCV.
#
```python
# Lendo a imagem
img = cv2.imread("path/exemplo.png")

# Convertendo a imagem para o espaço de cores HSV
img_hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

# Definindo os limites da máscara
inferior = (0, 50, 50)
superior = (10, 255, 255)

# Criando a máscara
mask = cv2.inRange(img_hsv, inferior, superior)
```
[Voltar ao Sumário](#sumario)
#
### Indentificação de Obejtos {#indentificacao-de-obejtos#}

**Circulo HSV** com os valores de `H` das cores

<img src="https://thumbs.dreamstime.com/b/roda-de-cores-da-cor-nomeia-os-graus-rgb-78027630.jpg" width="400" height="400" />

#
* ##### Filtrando o Objeto

A identificação de objetos muitas vezes começa com a segmentação através de máscaras.

Conforme ilustrado acima, a cor vermelha aparece em duas regiões distintas do círculo HSV: uma entre `0 e 30` graus e outra entre `330 e 360` graus.

Abaixo, temos o código para realizar a segmentação da cor vermelha, neste código, combinamos as duas máscaras resultantes utilizando o operador lógico OR do OpenCV, que retorna branco se pelo menos um dos pixels for branco. A função `cv2.bitwise_or` recebe os seguintes parâmetros:

* `cv2.bitwise_or(src, src2, **mask)`
    * `src1`: primeira imagem, ou máscara, de entrada ou matriz real.
    * `src2`: segunda imagem, ou máscara, de entrada ou matriz real.
    * `mask` (opcional): máscara de entrada de 8 bits. A operação será realizada apenas nos elementos especificados pela máscara.

Também temos o operator lógico AND, que retorna branco se ambos os pixels forem brancos, na função `cv2.bitwise_and`.

```python
# Lendo a imagem
img = cv2.imread("path/exemplo.png")
img_hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

# Definindo os limites da máscara 1
cor_menor1 = np.array([172, 50, 50])
cor_maior1 = np.array([180, 255, 255])

# Criando a máscara 1
mask_1 = cv2.inRange(img_hsv, cor_menor1, cor_maior1)

# Definindo os limites da máscara 2
cor_menor2 = np.array([0, 50, 50])
cor_maior2 = np.array([8, 255, 255])

# Criando a máscara 2
mask_2 = cv2.inRange(img_hsv, cor_menor2, cor_maior2)

# Combinando as máscaras
mask_combinada = cv2.bitwise_or(mask_1, mask_2)
```
[Voltar ao Sumário](#sumario)
#
### Contornos

Os contornos podem ser encontrados em imagens binárias com `cv2.findContours`. Esses contornos podem ser usados para identificar e delimitar objetos. Contornos são úteis para encontrar a área, o centro de massa e a caixa delimitadora de um objeto. A função `cv2.findContours` recebe como parâmetros a imagem binária de entrada, o modo de organização dos contornos e o método de aproximação dos contornos.

Usamos a função a seguinte função para encontrar os contornos:
```python
contours, hierarchy = cv2.findContours(mask, cv2.RETR_CCOMP, cv2.CHAIN_APPROX_NONE)
```
#
**Onde:**

* `mask_combinada` é a imagem com a máscara binária de entrada.
* `cv2.RETR_CCOMP` indica que queremos organizar os contornos em componentes conexos e buracos dentro deles
* `cv2.CHAIN_APPROX_NONE` indica que queremos armazenar todos os pontos do contorno.
* `contours` é uma lista de contornos. Cada contorno é uma lista de pontos (x, y) que formam o polígono que delimita o contorno.
* `hierarchy` é uma lista indicando a organização dos contornos em termos dos componentes e de seus buracos.


Os componentes conexos são representados através de seus contornos internos, ou seja, dos pixels de cada componente conexo que são vizinhos a pixels de fundo. 
#
### Desenhar Contornos
Podemos desenhar contornos sobre a imagem para visualizar os objetos identificados.Para desenhar os contornos em uma imagem, usamos a função `cv2.drawContours()`, que usamos da forma:

```python
cv2.drawContours(img, contourssa, indice, cor)
```
#
**Onde**:

* `img`  é a imagem colorida ou tons de cinza onde serão desenhados os contornos.
* `contours` é a lista de contornos obtida com `cv2.findContours()`, ou seja, recebe uma lista de lista. Então assumindo que `contours[i]` seja um contorno, a função esperaria uma sintaxe como `cv2.drawContours(img, [contours[i]], indice, cor)`.
* `indice` é o índice do contorno dentro da lista a ser desenhado; se `-1` desenha todos os contornos
* `cor` é a cor do pixel a ser usada para desenhar o contorno, por exemplo, `(255, 0, 0)` para azul. Se for `-1`, o contorno é **preenchido** com a cor.

```python
# Lendo a imagem
img = cv2.imread("path/exemplo.png")

# Encontrando os contornos
contours, hierarchy = cv2.findContours(mask_combinada, cv2.RETR_CCOMP, cv2.CHAIN_APPROX_NONE)

# Número de contornos
print("Número de contornos: ", len(contours))

# Desenhando os contornos
img_contornos = img.copy()
cv2.drawContours(img_contornos, contours, -1, [255,0,0], 3)
```
[Voltar ao Sumário](#sumario)
#
### Medidas Dos Contornos

A partir dos contornos, podemos tirar uma série de medidas como:
- **Área:** número de pixels pertencentes ao contorno, calculada com `cv2.contourArea(contour)`
- **Centro de massa:** linha e coluna do centro de massa do contorno
- **Caixa delimitadora:** menor retângulo que contém o contorno, calculada com `cv2.boundingRect(contour)`
#
### Maior Contorno
Utilizando a função `cv2.contourArea()` podemos calcular a área de cada contorno e assim encontrar o maior contorno.

```python
# Lendo a imagem
img = cv2.imread("path/exemplo.png")

# Encontrando os contornos
contours, hierarchy = cv2.findContours(mask_combinada, cv2.RETR_CCOMP, cv2.CHAIN_APPROX_NONE)

# Encontrando o maior contorno
maior_contorno = max(contours, key=cv2.contourArea)
```
#
### Desenhando o Maior Contorno
```python
# Desenhando o maior contorno
img_maior_contorno = img.copy()
cv2.drawContours(img_maior_contorno, [maior_contorno], -1, [255,0,0], 3)
```
#
### Centro de Massa do Maior Contorno

O centro de massa de um contorno é calculado através da função `cv2.moments(contour)`, que retorna um dicionário com as seguintes chaves:
* `m00`: área do contorno
* `m10`: soma das coordenadas x dos pixels do contorno
* `m01`: soma das coordenadas y dos pixels do contorno

Essas chaves são usadas para calcular o centro de massa do contorno, que é dado por:

```
cX = int(M["m10"] / M["m00"])
cY = int(M["m01"] / M["m00"])
```

```python
# Lendo a imagem
img = cv2.imread("path/exemplo.png")

# Imagem onde os contornos serão desenhados
contornos_img = img.copy()

# Encontrando os contornos
contours, hierarchy = cv2.findContours(mask_combinada, cv2.RETR_CCOMP, cv2.CHAIN_APPROX_NONE)

# Encontrando o maior contorno
maior_contorno = max(contours, key=cv2.contourArea)

# Função para desenhar um crosshair
def crosshair(img, point, size, color):
    # Desenha um crosshair centrado no point. O point deve ser uma tupla (x,y) O color é uma tupla R,G,B uint8
    x,y = point
    cv2.line(img,(x - size,y),(x + size,y),color,5)
    cv2.line(img,(x,y - size),(x, y + size),color,5)
    return img

# Retorna uma tupla (cx, cy) que desenha o centro do contorno
M = cv2.moments(maior)

# Calcula o centro do contorno
cX = int(M["m10"] / M["m00"])
cY = int(M["m01"] / M["m00"])

# Desenha o centro do contorno com um crosshair
contornos_img = crosshair(contornos_img, (cX,cY), 10, (255,0,0))
```
[Voltar ao Sumário](#sumario)
#
### Caixa Delimitadora

Uma caixa delimitadora é um retângulo que delimita as coordenadas de um objeto. A caixa delimitadora é definida pelas coordenadas de seu canto **superior esquerdo** e sua **largura e altura**.

A função `cv2.boundingRect(contour)` retorna as coordenadas do canto superior esquerdo e a largura e altura da caixa delimitadora.

```python
# Lendo a imagem
img = cv2.imread("path/exemplo.png")

# Imagem onde a caixa delimitadora será desenhada
caixa_img = img.copy()

# Encontrando os contornos
contours, hierarchy = cv2.findContours(mask_combinada, cv2.RETR_CCOMP, cv2.CHAIN_APPROX_NONE)

# Encontrando o maior contorno
maior_contorno = max(contours, key=cv2.contourArea)

# Encontrando a caixa delimitadora
x, y, w, h = cv2.boundingRect(maior_contorno)

# Desenhando a caixa delimitadora
cv2.rectangle(caixa_img, (x, y), (x + w, y + h), (0, 255, 0), 3)
```

[Voltar ao Sumário](#sumario)
#
### Ferramenta de Imagem

Para executar a ferramenta de imagem, basta executar o comando abaixo.

```bash
ros2 run image_tool start_image_tool
```
[Voltar ao Sumádrio](#sumario)

### Funções Extras{#funcoes-extras#}

- **Remover borda preta:** [Remover borda preta](arquivos-de-base/remover_borda.md)
- **Desenhar Crosshair**: [Desenhar Crosshair](arquivos-de-base/desenhar_crosshair.md)
 






