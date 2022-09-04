#denifinimos a região que vamos utilizar na AWS.
#1º parametro entre "" é o recuerso
#segundo é o nome que iremos usar 
#como referencia aqui no terraform. Isso serve para todos os recursos.
provider "aws" {
  region = "us-west-1" #california
}