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
		      		json=json&"{"
					json=json&"""chassi"" : """&obj("CHASSI")&""""
		      		json=json&", ""hodometro"" : """&obj("KM_HODOMETRO")&""""
		      		json=json&", ""data_hora_medicao_hodometro"" : """&obj("DATA_HORA_MEDICAO_HODOMETRO")&""""
		      		json=json&", ""data_entrada_estoque"" : """&obj("DATA_ENTRADA_ESTOQUE")&""""
		      		json=json&", ""chave_nota_fiscal"" : """&obj("CHAVE_NOTA_FISCAL")&""""
		      		json=json&", ""valor_compra"" : """&obj("VALOR_COMPRA")&""""
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
		      		json=json&"{"
					json=json&"""chassi"" : """&obj("CHASSI")&""""
		      		json=json&", ""id_estoque"" : """&obj("ID_ESTOQUE")&""""
		      		json=json&", ""chave_nota_fiscal_devolucao"" : """&obj("CHAVE_NOTA_FISCAL_DEVOLUCAO")&""""
		      		json=json&", ""data_devolucao"" : """&obj("DATA_DEVOLUCAO")&""""
		      		json=json&", ""motivo_devolucao_montadora"" : """&obj("MOTIVO_DEVOLUCAO_MONTADORA")&""""
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
		    		json=json&"{"
					json=json&"""nome_comprador"" : """&obj("NOME_COMPRADOR")&""""
		      		json=json&", ""email_comprador"" : """&obj("EMAIL_COMPRADOR")&""""
		      		json=json&", ""tipo_documento"" : """&obj("TIPO_DOCUMENTO")&""""
		      		json=json&", ""numero_documento"" : """&obj("NUMERO_DOCUMENTO")&""""
		      		json=json&", ""cep"" : """&obj("CEP")&""""
		      		json=json&", ""logradouro"" : """&obj("LOGRADOURO")&""""
		      		json=json&", ""numero"" : """&obj("NUMERO")&""""
		      		json=json&", ""complemento"" : """&obj("COMPLEMENTO")&""""
		      		json=json&", ""bairro"" : """&obj("BAIRRO")&""""
		      		json=json&", ""codigo_municipio"" : """&obj("CODIGO_MUNICIPIO")&""""
		      		json=json&", ""chassi"" : """&obj("CHASSI")&""""
		      		json=json&", ""id_estoque"" : """&obj("ID_ESTOQUE")&""""
		      		json=json&", ""chave_nota_fiscal_saida"" : """&obj("CHAVE_NOTA_FISCAL_SAIDA")&""""
		      		json=json&", ""data_venda"" : """&obj("DATA_VENDA")&""""
		      		json=json&", ""valor_venda"" : """&obj("VALOR_VENDA")&""""
		      		json=json&", ""email_estabelecimento"" : """&obj("EMAIL_ESTABELECIMENTO")&""""
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