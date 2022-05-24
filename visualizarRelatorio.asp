<%
Response.Buffer  = true
Response.Expires = 0
Session.lcId     = 1033
versao=left(replace(time, ":",""),5)

visualizarMenu="NAO"
%>

<!-- #include file="includes/conexao.asp" -->
<!-- #include file="sge_renave_cabecalho.asp" -->

<%
	registro=request.queryString("registro")
	tela=request.queryString("tela")
	chassi=request.queryString("chassi")

	if (tela = "ENTRADA") then
        set con=conDB.execute("SELECT CHASSI, KM_HODOMETRO, DATA_HORA_MEDICAO_HODOMETRO, DATA_ENTRADA_ESTOQUE, CHAVE_NOTA_FISCAL, VALOR_COMPRA FROM VEICULO_ENTRADA AS VE INNER JOIN ProdutoVeiculos AS PV ON VE.ID_CHASSI = PV.Id WHERE ID_ENTRADA = " & registro)

        data_hora_medicao_hodometro = con("DATA_HORA_MEDICAO_HODOMETRO")
        dia = right("00"&day(data_hora_medicao_hodometro),2)
        mes = right("00"&month(data_hora_medicao_hodometro),2)
        ano = right("0000"&year(data_hora_medicao_hodometro),4)
        hora = right("00"&hour(data_hora_medicao_hodometro),2)
        minuto = right("00"&minute(data_hora_medicao_hodometro),2)
        segundo = right("00"&second(data_hora_medicao_hodometro),2)

        data_hora_medicao_hodometro_fmt = dia&"/"&mes&"/"&ano&" "&hora&":"&minuto&":"&segundo

        data_entrada_estoque = con("DATA_ENTRADA_ESTOQUE")
        dia = right("00"&day(data_entrada_estoque),2)
        mes = right("00"&month(data_entrada_estoque),2)
        ano = right("0000"&year(data_entrada_estoque),4)

        data_entrada_estoque_fmt = dia&"/"&mes&"/"&ano

%>
		<div id="divExibicao">
			<h3 align=center>Entrada de veículo em estoque</h3>
			<table class="table table-bordered" border="1px" style="margin: 0px auto; width: 99%;">
			    <thead class = "thead-dark">
			        <tr align="center">
			           	<th>Chassi</th>
			           	<th>Valor do hodômetro</th>
				        <th>Data/hora medição hodômetro</th>
				        <th>Data de entrada em estoque</th>
				        <th>Chave da nota fiscal</th>
				        <th>Valor da compra</th>
			        </tr>
			    </thead>
			    <tbody>
			 		<tr>
	            		<td><%=con("CHASSI")%></td>
	                	<td><%=con("KM_HODOMETRO")%></td>
	                	<td><%=data_hora_medicao_hodometro_fmt%></td>
	                	<td><%=data_entrada_estoque_fmt%></td>
	                  	<td><%=con("CHAVE_NOTA_FISCAL")%></td>
	                  	<td><%=con("VALOR_COMPRA")%></td>
            	    </tr>
			 	</tbody>
			</table>
		</div>
	
<% 
	elseif (tela = "DEVOLUCAO") then
		set con=conDB.execute("SELECT CHASSI, ID_ESTOQUE, CHAVE_NOTA_FISCAL_DEVOLUCAO, DATA_DEVOLUCAO, MOTIVO_DEVOLUCAO_MONTADORA FROM VEICULO_DEVOLUCAO AS VD INNER JOIN ProdutoVeiculos AS PV ON VD.ID_CHASSI = PV.Id WHERE ID_DEVOLUCAO = " & registro)

		data_devolucao = con("DATA_DEVOLUCAO")
		dia = right("00"&day(data_devolucao),2)
		mes = right("00"&month(data_devolucao),2)
		ano = right("0000"&year(data_devolucao),4)

		data_devolucao_fmt = dia&"/"&mes&"/"&ano

%>
		<div id="divExibicao">
			<h3 align=center>Devolução de veículo em estoque</h3>
			<table class="table table-bordered" border="1px" style="margin: 0px auto; width: 99%;">
	        	<thead class = "thead-dark">
	        		<tr align="center">
		        		<th>Chassi</th>
		            	<th>ID do estoque</th>
		            	<th>Chave da nota fiscal</th>
			            <th>Data da devolução</th>
			            <th>Motivo da devolução</th>
	           		</tr>
	        	</thead>
	        	<tbody>
	 				<tr>
	            		<td><%=con("CHASSI")%></td>
	                	<td><%=con("ID_ESTOQUE")%></td>
	                	<td><%=con("CHAVE_NOTA_FISCAL_DEVOLUCAO")%></td>
	                	<td><%=data_devolucao_fmt%></td>
	                  	<td><%=con("MOTIVO_DEVOLUCAO_MONTADORA")%></td>
            		</tr>
	 			</tbody>
	    	</table>
		</div>

