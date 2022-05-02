<!-- #include file="includes/conexao.asp" -->

<%
	if(request.querystring("acao")="enviarDados") then
	  	registro=request.QueryString("registo")
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
		end if
	end if

%>