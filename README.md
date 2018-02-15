# README

## Vendas Internas

Esta aplicação tem como função realizar a venda de produtos locaweb a partir de
dados fornecidos pela API de Produtos.

Neste sistema, temos uma interface para o vendedor e uma API que fornece dados 
de novos cliente e novos pedidos feitos.

### Versões

Ruby 2.3.3
Rails 5.1.4

### Gems

- [Devise](https://github.com/plataformatec/devise)

- [Locaweb Style](http://opensource.locaweb.com.br/locawebstyle/)

- [Capybara](https://github.com/teamcapybara/capybara)

- [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)

- [rspec-rails](https://github.com/rspec/rspec-rails)

- [RuboCop](https://github.com/bbatsov/rubocop)
 
- [SimpleCov](https://github.com/colszowka/simplecov)

- [Poltergeist](https://github.com/teampoltergeist/poltergeist)
 
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

E, por fim, instalar o PhantomJS
   
```
Linux:
Faça o download do arquivo diretamente do site oficial do PhantomJS
https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2

Extraia o arquivo com o comando: tar -jxvf 'arquivo baixado'
navegue até a pasta 'bin' do arquivo
execute o comando "sudo mv phantomjs /usr/local/bin"
para copiar o arquivo para o PATH do seu sistema

 MacOS:
- Homebrew: brew install phantomjs

Windows:
Faça o download do arquivo diretamente do site oficial do PhantomJS
- https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-windows.zip
```

### Login

Para o login na aplicação, há um administrador pré-definido:

- Usuário: admin@admin.com
- Senha: 12345678

### API

