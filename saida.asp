<!-- #include file="includes/conexao.asp" -->

<%
Response.Buffer  = true
Response.Expires = 0
Session.lcId     = 1033

if(request.querystring("acao")="pesquisaCidadeUF")then
  uf=request.querystring("uf")

  set obj=conDB.execute("SELECT NomeMunicipio, CodMunicipio FROM TabMunicipios WHERE NomeEstado='"&uf&"' ORDER BY NomeMunicipio")
  json=""
  if not obj.eof then
    while not obj.eof 
      json=json&"{"
      json=json&"""municipio"" : """&obj("NomeMunicipio")&""""
      json=json&", ""codMunicipio"" : """&obj("CodMunicipio")&""""
      json=json&"},"
      obj.movenext()
    wend

    json = left(json,len(json)-1)
    json = "["&json&"]"
  else 
    json="[{}]" 
  end if 
  response.write json
  response.end
end if

%>

<!-- #include file="sge_renave_cabecalho.asp" -->

<%  

titulo="Saída"

id = request("id")
if (trim(id) = "") or (isnull(id)) then id = 0 end if

nome = replace(trim(request.form("nome")),"'","")
email = replace(trim(request.form("email")),"'","")
tipoDocumento = replace(trim(request.form("tipoDocumento")),"'","")
numeroDocumento = request.form("numeroDocumento")
cepComprador = replace(request.form("cepComprador"),"-","")
logradouro = replace(trim(request.form("logradouro")),"'","")
numero = request.form("numero")
complemento = replace(trim(request.form("complemento")),"'","")
bairro = replace(trim(request.form("bairro")),"'","")
estado = request.form("estado")
codigoMunicipio = request.form("codigoMunicipio")
chassi = request.form("chassi")
idEstoque = request.form("idEstoque")
chaveNotaFiscal = replace(request.form("chaveNotaFiscal"),"-","")
dataVenda = request.form("dataVenda")
valorVenda = replace(replace(request.form("valorVenda"),".",""),",",".")
emailEstabelecimento = replace(trim(request.form("emailEstabelecimento")),"'","")
btnEnviar = request.form("btnEnviar")

if btnEnviar<>""then
  if (cint(id) = 0) then
    ' trabalhar a acao de cadastrar'
    query = "INSERT INTO VEICULO_SAIDA (NOME_COMPRADOR, EMAIL_COMPRADOR, TIPO_DOCUMENTO, NUMERO_DOCUMENTO, CEP, LOGRADOURO, NUMERO, COMPLEMENTO, BAIRRO, ESTADO,  CODIGO_MUNICIPIO, ID_CHASSI, ID_ESTOQUE, CHAVE_NOTA_FISCAL_SAIDA, DATA_VENDA, VALOR_VENDA, EMAIL_ESTABELECIMENTO) VALUES ('"&nome&"','"&email&"', '"&tipoDocumento&"', '"&numeroDocumento&"', '"&cepComprador&"', '"&logradouro&"', '"&numero&"', '"&complemento&"', '"&bairro&"', '"&estado&"', '"&codigoMunicipio&"', '"&chassi&"', '"&idEstoque&"', '"&chaveNotaFiscal&"', '"&dataVenda&"', '"&valorVenda&"', '"&emailEstabelecimento&"');"
  
    'response.write query
    'response.end
    conDB.execute(query)
  else
    objRetorno = "UPDATE VEICULO_SAIDA SET NOME_COMPRADOR = '"&nome&"', EMAIL_COMPRADOR = '"&email&"', TIPO_DOCUMENTO = '"&tipoDocumento&"', NUMERO_DOCUMENTO = '"&numeroDocumento&"', CEP = '"&cepComprador&"', LOGRADOURO = '"&logradouro&"', NUMERO = '"&numero&"', COMPLEMENTO = '"&complemento&"', BAIRRO = '"&bairro&"', ESTADO = '"&estado&"', CODIGO_MUNICIPIO = '"&codigoMunicipio&"', ID_CHASSI = '"&chassi&"', ID_ESTOQUE = '"&idEstoque&"', CHAVE_NOTA_FISCAL_SAIDA = '"&chaveNotaFiscal&"', DATA_VENDA = '"&dataVenda&"', VALOR_VENDA = '"&valorVenda&"', EMAIL_ESTABELECIMENTO = '"&emailEstabelecimento&"' WHERE ID_SAIDA = " &id
    conDB.execute(objRetorno)
  end if
else
  if id <> 0 then
    retornaBD = "SELECT * FROM VEICULO_SAIDA WHERE ID_SAIDA = " &id
    set objRetorno = conDB.execute(retornaBD)
      if not objRetorno.EOF then

        nome = objRetorno ("NOME_COMPRADOR")
        email = objRetorno ("EMAIL_COMPRADOR")
        tipoDocumento = objRetorno ("TIPO_DOCUMENTO")
        numeroDocumento = objRetorno ("NUMERO_DOCUMENTO")
        cepComprador = objRetorno ("CEP")
        logradouro = objRetorno ("LOGRADOURO")
        numero = objRetorno ("NUMERO")
        complemento = objRetorno ("COMPLEMENTO")
        bairro = objRetorno ("BAIRRO")
        estado = objRetorno("ESTADO")       
        codigoMunicipio = objRetorno("CODIGO_MUNICIPIO")
        chassi = objRetorno("ID_CHASSI")
        idEstoque = objRetorno ("ID_ESTOQUE")
        chaveNotaFiscal = objRetorno ("CHAVE_NOTA_FISCAL_SAIDA")
        dataVenda = FmtData(objRetorno ("DATA_VENDA"))
        valorVenda = FormatNumber(objRetorno ("VALOR_VENDA"),2)
        emailEstabelecimento = objRetorno ("EMAIL_ESTABELECIMENTO")
      end if
    set objRetorno = nothing    
  end if  
end if
%>

<div class="container mt-3">
<h3 align=center>Saída de veículo</h3>
        <form class="needs-validation" novalidate action="saida.asp" method="post" name='entradas_saida' id='entradas_saida' >
          <input type="hidden" name="id" id="id" value="<%=id%>">
          <input type="hidden" name="codMunicipioSalvo" id="codMunicipioSalvo" value="<%=codigoMunicipio%>">

          <h6 align=center>Dados do comprador</h6>       
          <div class="row">
            <div class="col-12 col-sm-6 col-md-12 col-lg-5 mb-2 ml-auto">
              <label for="validationCustom01">Nome:</label>
              <input
                type="text"
                class="form-control"
                name="nome"
                id="nome"
                placeholder="Informe o seu nome"
                maxlength="40"
                value="<%=nome%>"
                required
              />
            </div>
            <div class="col-12 col-sm-6 col-md-7 col-lg-4 mb-2">
              <label for="validationCustom02">E-mail:</label>
              <input
                type="text"
                class="form-control"
                name="email"
                id="email"
                placeholder="Informe o seu email"
                maxlength="40"
                value="<%=email%>"
                required
              />
            </div>
            <div class="col-12 col-sm-6 col-md-5 col-lg-2 mb-2 mr-auto">
              <label for="validationCustom03">Documento:</label>
              <select class ="custom-select" name="tipoDocumento" id="tipoDocumento" required>
                <option value="">Selecione:</option>
                <option value="CPF" <%=SetaCombo("CPF", tipoDocumento)%>>CPF</option>
                <option value="CNPJ" <%=SetaCombo("CNPJ", tipoDocumento)%>>CNPJ</option>
              </select>
            </div>
          </div>

          <div class="row">
            <div class="col-12 col-sm-7 col-md-7 col-lg-3 mb-2 ml-auto">
              <label for="validationCustom04">Número do documento:</label>
              <input
                type="text"
                class="form-control"
                name="numeroDocumento"
                id="numeroDocumento"
                placeholder="Número do documento" 
                value="<%=numeroDocumento%>"
                required
              />
            </div>
            <div class="col-12 col-sm-5 col-md-5 col-lg-2 mb-2">
              <label for="cepComprador">CEP:</label>
              <div class="input-group">
                <input
                  type="text"
                  class="form-control"
                  name="cepComprador"
                  id="cepComprador"
                  placeholder="CEP"
                  value="<%=cepComprador%>"
                  required
                />  
                &nbsp;
                  <div class="input-group-btn">
                      <button class="btn btn-primary" id="btnPesquisarCep"><i class="fa fa-search" aria-hidden="true"></i></button>
                  </div>
              </div>
            </div>
            <div class="col-12 col-sm-6 col-md-6 col-lg-3 mb-2">
              <label for="validationCustom10">Estado:</label>
              <select class ="custom-select" name="estado" id="estado" required>
                <option value="">Selecione:</option>
                <option value="AC"<%=SetaCombo("AC", estado) %>>Acre - AC</option>
                <option value="AL"<%=SetaCombo("AL", estado) %>>Alagoas - AL</option>
                <option value="AP"<%=SetaCombo("AP", estado) %>>Amapá - AP</option>
                <option value="AM"<%=SetaCombo("AM", estado) %>>Amazonas - AM</option>
                <option value="BA"<%=SetaCombo("BA", estado) %>>Bahia - BA</option>
                <option value="CE"<%=SetaCombo("CE", estado) %>>Ceará - CE</option>
                <option value="DF"<%=SetaCombo("DF", estado) %>>Distrito Federal - DF</option>
                <option value="ES"<%=SetaCombo("ES", estado) %>>Espírito Santo - ES</option>
                <option value="GO"<%=SetaCombo("GO", estado) %>>Goiás - GO</option>
                <option value="MA"<%=SetaCombo("MA", estado) %>>Maranhão - MA</option>
                <option value="MT"<%=SetaCombo("MT", estado) %>>Mato Grosso - MT</option>
                <option value="MS"<%=SetaCombo("MS", estado) %>>Mato Grosso do Sul - MS</option>
                <option value="MG"<%=SetaCombo("MG", estado) %>>Minas Gerais - MG</option>
                <option value="PA"<%=SetaCombo("PA", estado) %>>Pará - PA</option>
                <option value="PB"<%=SetaCombo("PB", estado) %>>Paraíba - PB</option>
                <option value="PR"<%=SetaCombo("PR", estado) %>>Paraná - PR</option>
                <option value="PE"<%=SetaCombo("PE", estado) %>>Pernambuco - PE</option>
                <option value="PI"<%=SetaCombo("PI", estado) %>>Piauí - PI</option>
                <option value="RJ"<%=SetaCombo("RJ", estado) %>>Rio de Janeiro - RJ</option>
                <option value="RN"<%=SetaCombo("RN", estado) %>>Rio Grande do Norte - RN</option>
                <option value="RS"<%=SetaCombo("RS", estado) %>>Rio Grande do Sul - RS</option>
                <option value="RO"<%=SetaCombo("RO", estado) %>>Rondônia - RO</option>
                <option value="RR"<%=SetaCombo("RR", estado) %>>Roraima - RR</option>
                <option value="SC"<%=SetaCombo("SC", estado) %>>Santa Catarina - SC</option>
                <option value="SP"<%=SetaCombo("SP", estado) %>>São Paulo - SP</option>
                <option value="SE"<%=SetaCombo("SE", estado) %>>Sergipe - SE</option>
                <option value="TO"<%=SetaCombo("TO", estado) %>>Tocantins - TO</option>
              </select>
            </div>
            <div class="col-12 col-sm-6 col-md-6 col-lg-3 mb-2 mr-auto">
              <label for="validationCustom11">Cidade:</label>
              <select class ="custom-select" name="codigoMunicipio" id="codigoMunicipio" required>
                <option selected disabled value="">Selecione:</option>
                <option>...</option>
              </select>
            </div>
          </div>  

          <div class="row">
            <div class="col-12 col-sm-9 col-md-9 col-lg-4 mb-2 ml-sm-auto">
              <label for="validationCustom06">Logradouro:</label>
              <input
                type="text"
                class="form-control"
                name="logradouro"
                id="logradouro"
                placeholder="Logradouro"
                maxlength="30"
                value="<%=logradouro%>"
                required
              />
            </div>
            <div class="col-12 col-sm-3 col-md-3 col-lg-2 mb-2">
              <label for="validationCustom07">Número:</label>
              <input
                type="text"
                class="form-control"
                name="numero"
                id="numero"
                placeholder="Número"
                maxlength="5"
                value="<%=numero%>"
                required
              />
            </div>
            <div class="col-12 col-sm-4 col-md-5 col-lg-2 mb-2">
              <label for="validationCustom08">Complemento:</label>
              <input
                type="text"
                class="form-control"
                name="complemento"
                id="complemento"
                placeholder="Complemento"
                maxlength="20"
                value="<%=complemento%>"
                required
                />
            </div>
            <div class="col-12 col-sm-8 col-md-7 col-lg-3 mb-2 mr-auto">
                <label for="validationCustom09">Bairro:</label>
                <input
                  type="text"
                  class="form-control"
                  name="bairro"
                  id="bairro"
                  placeholder="Bairro"
                  maxlength="20"
                  value="<%=bairro%>"
                  required
                />
            </div>    
          </div>
                           
            <h6 align=center class="mt-3">Dados do veículo</h6>
              
              <%
                selec="SELECT id, Chassi from ProdutoVeiculos WHERE Chassi<>''"

                set objChassis=conDB.execute(selec)
              %>

              <div class="row">
                <div class="col-12 col-sm-6 col-md-5 col-lg-3 mb-2 ml-auto">
                <label for="validationCustom13">Chassi:</label>
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
                <div class="col-12 col-sm-6 col-md-7 col-lg-3 mb-2">
                  <label for="validationCustom12">ID do estoque:</label>
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
                <div class="col-12 col-sm-6 col-md-5 col-lg-3 mb-2">
                  <label for="dataVenda">Data da venda:</label>
                  <input
                    type="datetime"
                    class="form-control"
                    name="dataVenda"
                    id="dataVenda"
                    placeholder="DD/MM/AAAA" 
                    value="<%=dataVenda%>"
                    jamsoft-data
                    required
                  />
                </div>
                <div class="col-12 col-sm-12 col-md-3 col-lg-2 mb-2 mr-auto">
                  <label for="valorVenda">Valor da venda:</label>
                  <input
                    type="text"
                    class="form-control"
                    name="valorVenda"
                    id="valorVenda"
                    placeholder="Valor da venda" 
                    value="<%=valorVenda%>"
                    required
                  />
                </div>
              </div>
      
              <div class="row">
                <div class="col-12 col-sm-12 col-md-12 col-lg-7 mb-2 ml-auto">
                  <label for="validationCustom13">Chave da nota fiscal:</label>
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
                <div class="col-12 col-sm-6 col-md-7 col-lg-4 mb-2 mr-auto">
                  <label for="validationCustom16">E-mail do estabelecimento:</label>
                  <input
                    type="text"
                    class="form-control"
                    name="emailEstabelecimento"
                    id="emailEstabelecimento"
                    placeholder="Email do estabelecimento"
                    maxlength="40"
                    value="<%=emailEstabelecimento%>"
                    required
                  />
                </div>
              </div>

              <div class="row mt-3 mb-4 justify-content-center">
                <div class="col-12 col-sm-4 col-md-3 col-lg-2">
                  <button class="btn btn-primary btn-block" type="submit" name="btnEnviar" id="btnEnviar" value="Enviar">Enviar</button>
                </div> 
              </div>
        </form>
</div>

<!-- #include file="sge_renave_rodape.asp" -->

      <script type="text/javascript" src="js/envio-api.js?versao=<%=versao%>"></script>

      <script>
        $(document).ready(function(){
          $('#numeroDocumento').mask('00000000000000');
          $('#cepComprador').mask('00000-000');
          $('#idEstoque').mask('0000000000000000000');
          $('#chaveNotaFiscal').mask('0000-0000-0000-0000-0000-0000-0000-0000-0000-0000-0000');
          $('#dataVenda').mask('00/00/0000');
          $('#valorVenda').mask('00.000.000,00', {reverse: true});

          $("#estado").change(function(){
            var uf = $.trim($(this).val());
            if(uf == ""){
              return false;
            }

            var url="?acao=pesquisaCidadeUF&uf="+uf
            ChamaAjax(url, null, "GET", retornoMunicipio);
          });
          $("#estado").trigger('change'); 

          function retornoMunicipio(data){
            var option=""; 
              $.each(data, function(i, v){                
                option += '<option value="'+v["codMunicipio"]+'">'+v["municipio"]+'</option>';                 
            })
              $("#codigoMunicipio").html(option);
              $("#codigoMunicipio").focus();

              var codMunicipioSalvo=$.trim($("#codMunicipioSalvo").val());
              if(codMunicipioSalvo != ""){
                $("#codigoMunicipio").val(codMunicipioSalvo);
              }
          }

        $("#btnPesquisarCep").click(function(e){
          e.preventDefault();
          var cep=$("#cepComprador").val();
          cep = cep.replace(/[^0-9]/g,'');
          console.log("cep",cep)          

          if(cep.length != 8){
            alert("CEP inválido!");
          }
          else{
            var urlcep = "https://viacep.com.br/ws/"+cep+"/json/"
            ChamaAjax(urlcep, null, "GET", retornoDados);

            function retornoDados(data){
              $("#logradouro").val(data.logradouro.substring(0, $("#logradouro").attr("maxlength")));
              $("#bairro").val(data.bairro.substring(0, $("#bairro").attr("maxlength")));
              $("#estado").val(data.uf);
              $("#codMunicipioSalvo").val(data.ibge);
                
              $("#estado").trigger('change');
            }
          }   
        });   
      });

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
</script>>

<script>
        $("#btnEnviar").click(validarCampos);
        
        $("#estado").change(function(){
          var estado =  $(this).val();

          console.log('estado',  estado);

        })

        function validarCampos(e) {
          console.log('evento', validarCampos)

          if($.trim(document.entradas.nome.value) == "") {
            alert("Por favor, insira o seu nome!");

            document.entradas.nome.focus();

            return false;
          }

          if($.trim(document.entradas.email.value) == "" ||
             document.entradas.email.value.indexOf('@') == -1 ||
             document.entradas.email.value.indexOf('.') == -1) {
                alert("Por favor, insira o seu e-mail corretamente!");
                
                document.entradas.email.focus();
      
                return false;
          }

          if($.trim(document.entradas.numeroDocumento.value) == "") {
            alert("Por favor, insira o número do seu documento!");

            document.entradas.numeroDocumento.focus();

            return false;
          }

          if($.trim(document.entradas.logradouro.value) == "") {
            alert("Por favor, insira o seu logradouro!");

            document.entradas.logradouro.focus();

            return false;
          }

          if($.trim(document.entradas.numero.value) == "" ||
            document.entradas.numero.value == 0) {
            alert("Por favor, insira o número!");

            document.entradas.numero.focus();

            return false;
          }

          if($.trim(document.entradas.complemento.value) == "") {
            alert("Por favor, insira o complemento!");

            document.entradas.complemento.focus();

            return false;
          }

          if($.trim(document.entradas.bairro.value) == "") {
            alert("Por favor, insira o bairro onde você mora!");

            document.entradas.bairro.focus();

            return false;
          }

          if($.trim(document.entradas.emailEstabelecimento.value) == "" ||
             document.entradas.emailEstabelecimento.value.indexOf('@') == -1 ||
             document.entradas.emailEstabelecimento.value.indexOf('.') == -1) {
                alert("Por favor, insira o seu e-mail do estabelecimento corretamente!");
                
                document.entradas.emailEstabelecimento.focus();      
                return false;
          }
        }
</script>

<%

conDB.close()

set conDB = Nothing

%>