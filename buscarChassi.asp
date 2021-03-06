<%
Response.Buffer  = true
Response.Expires = 0
Session.lcId     = 1033
versao=left(replace(time, ":",""),5)

%>

<!-- #include file="includes/conexao.asp" -->

<%

if (request.QueryString("acao")="excluirRegistro") then
  registro=request.QueryString("registro")
  tela=request.QueryString("tela")
  if (isnull(registro) or registro = "" or registro = "0") then
    response.write "{""erro"":""Código do Usuário não informado. Favor verificar!"" }"
    response.End
  end if 

  if registro <> 0 then     

    if (tela = "ENTRADA") then
      set conEntrada=conDB.execute("SELECT * FROM VEICULO_ENTRADA WHERE ID_ENTRADA = " & registro)
      if conEntrada.eof then
        response.write "{""erro"":""Chassi não consta no banco de dados."" }"     
      else
        delSQL = "DELETE FROM VEICULO_ENTRADA WHERE ID_ENTRADA = " & registro
        conDB.execute(delSQL)
      end if     
    elseif (tela = "DEVOLUCAO") then
        set conDevolucao=conDB.execute("SELECT * FROM VEICULO_DEVOLUCAO WHERE ID_DEVOLUCAO = " & registro)
        if conDevolucao.eof then
          response.write "{""erro"":""Chassi não consta no banco de dados."" }"       
        else  
          delSQL = "DELETE FROM VEICULO_DEVOLUCAO WHERE ID_DEVOLUCAO = " & registro
          conDB.execute(delSQL)
        end if   
    elseif (tela = "SAIDA") then
        set conSaida=conDB.execute("SELECT * FROM VEICULO_SAIDA WHERE ID_SAIDA = " & registro)
        if conSaida.eof then
          response.write "{""erro"":""Chassi não consta no banco de dados."" }"        
        else
          delSQL = "DELETE FROM VEICULO_SAIDA WHERE ID_SAIDA = " & registro
          conDB.execute(delSQL)
        end if
    end if
  end if  

  response.write "{""sucesso"":""ok"" }"
  response.end
end if

titulo="Buscar Chassi"
btnBuscar=request.form("btnBuscar")

if btnBuscar<>""then
  ' trabalhar a acao de pesquisar'

  chassi=request.form("buscarChassi")

  query="SELECT VE.ID_ENTRADA AS 'ID', DATA_ENTRADA_ESTOQUE AS 'DATA', CHAVE_NOTA_FISCAL AS 'CHAVE', KM_HODOMETRO AS 'HODOMETRO', VALOR_COMPRA AS 'VALOR', STATUS_ENVIO AS 'STATUS', 'ENTRADA' TIPO FROM VEICULO_ENTRADA AS VE INNER JOIN ProdutoVeiculos AS PV ON VE.ID_CHASSI=PV.Id WHERE PV.Chassi = '"&chassi&"' "

  query=query&" UNION SELECT VD.ID_DEVOLUCAO AS 'ID', DATA_DEVOLUCAO AS 'DATA', CHAVE_NOTA_FISCAL_DEVOLUCAO AS 'CHAVE', 0, 0, STATUS_ENVIO AS 'STATUS', 'DEVOLUCAO' TIPO FROM VEICULO_DEVOLUCAO AS VD INNER JOIN ProdutoVeiculos AS PV ON VD.ID_CHASSI=PV.Id  WHERE PV.Chassi = '"&chassi&"' "

  query=query&" UNION SELECT VS.ID_SAIDA AS 'ID', DATA_VENDA AS 'DATA', CHAVE_NOTA_FISCAL_SAIDA AS 'CHAVE', 0, VALOR_VENDA AS 'VALOR', STATUS_ENVIO AS 'STATUS', 'SAIDA' TIPO FROM VEICULO_SAIDA AS VS INNER JOIN ProdutoVeiculos AS PV ON  VS.ID_CHASSI = PV.Id WHERE PV.Chassi = '"&chassi&"' ORDER BY TIPO"

  set objRegistros=conDB.execute(query)
end if
      
id = Request.QueryString ("ID")

%>

