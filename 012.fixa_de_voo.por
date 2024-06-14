programa {
  inclua biblioteca Texto --> tx
  inclua biblioteca Tipos --> tp
  inclua biblioteca Matematica --> m
  logico navegacaoCalculada = verdadeiro//valor estatico - deve ser modificado
  inteiro horario[2]

  

  /*
  /--------------------------------------FUNCOES DE APOIO---------------------------------------/
    *Tem por unica finaliddade solicitar ao usuario que tecle alguma tecla para continuar um determinado processo
   */
  funcao continuar(){
    cadeia enter
    escreva("Pressione ENTER para continuar ...\n") 
    leia(enter)  
  }

  /**
   * Realiza a formataï¿½ï¿½o de uma determinada mensagem do programa
   */
  funcao formataMensagem(cadeia mensagem, inteiro tamanhoLinha){
    //mensagem = "| " + mensagem
    //cadeia mensgFormatada = tx.preencher_a_direita(" ",tamanhoLinha-1, mensagem) + "|\n"
    //escreva(mensgFormatada)
	inteiro compl
	compl = tamanhoLinha - tx.numero_caracteres(mensagem) - 4
	para (inteiro i = 0; i < compl; i++)
	{
		mensagem+=" "
	}
	escreva("| " + mensagem + " |\n")
  }

  /**
   * Realiza a formataï¿½ï¿½o de um texto que serï¿½ utilizado na impressï¿½o da ficha de navegacao
   */
  funcao cadeia formataTexto(cadeia mensagem){
    mensagem = "| " + mensagem
    inteiro numeroCaracteres = tx.numero_caracteres(mensagem)
    cadeia mensgFormatada
    se(numeroCaracteres> 24){
      mensagem = tx.extrair_subtexto(mensagem, 0, 20)+" ..."
    }
    //mensgFormatada = tx.preencher_a_direita(' ',24, mensagem)
	retorne mensgFormatada
  }

  /**
   * Realiza a formataï¿½ï¿½o de um numero que serï¿½ utilizado na impressï¿½o da ficha de navegacao
   * qtdCasaDec - Quantida de zeros que serï¿½o preenchidos a esquerda do numero
   */
  funcao cadeia formataNumero(real numero, inteiro qtdCasaDec){
    retorne tx.preencher_a_esquerda('0',qtdCasaDec, ""+numero)
  }
  funcao imprimeCabecalho(cadeia nomeMenu){
    nomeMenu = "  MENU - " + nomeMenu
    inteiro tamanho = tx.numero_caracteres(nomeMenu)
    cadeia linha = "+_"
    para(inteiro i = 0; i< tamanho; i++){
      linha +="_"
    }
    linha +="_+"

    escreva(linha, "\n")
    escreva(tx.caixa_alta(nomeMenu),"\n")
    escreva(linha, "\n")
  }
  
  /*--------------------------------------FUNCOES DE IMPRESSOES----------------------------------*/
  
  /**
   * Funcao para imprimir uma mensagem de erro personalizada para o usuï¿½rio
   */
  funcao imprimeErro(cadeia erro){
    erro = "  ERRO - " + erro
    inteiro tamanho = tx.numero_caracteres(erro)
    cadeia linha = "*-"
    para(inteiro i = 0; i< tamanho; i++){
      linha +="-"
    }
    linha +="-*"

    escreva(linha, "\n")
    escreva(erro,"\n")
    escreva(linha, "\n")
  }

  /**
   * Exemplo de funcao para imprimir o menu principal (obviamente vocï¿½s irï¿½o alterar conforme o programa de voces)
   */
  funcao inteiro MenuPrincipal(){
    limpa()
    cadeia linhaImpressa = "+MENU PRINCIPAL_+"
    inteiro tamanhoLinhaDivisoria = tx.numero_caracteres(linhaImpressa), eu
    escreva(linhaImpressa,"\n")
    formataMensagem("1 - Cadastro de informações", tamanhoLinhaDivisoria)
    formataMensagem("2 - Imprimir tabela", tamanhoLinhaDivisoria)
    formataMensagem("3 - SAIR", tamanhoLinhaDivisoria)
	  linhaImpressa=""
	  para(inteiro i = 0; i < tamanhoLinhaDivisoria - 2; i++)
	  {
	  	linhaImpressa+="_"
	  }
	  escreva("+" + linhaImpressa+ "+")
    escreva("\n\nInforme uma opcao: ")
    leia(eu)
    retorne eu
    }
  
  funcao imprimirFichaNavegacao(real qtPts, cadeia pontos[], real rumos[], real distancias[], real tempos[], real etos[])
  {
    se(navegacaoCalculada){
      escreva("________________________________________________________________________________ \n") 
      escreva("REFERENCIA                  |   RM     |   DISTANCIA   |   TEMPO   |   ETO     | \n")
      escreva("-------------------------------------------------------------------------------- \n")  
      para(inteiro i = 0; i<qtPts; i++)
       {
        cadeia impressao = pontos[i] + "    |   " + formataNumero(rumos[i], 3) +"    |       " + formataNumero(distancias[i], 2) +"      |    " + formataNumero(tempos[i], 2) + "     |   "+ etos[i] + "   |    \n"
        escreva(impressao)
        //escreva("\n\n",pontos,"\n\n")escreva(tempos)
      }
      escreva("________________________________________________________________________________ \n")
    }senao{
      imprimeErro("A navegacao nao foi calculada/processada. Por favor, realize a insercao dos dados de navegacao")
    }
  }

 
  /*--------------------------------------FUNCOES PARA VALIDACAO---------------------------------*/
 
    cadeia input
    funcao validarIndicativos()
    {
        
        leia(input)
        enquanto(tx.numero_caracteres(input) != 4)
        {
            escreva("!!VOCE DIGITOU UM CODIGO IMVALIDO!!\n")
            escreva("DIGITE NOVAMENTE: ")
            leia(input)
        }
        //escreva("aq?")
        input = tx.caixa_alta(input)
        //escreva("aqaq?")
        retorne input      
        //escreva("aqaqaq?")
    }
    
    
    funcao validarConsumo()
    {
        real inputi
        leia(inputi)
        retorne inputi
        
    }


  /*
  /--------------------------------------FUNCOES DE CALCULOS------------------------------------/
  */


  /*
  /--------------------------------------FUNCOES DO PROGRAMA------------------------------------/
  */
  
	funcao lerHorario()
	{
        cadeia input
        leia(input)
        horario[0] = tp.cadeia_para_inteiro(tx.extrair_subtexto(input, 0, 2), 10)
        enquanto(horario[0] < 0 ou horario[0] > 23)
        {
            escreva("HORA INVALIDA, REPITA: ")
            horario[0]
        }

        horario[1] = tp.cadeia_para_inteiro(tx.extrair_subtexto(input, 3 , 5), 10)
        enquanto(horario[1] < 0 ou horario[1] > 59)
        {
            escreva("MINUTAGEM INVALIDA, REPITA: ")
            leia(horario[1])
        }

	}

    funcao mudarHorario(inteiro somaHora, inteiro somaMinuto)
    {
        horario[0] += somaHora
        se (horario[0] >= 24)
        {
          horario[0] -= 24
        }
    
        horario[1] += somaMinuto
        enquanto (horario[1] >= 60)
        {
          horario[1] -= 60
          horario[0] += 1
        }

        enquanto (horario[1] < 0)
        {
            horaio[1] += 60
            horaio[0] -= 1
        }
    }

  /*
  /--------------------------------------FUNCAO PRINCIPAL DO PROGRAMA---------------------------/
  */
  funcao inicio() {
    real qtPts
  	logico end
  	escreva("QUANTIA PONTOS DE REFERENCIA: ")
  	leia(qtPts)
  	real rumos[qtPts], horaPouso, gmt
  	cadeia pontos[qtPts],indicativos[2], horaDecolagem
  	real distancias[qtPts], tempos[qtPts], etos[qtPts], consHora, distanciaTotal, consumoTotal, velocidade
    inteiro lp=0
    
    enquanto(lp!=1){
      se (lp!=1){

      
    limpa()
    escolha(MenuPrincipal())
    {
      caso 1:
      {
        escreva("DIGA O CODIGO DO AERODROMO DE ORIGEM: ")
        indicativos[0] = validarIndicativos()
        escreva("DIGA O CODIGO DO AERODROMO DE DESTINO: ")
        indicativos[1] = validarIndicativos()
        escreva("DIGA A VELOCIDADE DA AERONAVE EM Kt (NM/h): ")
        leia(velocidade)
        escreva("DIGA O CONSUMO DE COMBUSTIVEL A HORA: ")
        consHora = validarConsumo()
        escreva("DIGA O HORARIO LOCAL DE DECOLAGEM [HH:MM]: ")
        lerHorario()
        escreva("DIGA O FUSO HORARIO LOCAL EM NUMERO: ")
        leia(gmt)

        para(inteiro i = 0; i < qtPts; i++)
        {
          escreva("NOME DO PONTO " + (i+1) + ": ")
          leia(pontos[i])
          escreva("DIGA O RUMO DO PONTO " + (i+1) + ": ")
          leia(rumos[i])

          se (i==0)
          {
            distancias[i]=0
          }

          senao
          {
            real ddd
            escreva("DIGA A DISTANCIA DO PONTO " + i + " AO PONTO " + (i+1) + ": ")

            leia(distancias[i])
          }
        }


        tempos[0] = 0
        para(inteiro i = 1; i < qtPts; i++)
        {
            tempos[i] = distancias[i]/velocidade
        }
        
        pare
      }
      
      caso 2: //impressao
      { 
        imprimirFichaNavegacao(qtPts, pontos, rumos, distancias, tempos, etos)
        pare
      }
      
      caso 3: //encerramento
      {
        end=falso
        pare
      }
      caso contrario:{
        lp=0
      }
    }

inteiro loop=0
enquanto (loop==0){
  
  escreva("quer continuar?\n1.   sim\n2.   não\n\nR: ")

  inteiro resposta
  leia(resposta)
  se (resposta==1){
    lp=0
    loop=1
  }senao se(resposta==2){
    pare
  }senao{
    escreva("invalido tente de novo\n")
    loop=0
  }
  
}}
  }
 }
}
