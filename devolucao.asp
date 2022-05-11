<%
Response.Buffer  = true
Response.Expires = 0
Session.lcId     = 1033
%>

<!-- #include file="sge_renave_cabecalho.asp" -->
<!-- #include file="includes/conexao.asp" -->

<%

titulo="Devolucao"

id = request("id")
if (trim(id) = "") or (isnull(id)) then id = 0 end if

chassi = request.form("chassi")
idEstoque = request.form("idEstoque")
chaveNotaFiscal = replace(request.form("chaveNotaFiscal"),"-","")
dataDevolucao = request.form("dataDevolucao")
motivoDevolucao = request.form("motivoDevolucao")
btnEnviar = request.form("btnEnviar")

if btnEnviar <> "" then  
  if (cint(id) = 0) then
    ' trabalhar a acao de cadastrar'
    query="INSERT INTO VEICULO_DEVOLUCAO (ID_CHASSI, ID_ESTOQUE, CHAVE_NOTA_FISCAL_DEVOLUCAO, DATA_DEVOLUCAO, MOTIVO_DEVOLUCAO_MONTADORA) VALUES ('"&chassi&"', '"&idEstoque&"','"&chaveNotaFiscal&"', '"&dataDevolucao&"', '"&motivoDevolucao&"');"
    
    'response.write query
    'response.end
    conDB.execute(query)
  else
    objRetorno = "UPDATE VEICULO_DEVOLUCAO SET ID_CHASSI = '"&chassi&"', ID_ESTOQUE = '"&idEstoque&"', CHAVE_NOTA_FISCAL_DEVOLUCAO = '"&chaveNotaFiscal&"',  DATA_DEVOLUCAO = '"&dataDevolucao&"', MOTIVO_DEVOLUCAO_MONTADORA = '"&motivoDevolucao&"' WHERE ID_DEVOLUCAO = " &id
      conDB.execute(objRetorno)
  end if
else
  if id <> 0 then
    retornaBD = "SELECT * FROM VEICULO_DEVOLUCAO WHERE ID_DEVOLUCAO = " &id
    set objRetorno = conDB.execute(retornaBD)
      if not objRetorno.EOF then

        chassi = objRetorno("ID_CHASSI")
        idEstoque = objRetorno("ID_ESTOQUE")
        chaveNotaFiscal = objRetorno("CHAVE_NOTA_FISCAL_DEVOLUCAO")
        dataDevolucao = FmtData(objRetorno("DATA_DEVOLUCAO"))
        motivoDevolucao = objRetorno("MOTIVO_DEVOLUCAO_MONTADORA")
    
      end if 
    set objRetorno = nothing
  end if
end if
%>

      <h3 align=center>Devolução de veículo para montadora</h3>

      <form class="needs-validation" novalidate action="devolucao.asp" method="post" name='entradas_devolucao' id='entradas_devolucao'>
        <input type="hidden" name="id" id="id" value="<%=id%>">
        
        <%
          selec="SELECT id, Chassi from ProdutoVeiculos WHERE Chassi<>''"

          set objChassis=conDB.execute(selec)
        %>
        
        <div class="form-row justify-content-center">
          <div class="col-md-3">
          <label for="validationCustom01">Selecione o chassi:</label>
            <select class="custom-select" name="chassi" id="chassi" required>
                <option selected disabled value="">Selecione o chassi:</option>
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
          <div class="col-md-3 justify-content-center">
            <label for="validationCustom02">ID do estoque:</label>
            <input
              type="text"
              class="form-control"
              name="idEstoque"
              id="idEstoque"
              placeholder="Número do ID do estoque" 
              value="<%=idEstoque%>"
              required
            />
          </div>
        </div>

        <div class="form-row justify-content-center">
          <div class="col-md-3">
            <label for="validationCustom03">Chave da nota fiscal:</label>
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
          <div class="col-md-3 justify-content-center">
            <label for="dataDevolucao">Data da devolução:</label>
            <input
              type="datetime"
              class="form-control"
              name="dataDevolucao"
              id="dataDevolucao"
              placeholder="DD/MM/AAAA" 
              value="<%=dataDevolucao%>"
              jamsoft-data
              required
            />
          </div>
        </div>    

        <div class="form-row justify-content-center">
          <div class="col-md-3">
            <label for="validationCustom05">Motivo da devolução para a montadora:</label>
            <select class="custom-select" name="motivoDevolucao" id="motivoDevolucao" required>
                <option value="">Escolha um motivo:</option>
                <option value="DEVOLUCAO_MONTADORA_FINS_DE_TRANSFORMACAO" 
                <%=SetaCombo("DEVOLUCAO_MONTADORA_FINS_DE_TRANSFORMACAO", motivoDevolucao)%>>Devolução montadora: Fins de transformação</option>

                <option value="DEVOLUCAO_MONTADORA_CORRECAO_DE_DADOS_CADASTRAIS_FABRIS"  <%=SetaCombo("DEVOLUCAO_MONTADORA_CORRECAO_DE_DADOS_CADASTRAIS_FABRIS", motivoDevolucao)%>>Devolução Montadora: Correção de dados cadastrais fabris</option>

                <option value="DEVOLUCAO_MONTADORA_AVARIAS" <%=SetaCombo("DEVOLUCAO_MONTADORA_AVARIAS", motivoDevolucao)%>>Devolução Montadora: Avarias</option>

                <option value="DEVOLUCAO_MONTADORA_VENDA_DIRETA" <%=SetaCombo("DEVOLUCAO_MONTADORA_VENDA_DIRETA", motivoDevolucao)%>>Devolução Montadora: Venda direta</option>
            </select>
          </div>
        </div>

        <div class="form-row justify-content-center mt-3">
          <button class="btn btn-primary" type="submit" name="btnEnviar" id="btnEnviar" value="Enviar">Enviar</button>
        </div>
      </form>

<!-- #include file="sge_renave_rodape.asp" -->
      
      <script>
        $(document).ready(function(){
        $('#idEstoque').mask('0000000000000000000');
        $('#chaveNotaFiscal').mask('0000-0000-0000-0000-0000-0000-0000-0000-0000-0000-0000');
        $('#dataDevolucao').mask('00/00/0000');
        })
      </script>

      <script>
        // Example starter JavaScript for disabling form submissions if there are invalid fields
        (function () {
          "use strict";
          window.addEventListener(
            "load",
            function () {
              // Fetch all the forms we want to apply custom Bootstrap validation styles to
              var forms = document.getElementsByClassName("needs-validation");
              // Loop over them and prevent submission
              var validation = Array.prototype.filter.call(
                forms,
                function (form) {
                  form.addEventListener(
                    "submit",
                    function (event) {
                      if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                      }
                      form.classList.add("was-validated");
                    },
                    false
                  );
                }
              );
            },
            false
          );
        })();
      </script>


<%

conDB.close()

set conDB = Nothing

%>