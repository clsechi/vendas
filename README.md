# Vendas

Esta aplicação tem como função realizar a venda de produtos Locaweb a partir de
dados fornecidos pela API de Produtos.

Neste sistema, temos uma interface para o vendedor e uma API que fornece dados 
de novos cliente e novos pedidos feitos.

### Versões

*Ruby*: ***2.3.5***
*Rails*: ***5.1.4***

## Dependências

### Gems

- [Devise](https://github.com/plataformatec/devise)

- [LocaStyle](http://opensource.locaweb.com.br/locawebstyle/)

- [Capybara](https://github.com/teamcapybara/capybara)

- [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)

- [rspec-rails](https://github.com/rspec/rspec-rails)

- [RuboCop](https://github.com/bbatsov/rubocop)
 
- [SimpleCov](https://github.com/colszowka/simplecov)

- [Poltergeist](https://github.com/teampoltergeist/poltergeist)
 
- [HTTParty](https://github.com/jnunemaker/httparty)

- [WebMock](https://github.com/bblimke/webmock)
 
### Instalação

Para a instalação, basta dar clone do projeto em sua máquina utilizando o seguinte
comando em seu terminal:

``` 
git@vps1474.publiccloud.com.br:qsd18/vendas.git
```
Para inicializar a aplicação, dentro do diretório,  execute no terminal:

```
bin/setup
```
Logo após, popule o banco de dados com 

```
rails db:setup
```

E, por fim, instalar o PhantomJS para os testes de JavasScript com o Poltergeist
   
```
Linux:
Faça o download do arquivo diretamente do site oficial do PhantomJS
- https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2

Extraia o arquivo com o comando  "tar -jxvf 'arquivo baixado'"
navegue até a pasta 'bin' do arquivo
execute o comando "sudo mv phantomjs /usr/local/bin" para copiar o arquivo para o PATH do seu sistema

MacOS:
- Homebrew: brew install phantomjs

Windows:
Faça o download do arquivo diretamente do site oficial do PhantomJS
- https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-windows.zip
```

### API

**Verbo HTTP / *HTTP verb*:**

> **POST**

**Rota / *Path*:**
>  **/api/orders**

**Cabeçalhos / *Headers*:**
> **Content-Type: application/json**


**Corpo da resposta / *Response body* ex.:**

```json
 {
  "order": {
  "customer_id": "1",
  "product_id": "1",
  "created_at": "2018-02-05T15:27:28.842Z",
  "category_id": "1",
  "plan_id": "1",
  "price": "40.00"
 },
 "customer": {
  "id": "1",
  "name": "Anthony Fantano",
  "address": "Alameda Santos, 777",
  "cpf": "12719726918",
  "cnpj": "",
  "email": "cliente@email.com",
  "phone": "11912341234",
  "company_name": "",
  "contact": ""
 }
}
```


### Login

Para o login na aplicação, há um administrador pré-definido:

- Usuário: admin@admin.com
- Senha: 12345678

### Colaboradores

- [Carlos Sechi](https://github.com/clsechi)
- [Ingrid Rodrigues](https://github.com/IngridRodrigues15)
- [Ítalo Almeida](https://github.com/italoalmeida89)
- [Igor Duarte](https://github.com/igorduarte)
- [Jamil Martinez](https://github.com/jamilmz)
- [Lucca Rosa](https://github.com/LuccaRosa)
- [Thiago Hocsis](https://github.com/ThiagoHocsis)
- [Thiago Talarini](https://github.com/talarini)

