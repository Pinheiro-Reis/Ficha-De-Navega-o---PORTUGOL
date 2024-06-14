programa {
  inclua biblioteca Texto --> tx
  inclua biblioteca Tipos --> tp
  inclua biblioteca Matematica --> m
  logico navegacaoCalculada = falso //valor estatico - deve ser modificado
  inteiro horario[2]

  
  /*--------------------------------------FUNCOES DE APOIO---------------------------------------*/
    /*Tem por unica finaliddade solicitar ao usuario que tecle alguma tecla para continuar um determinado processo*/
  
	funcao cadeia formataMensagem(cadeia mensagem, inteiro tamanhoLinha)
	  {
	    /**
	    * mensagem = tx.preencher_a_direita(" ",tamanhoLinha - 2, mensagem)
		* se tx.numero_caracteres(mensagem) > tamanhoLinha
		* {
		*   mensagem = tx.extrair_subtexto(mensagem, 0, tamanhoLinha - 5) + "..."
		* }
		* mensagem = "| " + mensagem + " "
		* escreva(mensagem)
		*/
		inteiro compl
		compl = tamanhoLinha - tx.numero_caracteres(mensagem) 
		para (inteiro i = 0; i < compl - 2; i++)
		{
		  mensagem+=" "
		}
		
		se (compl < 0)
		{
		  mensagem = tx.extrair_subtexto(mensagem, 0, tamanhoLinha - 5) + "..."
		}
		mensagem = "| " + mensagem + " "
		retorne mensagem
	  }
  


  funcao cadeia formataNumero(real numero, inteiro tamanhoLinha)
  {
    cadeia output = (tx.preencher_a_esquerda('0',tamanhoLinha - 2, "" + tp.real_para_inteiro(numero)))
	output = "| " + output + " "
	retorne output
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
	escreva("\nPressione ENTER")
	leia(linha)
  }

  /**
   * Exemplo de funcao para imprimir o menu principal (obviamente voc�s ir�o alterar conforme o programa de voces)
   */
  funcao inteiro MenuPrincipal()
  {
    limpa()
    cadeia linha = "+______________MENU PRINCIPAL______________+"
    inteiro eu, tamanhoLinha = tx.numero_caracteres(linha)
    escreva(linha,"\n")
    escreva(formataMensagem("1 - CADASTRAR VALORES", tamanhoLinha - 2) + "|\n")
    escreva(formataMensagem("2 - IMPRIMIR TABELA", tamanhoLinha - 2) + "|\n")
	escreva(formataMensagem("3 - ESCOLHER QUANTIA DE PONTOS NOVAMENTE", tamanhoLinha - 2) + "|\n")
    escreva(formataMensagem("4 - SAIR", tamanhoLinha - 2) + "|\n")
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
  
  funcao imprimirFichaNavegacao(cadeia indicativos[], inteiro gmt, inteiro tempoTotal,inteiro qtPts, cadeia pontos[], inteiro rumos[], inteiro distancias[], inteiro tempos[], cadeia etos[])
  {
    se(navegacaoCalculada)
	{
	  
      escreva("+----------------------------------------------------------------------------+\n")
	  escreva("| VALORES    |  ORIGEM  | DESTINO |   HORARIOS   |   DECOLAGEM   |   POUSO   |\n")
	  escreva("+----------------------------------------------------------------------------+\n")
	  escreva("| INDICATIVO |" + formataMensagem(indicativos[0], 10) + formataMensagem(indicativos[1], 9) + "| UTC           " + formataMensagem(mudarHorario(-gmt, 0), 15) + formataMensagem(mudarHorario(-gmt, tempoTotal), 15))
	  
      escreva("+----------------------------------------------------------------------------+\n")
      escreva("| REFERENCIA                 |   RM    |   DISTANCIA   |   TEMPO   |   ETO   |\n")
      escreva("+----------------------------------------------------------------------------+\n")  
      para(inteiro i = 0; i<qtPts; i++)
      { 
        cadeia impressao = formataMensagem(pontos[i],28) + formataNumero(rumos[i], 9) + formataNumero(distancias[i], 15) + formataNumero(tempos[i], 11) + formataMensagem(etos[i], 9) + "|\n"
        escreva(impressao)
	  }
	  escreva("+----------------------------------------------------------------------------+\n")  
    }
	
	senao
	{
      imprimeErro("A NAVEGACAO NAO FOI CALCULADA OU PROCESSADA. POR FAVOR, REALIZE A INSERCAO DOS DADOS DE NAVEGACAO")
    }
  }
  
  

 
  /*--------------------------------------FUNCOES PARA VALIDACAO---------------------------------*/
 
    funcao cadeia validarIndicativos()
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
    
    funcao inteiro validarNumeroParaMaior()
    {
		inteiro output
        real arredondar
        leia(arredondar)
		enquanto(arredondar < 0)
		{
		  escreva("O VALOR INSERIDO É INVALIDO, DIGITE NOVAMENTE: ")
		  leia(arredondar)
		}
		output = m.arredondar(arredondar + 0.4, 0)
        retorne output
    }
	
	funcao inteiro validarNumeroParaMenor()
    {
        inteiro output
        real arredondar
        leia(arredondar)
		enquanto(arredondar < 0)
		{
		  escreva("O VALOR INSERIDO É INVALIDO, DIGITE NOVAMENTE: ")
		  leia(arredondar)
		}
		output = m.arredondar(arredondar - 0.5, 0)
        retorne output
    }
	
	
	funcao inteiro validarGmt()
	{
		inteiro input
		leia(input)
		enquanto (input > 12 ou input < -12)
		{
			escreva("FUSO HORARIO INVALIDO, DIGITE NOVAMENTE: ")
			leia(input)
		}
		retorne input
	}
	
	funcao inteiro validarRumos()
	{
		inteiro input
		leia(input)
		enquanto (input >= 360 ou input <= 0)
		{
			escreva("RUMO INVALIDO, INSIRA UM NOVO: ")
			leia(input)
		}

		retorne input
	}


  /*
  /--------------------------------------FUNCOES DE CALCULOS------------------------------------/
  */

    funcao cadeia mudarHorario(inteiro somaHora, inteiro somaMinuto)
    {
		inteiro horas = 0, minutos = 0
		
        minutos = horario[1] + somaMinuto
		
        enquanto (minutos >= 60)
        {
          minutos -= 60
          horas += 1
        }

        enquanto (minutos < 0)
        {
          minutos += 60
          horas -= 1
        }
		
		horas = horario[0] + somaHora
		
        enquanto (horas >= 24)
        {
          horas -= 24
		}
		
        enquanto (horas < 0)
        {
          horas += 24
		}
		
		cadeia output
		output = (tp.inteiro_para_cadeia(horas, 10)) + ":" + (tp.inteiro_para_cadeia(minutos, 10))
		retorne output
    }
	

  /*
  /--------------------------------------FUNCOES DO PROGRAMA------------------------------------/
  */
  
	funcao cadeia lerHorario()
	{
        cadeia input
        leia(input)
		input += " "
        horario[0] = tp.cadeia_para_inteiro(tx.extrair_subtexto(input, 0, 2), 10)
        enquanto(horario[0] < 0 ou horario[0] > 23)
        {
            escreva("HORA INVALIDA, REPITA: ")
            leia(horario[0])
        }

        horario[1] = tp.cadeia_para_inteiro(tx.extrair_subtexto(input, 3, 5), 10)
        enquanto(horario[1] < 0 ou horario[1] > 59)
        {
            escreva("MINUTAGEM INVALIDA, REPITA: ")
            leia(horario[1])
        }
    
		input = (tp.inteiro_para_cadeia(horario[0],10)) + ":" + (tp.inteiro_para_cadeia(horario[1],10))
		retorne input
	}

  /*
  /--------------------------------------FUNCAO PRINCIPAL DO PROGRAMA---------------------------/
  */
  funcao inicio()
  {
    inteiro qtPts=0
  	logico end = verdadeiro
  	
  	enquanto (end)
  	{
	  	escreva("QUANTIA DE PONTOS DE REFERENCIA: ")
	  	leia(qtPts)
	  	inteiro gmt[2], rumos[qtPts], distancias[qtPts], tempos[qtPts], loop = 1, consHora, distanciaTotal, consumoTotal, velocidade
	  	cadeia pontos[qtPts],indicativos[2], horaDecolagem[2], horaPouso[2], etos[qtPts], enter
	  	real arredondar
	    enquanto(loop == 1)
		{
		  limpa()
		  escolha(MenuPrincipal())
		  {
		      caso 1:
			  //{
				limpa()
				escreva("DIGA A VELOCIDADE DA AERONAVE EM Kt (NM/h): ")
				velocidade = validarNumeroParaMenor()
	    		escreva("DIGA O CODIGO DO AERODROMO DE ORIGEM: ")
				indicativos[0] = validarIndicativos()
				escreva("DIGA O CODIGO DO AERODROMO DE DESTINO: ")
				indicativos[1] = validarIndicativos()
				escreva("DIGA O CONSUMO DE COMBUSTIVEL A HORA: ")
				consHora = validarNumeroParaMaior()
				escreva("DIGA A HORA ZULU DE DECOLAGEM [HH:MM]: ")
				horaDecolagem[0] = lerHorario()
				escreva("DIGA O FUSO HORARIO DO LOCAL DE ORIGEM EM NUMERO: ")
				gmt[0] = validarGmt()
				escreva("DIGA O FUSO HORARIO DO LOCAL DE DESTINO EM NUMERO: ")
				gmt[1] = validarGmt()
				horaDecolagem[1] = mudarHorario(gmt[1], 0)
				para(inteiro i = 0; i < qtPts; i++)
			    {
				  se (i == qtPts - 1)
				  {
				  	pontos[i] = indicativos[1]
				  }
				  
				  senao
				  {
				  	escreva("NOME DO PONTO " + (i+1) + ": ")
					leia(pontos[i])
				  }
				  
				  escreva("DIGA O RUMO DO PONTO " + (i+1) + ": ")
				  rumos[i] = validarRumos()
				  
				  se (i == 0)
				  {
				  	escreva("DIGA A DISTANCIA ENTRE O LOCAL DE DECOLAGEM E O PONTO " + (i+1) + ": ")
				  	leia(arredondar)
            		distancias[i] = m.arredondar(arredondar + 0.4, 0 )
				  }
				  
				  senao
				  {
				  	escreva("DIGA A DISTANCIA DO PONTO " + i + " AO PONTO " + (i+1) + ": ")
				  	distancias[i] = validarNumeroParaMaior()
			      }
			    }
				
				distanciaTotal = 0
				para(inteiro i = 0; i < qtPts; i++)
				{
					distanciaTotal += distancias[i]
				}
				
			    para(inteiro i = 0; i < qtPts; i++)
			    {
        		  arredondar = (distancias[i] / velocidade) * 60
        		  tempos[i] = m.arredondar(arredondar + 0.4, 0)
			    }
				
				inteiro tempoTotal = 0
				para(inteiro i = 0; i < qtPts; i++)
				{
					tempoTotal += tempos[i]
				}
				
				inteiro tempo = 0
				para (inteiro i = 0; i < qtPts; i++)
				{
					tempo += tempos[i]
					etos[i] = mudarHorario(0, tempo)
				}
				
				navegacaoCalculada = verdadeiro
			    pare
			  //}
			  
			  caso 2: //impressao
			  //{
			  limpa()
			  navegacaoCalculada = verdadeiro
			  
			  //imprimirFichaDados(velocidade, indicativos[0], indicativos[1], horaDecolagem[0], horaPouso[0], gmt, horaDecolagem[1], horaPouso[1], consHora, tempoTotal, distanciaTotal, consumo)
			  //imprimirFichaNavegacao(qtPts, pontos, rumos, distancias, tempos, etos)
			  escreva("Pressione ENTER...")
			  leia(enter)
			  
				pare
			  //}
			  
			  caso 3: //para reescolher número de pontos
			  //{
				limpa()
				navegacaoCalculada = falso
		        loop = 0
		        pare
	   	      //}
	   		  
	   		  caso 4: //encerramento
			  //{
				limpa()
			    loop = 0
	            end=falso
				pare
			  //}
				  
			  caso contrario:
	    	  //{
				limpa()
			    loop = 1
			  //}
		
			}
		}
		
		}
	}
}