<!-- #include file="sge_renave_cabecalho.asp" -->

	<h3>Busca de Chassi</h3>

    <form class="needs-validation" novalidate action="buscarChassi.asp" method="post" name='entradaChassi'>

    	<div id="divBusca">
          <img src="images/lupa.png" alt=""/>
          <input type="text" id="buscarChassi" name="buscarChassi" placeholder="Buscar Chassi..."/>
          <button class="btn btn-primary" type="submit" name="btnBuscar" id="btnBuscar" value="Buscar">Buscar</button>
        </div>

        <div id="divExibicao">
        	<table class="table table-sm table-bordered table-striped" border="1px" style="margin: 0px auto; width: 99%;">
        		<thead class = "thead-light">
            		<tr>
            			<th>Data do Evento</th>
                	<th>Chave da Nota Fiscal</th>
                	<th>Valor do hodômetro</th>
                	<th>Valor</th>
                  <th>Tipo</th>
                  <th>Ação</th>
            		</tr>
        		</thead>
            <tbody>

        		<%

              if isobject(objRegistros) then
                while not objRegistros.EOF
                tipoTabela = objRegistros("TIPO")
                
                url = ""
                if tipoTabela = "ENTRADA" THEN url = "entrada.asp?id="&objRegistros("id")
                if tipoTabela = "DEVOLUCAO" THEN url = "devolucao.asp?id="&objRegistros("id")
                if tipoTabela = "SAIDA" THEN url = "saida.asp?id="&objRegistros("id")             
               
                data_evento = objRegistros("DATA")
                dia = right("00"&day(data_evento),2)
                mes = right("00"&month(data_evento),2)
                ano = right("0000"&year(data_evento),4)

                data_evento_fmt = dia&"/"&mes&"/"&ano

        		%>
        			<tr>
            			<td><%=data_evento_fmt%></td>
                	<td><%=objRegistros("CHAVE")%></td>
                	<td><%=objRegistros("HODOMETRO")%></td>
                	<td><%=objRegistros("VALOR")%></td>
                  <td><%=objRegistros("TIPO")%></td>
                  <td align="center">                 

                  <% 
                     statusEnvio = objRegistros("STATUS")                    
                     if statusEnvio=0 then     

                          if (tela = "ENTRADA") then
                            set con=conDB.execute("SELECT STATUS_ENVIO FROM VEICULO_ENTRADA WHERE ID_ENTRADA = " & registro)
                          elseif (tela = "DEVOLUCAO") then
                            set con=conDB.execute("SELECT STATUS_ENVIO FROM VEICULO_DEVOLUCAO WHERE ID_DEVOLUCAO = " & registro)
                          elseif (tela = "SAIDA") then
                            set con=conDB.execute("SELECT STATUS_ENVIO FROM VEICULO_SAIDA WHERE ID_SAIDA = " & registro)
                          end if                        
                          %>
                            <a href="<%=url%>" class="btn btn-success" alt="Editar Registro" title="Editar Registro" name=editar id=editar><img src ="images/edit.png"></a>

                            <a href="#" class="btn btn-danger btnExcluir" registro="<%=objRegistros("id")%>" tela="<%=tipoTabela%>" chassi="<%=chassi%>" alt="Excluir Registro" title="Excluir Registro" name=excluir id=excluir><img src="images/delete.png"></a>

                            <a href="#" class="btn btn-info btnEnviar" registro="<%=objRegistros("id")%>" tela="<%=tipoTabela%>" chassi="<%=chassi%>" alt="Enviar Registro" title="Enviar Registro" name=enviar id=enviar><img src="images/send.png"></a>
                          <%
                      else
                        %>
                          <a href="visualizarRelatorio.asp?tela=<%=tipoTabela%>&registro=<%=objRegistros("id")%>" class="btn btn-secondary btnVisualizar" alt="Visualizar Registro" title="Visualizar Registro" name=visualizar id=visualizar><img src ="images/see.png"></a>
                        <%                    
                      end if
                     
                        %>  
                          </td>
            	       </tr>
        		<%
                  objRegistros.moveNext              
              wend
              end if              
            %>             
            </tbody>
          </table>

        </div>

    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/envio-api.js?versao=<%=versao%>"></script>

    <script>

      var chassi;
      $(".btnExcluir").click(function(e){  
        if(confirm("Deseja excluir o registro?")){
          var btn = $(this);
          chassi = btn.attr("chassi");
          var tela = btn.attr("tela");
          var registro = btn.attr("registro");                  
            ChamaAjax("buscarChassi.asp?acao=excluirRegistro&registro="+registro+"&tela="+tela, null, "POST", retornoExclusao);
        }
      })
      
      function retornoExclusao(data){
        if(data.erro != undefined){
          alert(data.erro)
        }else if(data.sucesso != undefined){
          alert("Registro excluído.");
          $('#buscarChassi').val(chassi);
          $('#btnBuscar').click();
        }else{
          alert("Erro não catalogado.");
        }
          $("#registro").val(data.registro);
          $("#tela").val(data.tela);
      }

    </script>

    </form>

<!-- #include file="sge_renave_rodape.asp" -->