<%
	elseif (tela = "SAIDA") then
		set con=conDB.execute("SELECT CHASSI, NOME_COMPRADOR, EMAIL_COMPRADOR, TIPO_DOCUMENTO, NUMERO_DOCUMENTO, CEP, LOGRADOURO, NUMERO, COMPLEMENTO, BAIRRO, ESTADO, NomeMunicipio, CODIGO_MUNICIPIO, ID_ESTOQUE, CHAVE_NOTA_FISCAL_SAIDA, DATA_VENDA, VALOR_VENDA, EMAIL_ESTABELECIMENTO  FROM VEICULO_SAIDA AS VS INNER JOIN ProdutoVeiculos AS PV ON VS.ID_CHASSI = PV.Id INNER JOIN TabMunicipios AS TM ON VS.CODIGO_MUNICIPIO = TM.CodMunicipio WHERE ID_SAIDA = " & registro)

		data_venda = con("DATA_VENDA")
		dia = right("00"&day(data_venda),2)
		mes = right("00"&month(data_venda),2)
		ano = right("0000"&year(data_venda),4)

		data_venda_fmt = dia&"/"&mes&"/"&ano
%>
		<div id="divExibicao">
			<h3 align=center>Saída de veículo em estoque</h3>
			<h5 align=center>Dados do comprador</h5>
			<table class="table table-bordered" border="1px" style="margin: 0px auto; width: 99%;">
		        <thead class = "thead-dark">
		        	<tr>
		            	<th>Nome do comprador</th>
			            <th>Email do comprador</th>
			            <th>Tipo do documento</th>
			            <th>Número do documento</th>
			        </tr>
				</thead>
		        <tbody>
		        	<tr> 
		        		<td><%=con("NOME_COMPRADOR")%></td>
                		<td><%=con("EMAIL_COMPRADOR")%></td>
                		<td><%=con("TIPO_DOCUMENTO")%></td>
                  		<td><%=con("NUMERO_DOCUMENTO")%></td>
                  	</tr>
                </tbody>
            </table>

			<h5 align=center>Endereço do comprador</h5>
			<table class="table table-bordered" border="1px" style="margin: 0px auto; width: 99%;">
		    	<thead class = "thead-dark">
					<tr>
			            <th>CEP</th>
			            <th>Logradouro</th>
			            <th>Número</th>
			            <th>Complemento</th>
			            <th>Bairro</th>
			            <th>Cidade</th>
			            <th>Estado</th>
			            <th>Cóodigo município</th>
			        </tr>
			    </thead>
			    <tbody>
			    	</tr>
			    		<td><%=con("CEP")%></td>
                  		<td><%=con("LOGRADOURO")%></td>
                  		<td><%=con("NUMERO")%></td>
                  		<td><%=con("COMPLEMENTO")%></td>
                  		<td><%=con("BAIRRO")%></td>
                  		<td><%=con("NomeMunicipio")%></td>
                  		<td><%=con("ESTADO")%></td>
                  		<td><%=con("CODIGO_MUNICIPIO")%></td>
                	</tr>
			    </tbody>
			</table>    

			<h5 align=center>Dados do veículo</h5>
			<table class="table table-bordered" border="1px" style="margin: 0px auto; width: 99%;">
		    	<thead class = "thead-dark">        	
					<tr align="center">
			            <th>Chassi</th>
			            <th>ID do estoque</th>
			            <th>Chave da nota fiscal</th>
			            <th>Data da venda</th>
			            <th>Valor da venda</th>
			            <th>Email do estabelecimento</th>
		           	</tr>
		        </thead>
		        <tbody>
		 			<tr>
            			<td><%=con("CHASSI")%></td>
                  		<td><%=con("ID_ESTOQUE")%></td>
                  		<td><%=con("CHAVE_NOTA_FISCAL_SAIDA")%></td>
                  		<td><%=data_venda_fmt%></td>
                  		<td><%=con("VALOR_VENDA")%></td>
                  		<td><%=con("EMAIL_ESTABELECIMENTO")%></td>
                  	</tr>
		 		</tbody>
		    </table>
		</div>
<%
	end if
%>

<div class="row mt-3 mb-4 justify-content-center">
	<div class="col-12 col-sm-4 col-md-3 col-lg-2">
		<a href="javascript:history.back()" class="btn btn-primary btnVoltar btn-block" alt="Voltar" title="Voltar" name=btnVoltar id=btnVoltar>Voltar</a>
	</div>
</div>

<!-- #include file="sge_renave_rodape.asp" -->