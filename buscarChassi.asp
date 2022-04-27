<%
Response.Buffer  = true
Response.Expires = 0
Session.lcId     = 1033
%>

<!-- #include file="includes/conexao.asp" -->

<%

titulo="Buscar Chassi"

function Ceil(Number)
    Ceil = Int(Number)
    if Ceil <> Number then
        Ceil = Ceil + 1
    end if
end function

function ternario(cond, ret)
  if cond = True then
    Response.Write ret
  else
    Response.Write ""
  end if
end function

strStatus = Request("strStatus")

' Paginacao
page = Request.Item("page")
limit = 10

if (trim(page) = "") or (isnull(page)) then
  page = 1
end if

offset = ((Clng(page) * Clng(limit)) - Clng(limit))

set ObjRstCount = Nothing

pages = Ceil((totalRows / limit))

btnBuscar=request.form("btnBuscar")

response.write "ValorBotao =>"&btnBuscar
if btnBuscar<>""then
  ' trabalhar a acao de pesquisar'

  chassi=request.form("buscarChassi")

  query="SELECT VE.ID_ENTRADA AS 'ID', DATA_ENTRADA_ESTOQUE AS 'DATA', CHAVE_NOTA_FISCAL AS 'CHAVE', KM_HODOMETRO AS 'HODOMETRO', VALOR_COMPRA AS 'VALOR', 'ENTRADA' TIPO FROM VEICULO_ENTRADA AS VE INNER JOIN ProdutoVeiculos AS PV ON VE.ID_CHASSI=PV.Id WHERE PV.Chassi = '"&chassi&"' "

  query=query&" UNION SELECT VD.ID_DEVOLUCAO AS 'ID', DATA_DEVOLUCAO AS 'DATA', CHAVE_NOTA_FISCAL_DEVOLUCAO AS 'CHAVE', 0, 0, 'DEVOLUCAO' TIPO FROM VEICULO_DEVOLUCAO AS VD INNER JOIN ProdutoVeiculos AS PV ON VD.ID_CHASSI=PV.Id  WHERE PV.Chassi = '"&chassi&"' "

  query=query&" UNION SELECT VS.ID_SAIDA AS 'ID', DATA_VENDA AS 'DATA', CHAVE_NOTA_FISCAL_SAIDA AS 'CHAVE', 0, VALOR_VENDA AS 'VALOR', 'SAIDA' TIPO FROM VEICULO_SAIDA AS VS INNER JOIN ProdutoVeiculos AS PV ON  VS.ID_CHASSI = PV.Id WHERE PV.Chassi = '"&chassi&"' ORDER BY TIPO"

  set objRegistros=conDB.execute(query)
end if

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
        	<table class="table table-bordered" width="467" border="1px" >
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

                urlExc = ""
                if tipoTabela = "ENTRADA" THEN urlExc = "exc_entrada.asp?id="&objRegistros("id")
                if tipoTabela = "DEVOLUCAO" THEN urlExc = "exc_devolucao.asp?id="&objRegistros("id")
                if tipoTabela = "SAIDA" THEN urlExc = "exc_saida.asp?id="&objRegistros("id")

        		%>
        			<tr>
            			<td><%=objRegistros("DATA")%></td>
                	<td><%=objRegistros("CHAVE")%></td>
                	<td><%=objRegistros("HODOMETRO")%></td>
                	<td><%=objRegistros("VALOR")%></td>
                  <td><%=objRegistros("TIPO")%></td>
                  <td>
                    <a href="<%=url%>" class="btn btn-success" alt="Editar Cadastro" title="Editar Cadastro" name=editar id=editar><img src ="images/edit.png"></a>

                    <a href="<%=urlExc%>" class="btn btn-danger" data-toggle="modal" data-target="#confirm-delete" alt="Excluir Cadastro" title="Excluir Cadastro"><img src="images/delete.png"></a>
                  </td>
            	</tr>
        		<%
         
        			 objRegistros.moveNext
        			 wend
              end if	
        		%>	
            </tbody>
          </table>

          <nav aria-label="...">
          <ul class="pagination">
            <% if (pages > 1) then %>
              <% For i = 1 To pages %>
                <li class="<%=ternario(Clng(i)=Clng(page), "active")%>"><a href="buscarChassi.asp?page=<%=i%>"><%=i%></a></li>
              <% Next %>
            <% end if %>
          </ul>
          </nav>
        </div>

        <div class="modal fade stick-up" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header clearfix text-left">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="pg-close fs-14"></i>
                </button>
                <h5>Confirmação <span class="semi-bold">de Exclusão</span></h5>
              </div>
              <div class="modal-body">
                <!--<p class="debug-url"></p>-->
                <p>Confirmar a exclusão do cadastro?</p>
              </div>                
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <a class="btn btn-danger btn-deletar">Excluir</a>
              </div>
            </div>
          </div>
        </div>

    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
      $(function() { 
        $('#confirm-delete').on('show.bs.modal', function(e) {
        $(this).find('.btn-deletar').attr('href', $(e.relatedTarget).data('href'));
        //$('.debug-url').html('Delete URL: <strong>' + $(this).find('.btn-deletar').attr('href') + '</strong>');
        });
      });
    </script>

    </form>

<!-- #include file="sge_renave_rodape.asp" -->