<!-- #include file="includes/conexao.asp" -->

<%
	if(request.querystring("acao")="enviarDados") then
	  	registro=request.QueryString("registro")
  		tela=request.QueryString("tela")
		json="{}"
		if(tela = "ENTRADA") then
			set obj=conDB.execute("SELECT * FROM VEICULO_ENTRADA AS VE INNER JOIN ProdutoVeiculos AS PV ON VE.ID_CHASSI = PV.Id WHERE VE.ID_ENTRADA = " & registro)
			if obj.eof then
        		json= "{""erro"":""Informação não consta no banco de dados."" }"     
      		else
				json=""
	 			if not obj.eof then
		    		while not obj.eof 

		    		data_hora_medicao_hodometro = obj("DATA_HORA_MEDICAO_HODOMETRO")
		    		dia = right("00"&day(data_hora_medicao_hodometro),2)
            		mes = right("00"&month(data_hora_medicao_hodometro),2)
            		ano = right("0000"&year(data_hora_medicao_hodometro),4)
            		hora = right("00"&hour(data_hora_medicao_hodometro),2)
            		minuto = right("00"&minute(data_hora_medicao_hodometro),2)
            		segundo = right("00"&second(data_hora_medicao_hodometro),2)

					data_hora_medicao_hodometro_fmt = ano&"-"&mes&"-"&dia&"T"&hora&":"&minuto&":"&segundo


		    		data_entrada_estoque = obj("DATA_ENTRADA_ESTOQUE")
		    		dia = right("00"&day(data_entrada_estoque),2)
            		mes = right("00"&month(data_entrada_estoque),2)
            		ano = right("0000"&year(data_entrada_estoque),4)

            		data_entrada_estoque_fmt = ano&"-"&mes&"-"&dia 	

		      		json=json&"{"
					json=json&"""Chassi"" : """&obj("CHASSI")&""""
		      		json=json&", ""QuilometragemHodometro"" : "&obj("KM_HODOMETRO")&""
		      		json=json&", ""DataHoraMedicaoHodometro"" : """&data_hora_medicao_hodometro_fmt&""""
		      		json=json&", ""DataEntradaEstoque"" : """&data_entrada_estoque_fmt&""""
		      		json=json&", ""ChaveNotaFiscal"" : """&obj("CHAVE_NOTA_FISCAL")&""""
		      		json=json&", ""ValorCompra"" : "&obj("VALOR_COMPRA")&""
		      		json=json&"}"
		      		obj.movenext()
		    		wend	    		
	    		end if 
	  		end if 

	  		response.write json
	  		response.end

	  	elseif(tela = "DEVOLUCAO") then
	  		set obj=conDB.execute("SELECT * FROM VEICULO_DEVOLUCAO AS VD INNER JOIN ProdutoVeiculos AS PV ON VD.ID_CHASSI = PV.Id WHERE VD.ID_DEVOLUCAO = " & registro)
			if obj.eof then
        		json= "{""erro"":""Informação não consta no banco de dados."" }"     
      		else
				json=""
	 			if not obj.eof then
		    		while not obj.eof 

		    		data_devolucao = obj("DATA_DEVOLUCAO")
		    		dia = right("00"&day(data_devolucao),2)
            		mes = right("00"&month(data_devolucao),2)
            		ano = right("0000"&year(data_devolucao),4)

            		data_devolucao_fmt = ano&"-"&mes&"-"&dia 	

		      		json=json&"{"
					json=json&"""Chassi"" : """&obj("CHASSI")&""""
		      		json=json&", ""IdEstoque"" : """&obj("ID_ESTOQUE")&""""
		      		json=json&", ""ChaveNotaFiscal"" : """&obj("CHAVE_NOTA_FISCAL_DEVOLUCAO")&""""
		      		json=json&", ""DataDevolucao"" : """&data_devolucao_fmt&""""
		      		json=json&", ""MotivoDevolucaoMontadora"" : """&obj("MOTIVO_DEVOLUCAO_MONTADORA")&""""
		      		json=json&"}"
		      		obj.movenext()
		    		wend	    		
	    		end if 
	  		end if
	  		response.write json
	  		response.end

		elseif(tela = "SAIDA") then
			set obj=conDB.execute("SELECT * FROM VEICULO_SAIDA AS VS INNER JOIN ProdutoVeiculos AS PV ON VS.ID_CHASSI = PV.Id WHERE VS.ID_SAIDA = " & registro)
			if obj.eof then
        		json= "{""erro"":""Informação não consta no banco de dados."" }"     
      		else
				json=""
	 			if not obj.eof then
		    		while not obj.eof

		    		data_venda = obj("DATA_VENDA")
		    		dia = right("00"&day(data_venda),2)
            		mes = right("00"&month(data_venda),2)
            		ano = right("0000"&year(data_venda),4)

            		data_venda_fmt = ano&"-"&mes&"-"&dia 

		    		json=json&"{"
					json=json&"""Nome"" : """&obj("NOME_COMPRADOR")&""""
		      		json=json&", ""Email"" : """&obj("EMAIL_COMPRADOR")&""""
		      		json=json&", ""TipoDocumento"" : """&obj("TIPO_DOCUMENTO")&""""
		      		json=json&", ""NumeroDocumento"" : """&obj("NUMERO_DOCUMENTO")&""""
		      		json=json&", ""Cep"" : """&obj("CEP")&""""
		      		json=json&", ""Logradouro"" : """&obj("LOGRADOURO")&""""
		      		json=json&", ""Numero"" : """&obj("NUMERO")&""""
		      		json=json&", ""Complemento"" : """&obj("COMPLEMENTO")&""""
		      		json=json&", ""Bairro"" : """&obj("BAIRRO")&""""
		      		json=json&", ""CodigoMunicipio"" : """&obj("CODIGO_MUNICIPIO")&""""
		      		json=json&", ""Chassi"" : """&obj("CHASSI")&""""
		      		json=json&", ""IdEstoque"" : """&obj("ID_ESTOQUE")&""""
		      		json=json&", ""ChaveNotaFiscal"" : """&obj("CHAVE_NOTA_FISCAL_SAIDA")&""""
		      		json=json&", ""DataVenda"" : """&data_venda_fmt&""""
		      		json=json&", ""ValorVenda"" : """&obj("VALOR_VENDA")&""""
		      		json=json&", ""EmailEstabelecimento"" : """&obj("EMAIL_ESTABELECIMENTO")&""""
		      		json=json&"}"
		      		obj.movenext()
		      		wend
		      	end if 
	  		end if
	  		response.write json
	  		response.end
		end if
	end if
%>