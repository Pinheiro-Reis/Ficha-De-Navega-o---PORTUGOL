programa {
  inclua biblioteca Texto --> tx
  inclua biblioteca Tipos --> tp
  inclua biblioteca Matematica --> m
  logico navegacaoCalculada = falso //valor estatico - deve ser modificado
  inteiro horario[2], hlo[2]

  /*
  /--------------------------------------FUNCOES DE APOIO---------------------------------------/
    *Tem por unica finaliddade solicitar ao usuario que tecle alguma tecla para continuar um determinado processo
   */

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
	
	se (tx.numero_caracteres(mensagem) > tamanhoLinha - 2)
	{
	  mensagem = tx.extrair_subtexto(mensagem, 0, tamanhoLinha - 5) + "..."
	}
	mensagem = "| " + mensagem + " "
	retorne mensagem
  }


  funcao cadeia formataNumero(real numero, inteiro tamanhoLinha){
    cadeia output = (tx.preencher_a_esquerda('0',tamanhoLinha, ""+numero))
	retorne output
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
  
  funcao imprimirFichaNavegacao(real qtPts, cadeia pontos[], inteiro rumos[], real distancias[], real tempos[], cadeia etos[])
  {
    se(navegacaoCalculada)
	{
      escreva("+--------------------------------------------------------------------------------+\n")
      escreva("|REFERENCIA                  |   RM     |   DISTANCIA   |   TEMPO   |   ETO      | \n")
      escreva("+--------------------------------------------------------------------------------+\n")  
      para(inteiro i = 0; i<qtPts; i++)
      { 
        //escreva("\n\n",distancias,"\n\n")escreva(tempos)
		escreva("|")
        cadeia impressao = formataMensagem(pontos[i],28) + formataNumero(rumos[i], 3) + formataNumero(tempos[i], 3) + formataMensagem(etos[i],12) + "|\n"
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
    
    
    funcao real validarNumero()
    {
        real input
        leia(input)
		enquanto(input < 0)
		{
		  escreva("O VALOR INSERIDO É INVALIDO, DIGITE NOVAMENTE: ")
		  leia(input)
		}
		//input = m.arredondar_para_cima(input)
        retorne input
    }
	
	
	funcao inteiro validarGmt()
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

    funcao cadeia mudarHorario(inteiro hora[], inteiro somaHora, inteiro somaMinuto)
    {
		inteiro horas = 0, minutos = 0
		
        minutos = hora[1] + somaMinuto
		
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
		
		horas = hora[0] + somaHora
		
        enquanto (horas >= 24)
        {
          hora[0] -= 24
		}
		
        enquanto (horas < 0)
        {
          hora[0] += 24
		}
		
		cadeia output
		output = horas + ":" + minutos
		retorne output
    }
	

  /*
  /--------------------------------------FUNCOES DO PROGRAMA------------------------------------/
  */
  
	funcao cadeia lerHorario(inteiro hora[])
	{
        cadeia input
        leia(input)
		input += " "
        hora[0] = tp.cadeia_para_inteiro(tx.extrair_subtexto(input, 0, 2), 10)
        enquanto(hora[0] < 0 ou hora[0] > 23)
        {
            escreva("HORA INVALIDA, REPITA: ")
            leia(hora[0])
        }

        hora[1] = tp.cadeia_para_inteiro(tx.extrair_subtexto(input, 3, 5), 10)
        enquanto(hora[1] < 0 ou hora[1] > 59)
        {
            escreva("MINUTAGEM INVALIDA, REPITA: ")
            leia(hora[1])
        }
		input = hora[0] + ":" + hora[1]
		retorne input
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
	  	inteiro rumos[qtPts], gmt
	  	cadeia pontos[qtPts],indicativos[2], horaDecolagem[2], horaPouso[2], etos[qtPts]
	  	real distancias[qtPts], tempos[qtPts], consHora, distanciaTotal, consumoTotal, velocidade
	    inteiro loop = 1
	    enquanto(loop == 1)
		{
		  limpa()
		  escolha(MenuPrincipal())
		  {
		      caso 1:
			  //{
				escreva("DIGA A VELOCIDADE DA AERONAVE EM Kt (NM/h): ")
				velocidade = validarNumero()
	    		escreva("DIGA O CODIGO DO AERODROMO DE ORIGEM: ")
				indicativos[0] = validarIndicativos()
				escreva("DIGA O CODIGO DO AERODROMO DE DESTINO: ")
				indicativos[1] = validarIndicativos()
				escreva("DIGA O CONSUMO DE COMBUSTIVEL A HORA: ")
				consHora = validarNumero()
				escreva("DIGA A HORA ZULU DE DECOLAGEM [HH:MM]: ")
				horaDecolagem[0] = lerHorario(horario)
				escreva("DIGA O FUSO HORARIO LOCAL EM NUMERO: ")
				gmt = validarGmt()
				horaDecolagem[1] = mudarHorario(horario, gmt, 0)
					
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
				  	//distancias[i] = m.arredondar_para_cima(distancias[i])
			      }
				  senao
				  {
				  	escreva("DIGA A DISTANCIA DO PONTO " + i + " AO PONTO " + (i+1) + ": ")
				  	leia(distancias[i])
				    //distancias[i] = m.arredondar_para_cima(distancias[i])
			      }
			    }
				
				distanciaTotal = 0
				para(inteiro i = 0; i < qtPts; i++)
				{
					distanciaTotal += distancias[i]
				}
				
				tempos[0] = 0
			    para(inteiro i = 1; i < qtPts; i++)
			    {
				  //tempos[i] = m.arredondar_para_cima((distancias[i]/velocidade)*60)
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
					etos[i] = mudarHorario(horario, 0, tempo)
				}
				
				//eto = m.arredondar_para_cima(eto)

				navegacaoCalculada = verdadeiro
			    pare
			  //}
			  
			  caso 2: //impressao
			  //{
				//imprimirFichaDados(velocidade, indicativos[0], indicativos[1], HoraDecolagem[0], horaPouso[0], gmt, horaDecolagem[1], horaPouso[1], consHora, tempoTotal, distanciaTotal, consumo)
		        imprimirFichaNavegacao(qtPts, pontos, rumos, distancias, tempos, etos)
		        pare
			  //}
			  
			  caso 3: //para reescolher número de pontos
			  //{
		        loop = 0
		        pare
	   	      //}
	   		  
	   		  caso 4: //encerramento
			  //{
			    loop = 0
	            end=falso
				pare
			  //}
				  
			  caso contrario:
	    	  //{
			    loop = 1
			  //}
		
			}
		}
		
		}
	}
}
