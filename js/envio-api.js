var URL_BASE = "http://localhost:5290";
var registro = 0;
var tela= "";

$(".btnEnviar").click(function(e){
    e.preventDefault();
    var btn = $(this);
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
            console.log('teste', erro);
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
            console.log('ok',data);
        },
        error: function(erro){
            console.log('teste', erro);
        }
    })

}