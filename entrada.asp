<%
Response.Buffer  = true
Response.Expires = 0
Session.lcId     = 1033
%>

<!-- #include file="sge_renave_cabecalho.asp" -->
<!-- #include file="includes/conexao.asp" -->

<%

titulo="Entrada"

id = request("id")
if (trim(id) = "") or (isnull(id)) then id = 0 end if

chassi = request.form("chassi")
hodometro = request.form("hodometro")
dataMedicao = request.form("dataMedicao")
dataEntrada = request.form("dataEntrada")
chaveNotaFiscal = replace(request.form("chaveNotaFiscal"),"-","")
valorCompra = replace(replace(request.form("valorCompra"),".",""),",",".")
btnEnviar = request.form("btnEnviar")

if btnEnviar <> "" then 
  
  if (cint(id) = 0) then
    ' trabalhar a acao de cadastrar'
    query="INSERT INTO VEICULO_ENTRADA (ID_CHASSI, KM_HODOMETRO, DATA_HORA_MEDICAO_HODOMETRO, DATA_ENTRADA_ESTOQUE, CHAVE_NOTA_FISCAL, VALOR_COMPRA) VALUES ('"&chassi&"', '"&hodometro&"','"&dataMedicao&"', '"&dataEntrada&"', '"&chaveNotaFiscal&"', '"&valorCompra&"');"

      'response.write query
      'response.end
      conDB.execute(query)
  else
      objRetorno = "UPDATE VEICULO_ENTRADA SET ID_CHASSI = '"&chassi&"', KM_HODOMETRO = '"&hodometro&"', DATA_HORA_MEDICAO_HODOMETRO = '"&dataMedicao&"',  DATA_ENTRADA_ESTOQUE = '"&dataEntrada&"', CHAVE_NOTA_FISCAL = '"&chaveNotaFiscal&"', VALOR_COMPRA = '"&valorCompra&"' WHERE ID_ENTRADA = " &id
      conDB.execute(objRetorno)
  end if
else
  if id <> 0 then
    retornaBD = "SELECT * FROM VEICULO_ENTRADA WHERE ID_ENTRADA = " &id
    set objRetorno = conDB.execute(retornaBD)
      if not objRetorno.EOF then

        chassi = objRetorno("ID_CHASSI")
        hodometro = objRetorno("KM_HODOMETRO")
        dataMedicao = FmtDataHora(objRetorno("DATA_HORA_MEDICAO_HODOMETRO"))
        dataEntrada = FmtData(objRetorno("DATA_ENTRADA_ESTOQUE"))
        chaveNotaFiscal = objRetorno("CHAVE_NOTA_FISCAL")
        valorCompra = objRetorno("VALOR_COMPRA")      
      end if    
    set objRetorno = nothing
  end if  
end if
%>

<div class="container mt-3">
    <h3 class="text-center mb-3">Entrada de veículo em estoque</h3>
      <form class="needs-validation" novalidate action="entrada.asp" method="post" name='entradas_entrada' id='entradas_entrada'>
        <input type="hidden" name="id" id="id" value="<%=id%>">

        <%
          selec="SELECT id, Chassi from ProdutoVeiculos WHERE Chassi<>''"

          set objChassis=conDB.execute(selec)
        %>  
        
        <div class="row">
          <div class="col-12 col-sm-4 col-md-3 col-lg-2 mb-2 ml-auto">
          <label for="validationCustom01">Chassi: </label>
            <select class="custom-select" name="chassi" id="chassi" required>
                <option selected disabled value="">Selecione:</option>
                <%
                  while not objChassis.EOF
                
                  itemSel = ""
                  if Clng(objChassis("ID")) = Clng(chassi) then itemSel = "Selected"
                %>
                <option value="<%=objChassis("ID")%>" <%=itemSel%>><%=objChassis("CHASSI")%></option>
                <%
                  objChassis.MoveNext()
                  wend
                %>
            </select>
          </div>

          <div class="col-12 col-sm-4 col-md-3 col-lg-2 mb-2">
            <label for="validationCustom02">Hodômetro:</label>
            <input
              type="text"
              class="form-control"
              name="hodometro"
              id="hodometro"
              placeholder="000000" 
              value="<%=hodometro%>"
              required
            />
          </div>


          <div class="col-12 col-sm-4 col-md-3 col-lg-2 mb-2 mr-auto">
            <label for="valorCompra">Valor da compra:</label>
            <input
              type="text"
              class="form-control"
              name="valorCompra"
              id="valorCompra"
              placeholder="Valor da compra" 
              value="<%=valorCompra%>"
              required
            />
          </div>
        </div>  

        <div class="row">
          <div class="col-12 col-sm-7 col-md-5 col-lg-3 mb-2 ml-auto">
            <label for="dataMedicao">Data medição hodômetro:</label>
            <input
              type="text"
              class="form-control"
              name="dataMedicao"
              id="dataMedicao"
              placeholder="DD/MM/AAAA 00:00:00"
              value="<%=dataMedicao%>"
              jamsoft-data-time
              required
            />
          </div>

          <div class="col-12 col-sm-5 col-md-4 col-lg-3 mb-2 mr-auto">
            <label for="dataEntrada">Entrada de estoque:</label>
            <input
              type="text"
              class="form-control"
              name="dataEntrada"
              id="dataEntrada"
              placeholder="DD/MM/AAAA" 
              value="<%=dataEntrada%>"
              jamsoft-data
              required
            />
          </div>
        </div>

        <div class="row justify-content-center">
          <div class="col-12 col-sm-12 col-md-9 col-lg-6 mb-2 ">
            <label for="validationCustom05">Chave da nota fiscal:</label>
            <input
              type="text"
              class="form-control"
              name="chaveNotaFiscal"
              id="chaveNotaFiscal"
              placeholder="Chave da nota fiscal" 
              value="<%=chaveNotaFiscal%>"
              required
            />
          </div>
        </div>

        <div class="row mt-3 mb-4 justify-content-center">
          <div class="col-12 col-sm-4 col-md-3 col-lg-2">
          <button class="btn btn-primary btn-block" type="submit" name="btnEnviar" id="btnEnviar" value="Enviar">Enviar</button>
          </div>
        </form>
      </div>   
      </div>     
   
      <!-- #include file="sge_renave_rodape.asp" -->

      <script>
        $(document).ready(function(){
          $('#hodometro').mask('000000');
          $('#dataMedicao').mask('00/00/0000 00:00:00');
          $('#dataEntrada').mask('00/00/0000');
          $('#chaveNotaFiscal').mask('0000-0000-0000-0000-0000-0000-0000-0000-0000-0000-0000');
          $('#valorCompra').mask('00.000.000,00', {reverse: true});
        })
      </script>