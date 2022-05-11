var URL_BASE = "http://localhost:5290";
var registro = 0;
var tela= "";
var chassi = "";

$(".btnEnviar").click(function(e){
    e.preventDefault();
    var btn = $(this);
    chassi = btn.attr("chassi");
    tela = btn.attr("tela");
    registro = btn.attr("registro");
    $.ajax({
        url: "renave_envio_api.asp?acao=enviarDados&registro="+registro+"&tela="+tela,
        type: "POST",        
        contentType: "application/json",
        dataType: "json",
        success: function(data){
            console.log(tela)
            if(tela == "ENTRADA") {
                EnviarEntrada(data);
            } else if(tela == "DEVOLUCAO") {
                EnviarDevolucao(data);
            } else if(tela == "SAIDA") {
                EnviarSaida(data);
            }            
        }  
    })
});

function EnviarEntrada(strJson){     
    $.ajax({
        url: URL_BASE+"/v1/renave-novos/entrada"+"?cache="+new Date().getTime(),
        data: JSON.stringify(strJson),
        type: "POST",        
        contentType: "application/json",
        dataType: "json",
        success: function(data){
            console.log('retorno api',data);
            AtualizaStatus(registro, tela);
        },
        error: function(erro){
            // 0 - sem comunicacao
            // 400 - dados invalidos
            // 401 - Rotina não encontrada
            // 500 - erro de processamento do servidor
            // 503 - Servidor indisponível

            // <> do valor acima => Erro não catalogado
            console.log('teste', erro);
                if (erro = 0){
                    alert("Não está havendo comunicação com a API.");
                } else if (erro = 400){
                    alert("Dados inválidos.");
                } else if (erro = 401){
                    alert("Rotina não encontrada.");
                } else if (erro = 500){
                    alert("Erro de processamento do servidor.");
                } else if (erro = 503){
                    alert("Servidor indisponível.");
                } else{
                    alert("Erro não catalogado.");
                }
        } 
    })
 }

function EnviarDevolucao(strJson){    
    $.ajax({
        url: URL_BASE+"/v1/renave-novos/devolucao"+"?cache="+new Date().getTime(),
        data: JSON.stringify(strJson),
        type: "POST",        
        contentType: "application/json",
        dataType: "json",
        success: function(data){
            console.log('retorno api',data);
            AtualizaStatus(registro, tela);
        },
        error: function(erro){
            console.log('teste', erro);
                if (erro.status == "0"){
                    alert("Não está havendo comunicação com a API.");
                } else if (erro.status == "400"){
                    alert("Dados inválidos.");
                } else if (erro.status == "401"){
                    alert("Rotina não encontrada.");
                } else if (erro.status == "500"){
                    alert("Erro de processamento do servidor.");
                } else if (erro.status == "503"){
                    alert("Servidor indisponível.");
                } else{
                    alert("Erro não catalogado.");
                }
        }  
    })
 }

function EnviarSaida(strJson){
    $.ajax({
        url: URL_BASE+"/v1/renave-novos/saida"+"?cache="+new Date().getTime(),
        data: JSON.stringify(strJson),
        type: "POST",        
        contentType: "application/json",
        dataType: "json",
        success: function(data){
            console.log('retorno api',data);
            AtualizaStatus(registro, tela);
        },
        error: function(erro){
            console.log('teste', erro);
                if (erro = 0){
                    alert("Não está havendo comunicação com a API.");
                } else if (erro = 400){
                    alert("Dados inválidos.");
                } else if (erro = 401){
                    alert("Rotina não encontrada.");
                } else if (erro = 500){
                    alert("Erro de processamento do servidor.");
                } else if (erro = 503){
                    alert("Servidor indisponível.");
                } else{
                    alert("Erro não catalogado.");
                }
        }  
    })
}

function AtualizaStatus(registro, tela){
    $.ajax({
        url: "renave_envio_api.asp?acao=atualizarStatus&registro="+registro+"&tela="+tela,
        type: "POST",
        contentType: "application/json",
        dataType: "json",
        success: function(data){            
            $('#buscarChassi').val(chassi);
            $('#btnBuscar').click();
        },
        error: function(erro){
            console.log('teste', erro);
        }
    })
}