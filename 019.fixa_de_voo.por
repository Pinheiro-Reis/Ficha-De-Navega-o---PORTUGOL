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

  funcao formataMensagem(cadeia mensagem, inteiro tamanhoLinha)
  {
    /**
    * cadeia mensagem = tx.preencher_a_direita(" ",tamanhoLinha - 2, mensagem)
	* se tx.numero_caracteres(mensagem) > 26
	* {
	*   mensagem = tx.extrair_subtexto(mensagem, 0, 26) + "..."
	* }
	* mensagem = "| " + mensagem + " "
	* escreva(mensagem)
	*/
	inteiro compl=0
	compl = tamanhoLinha - tx.numero_caracteres(mensagem) 
	para (inteiro i = 0; i < compl - 2; i++)
	{
	  mensagem+=" "
	}
	
	se (tx.numero_caracteres(mensagem) > 26)
	{
	  mensagem = tx.extrair_subtexto(mensagem, 0, 26) + "..."
	}
	escreva("| " + mensagem + " ")
  }






  

  funcao formataNumero(real numero, inteiro tamanhoLinha){
    escreva (tx.preencher_a_esquerda('0',tamanhoLinha, ""+numero))
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
   * Funcao para imprimir uma mensagem de erro personalizada para o usu�rio
   */
  funcao imprimeErro(cadeia erro){
    erro = " ERRO - " + erro + " "
    inteiro tamanho = tx.numero_caracteres(erro)
    cadeia linha = "*"
    para(inteiro i = 0; i< tamanho - 2; i++)
	{
      linha +="-"
    }
    linha +="*"

    escreva(linha, "\n")
    escreva(erro,"\n")
    escreva(linha, "\n")
  }

  /**
   * Exemplo de funcao para imprimir o menu principal (obviamente voc�s ir�o alterar conforme o programa de voces)
   */
  funcao inteiro MenuPrincipal()
  {
    limpa()
    cadeia linha = "+_MENU PRINCIPAL_+"
    escreva("aq?")

    inteiro eu=0 , tamanhoLinha = tx.numero_caracteres(linha)
    escreva("aq?")
    escreva(tamanhoLinha,"\n")
    escreva("aq?")
    formataMensagem("1 - CADASTRAR VALORES", tamanhoLinha) 
    escreva("aq?")
    formataMensagem("2 - IMPRIMIR TABELA", tamanhoLinha)
    escreva("aq?")
	  formataMensagem("3 - ESCOLHER QUANTIA DE PONTOS NOVAMENTE", tamanhoLinha)
    formataMensagem("4 - SAIR", tamanhoLinha)
	linha=""
	para(inteiro i = 0; i < tamanhoLinha - 2; i++)
	{
	  linha+="_"
	}
	escreva("+" + linha+ "+")
    escreva("\n\nINFORME UMA OPCAO: ")
    leia(eu)
    retorne eu
  }
  
  funcao imprimirFichaNavegacao(real qtPts, cadeia pontos[], inteiro rumos[], inteiro distancias[], real tempos[], real etos[])
  {
    se(navegacaoCalculada)
	{
      escreva("++\n") 
      escreva("|REFERENCIA                  |   RM     |   DISTANCIA   |   TEMPO   |   ETO      | \n")
      escreva("+--------------------------------------------------------------------------------+\n")  
      para(inteiro i = 0; i<qtPts; i++)
      { 
        //escreva("\n\n",distancias,"\n\n")escreva(tempos)
        cadeia impressao = formataMensagem(pontos[i],28) + formataNumero(rumos[i], 3) + escreva("?talvez") + formataNumero(tempos[i], 3) + formataNumero(etos[i],3) + "|\n"
        escreva(impressao)
        
      }
      escreva("++\n")
    }
	
	senao
	{
      imprimeErro("A NAVEGACAO NAO FOI CALCULADA OU PROCESSADA. POR FAVOR, REALIZE A INSERCAO DOS DADOS DE NAVEGACAO")
    }
  }

 
  /*--------------------------------------FUNCOES PARA VALIDACAO----------------------arredondar_para_cima-----------*/
 
    funcao validarIndicativos()
    {
        cadeia input
        leia(input)
        enquanto(tx.numero_caracteres(input) != 4)
        {
            escreva("!!VOCE DIGITOU UM CODIGO IMVALIDO!!\n")
            escreva("DIGITE NOVAMENTE: ")
            
            leia(input)
        }
        input = tx.caixa_alta(input)
        retorne input      
    }
    
    
    funcao validarConsumo()
    {
        real input
        leia(input)
		enquanto(input <= 0)
		{
		  escreva("O VALOR INSERIDO É INVALIDO, DIGITE NOVAMENTE: ")
		  leia(input)
		}
		//input = m.arredondar_para_cima(input)
        retorne input
    }
	
	funcao validarVelocidade()
	{
	  real velocidade
	  leia(velocidade)
	  enquanto (velocidade <= 0)
	  {
	  	escreva("VOCE INSERIU UM VALOR INVALIDO, INSIRA NOVAMENTE: ")
	  	leia(velocidade)
	  }
	  //velocidade = m.arredondar_para_baixo(velocidade)
	  retorne velocidade
	}
	
	funcao validarGmt()
	{
		inteiro gmt
		leia(gmt)
		enquanto (gmt > 12 ou gmt < -12)
		{
			escreva("FUSO HORARIO INVALIDO, DIGITE NOVAMENTE: ")
			leia(gmt)
		}
		retorne gmt
	}


  /*
  /--------------------------------------FUNCOES DE CALCULOS------------------------------------/
  */

    funcao mudarHorario(inteiro somaHora, inteiro somaMinuto)
    {
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
		
		horario[0] += somaHora
		
        se (horario[0] >= 24)
        {
          horario[0] -= 24
		}
		
        se (horario[0] < 0)
        {
          horario[0] += 24
		}
		
    }

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

  /*
  /--------------------------------------FUNCAO PRINCIPAL DO PROGRAMA---------------------------/
  */
  funcao inicio()
  {
    real qtPts=0
  	logico end = verdadeiro
  	
  	enquanto (end)
  	{
	  	escreva("QUANTIA PONTOS DE REFERENCIA: ")
	  	leia(qtPts)
	  	real rumos[qtPts], horaPouso, gmt
	  	cadeia pontos[qtPts],indicativos[2], horaDecolagem
	  	real distancias[qtPts], tempos[qtPts], etos[qtPts], consHora, distanciaTotal, consumoTotal, velocidade
	    inteiro loop = 1
	    enquanto(loop == 1)
		{
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
				velocidade = validarVelocidade()
				escreva("DIGA O CONSUMO DE COMBUSTIVEL A HORA: ")
				consHora = validarConsumo()
				escreva("DIGA O HORARIO LOCAL DE DECOLAGEM [HH:MM]: ")
				lerHorario()
				escreva("DIGA O FUSO HORARIO LOCAL EM NUMERO: ")
				gmt = validarGmt()
				
				para(inteiro i = 0; i < qtPts; i++)
			    {
			    escreva("NOME DO PONTO " + (i+1) + ": ")
				  leia(pontos[i])
				  escreva("DIGA O RUMO DO PONTO " + (i+1) + ": ")
				  leia(rumos[i])
				  se (i==0)
				  {
				  	escreva("DIGA A DISTANCIA ENTRE O LOCAL DE DECOLAGEM E O PONTO " + (i+1) + ": ")
				  	leia(distancias[i]) 
			      }
				  senao
				  {
				  	escreva("DIGA A DISTANCIA DO PONTO " + i + " AO PONTO " + (i+1) + ": ")
				  	leia(distancias[i])
			      }
			    }
				
				tempos[0] = 0
			    para(inteiro i = 1; i < qtPts; i++)
			    {
				  tempos[i] = (distancias[i]/velocidade)
			    }
			    pare
			  }
			  
			  caso 2: //impressao
			  { 
		        imprimirFichaNavegacao(qtPts, pontos, rumos, distancias, tempos, etos)
		        pare
			  }
			  
			  caso 3: //para reescolher número de pontos
			  {
		        loop = 0
		        pare
	   	      }
	   		  
	   		  caso 4: //encerramento
			  {
	            end=falso
				pare
			  }
				  
			  caso contrario:
	    	  {
			    loop = 1
			  }
		  }
     }
}
}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 8390; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
