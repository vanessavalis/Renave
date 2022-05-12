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
    ChamaAjax("renave_envio_api.asp?acao=enviarDados&registro="+registro+"&tela="+tela, null, retornoJsonToAPI); 
})

function retornoJsonToAPI(data){
    if(tela == "ENTRADA") {
        EnviarEntrada(data);
    } else if(tela == "DEVOLUCAO") {
       EnviarDevolucao(data);
    } else if(tela == "SAIDA") {
        EnviarSaida(data);
    }    
}

function EnviarEntrada(strJson){     
    ChamaAjax(URL_BASE+"/v1/renave-novos/entrada"+"?cache="+new Date().getTime(), JSON.stringify(strJson), AtualizaStatus);   
}

function EnviarDevolucao(strJson){    
    ChamaAjax(URL_BASE+"/v1/renave-novos/devolucao"+"?cache="+new Date().getTime(), JSON.stringify(strJson), AtualizaStatus);
}

function EnviarSaida(strJson){
    ChamaAjax(URL_BASE+"/v1/renave-novos/saida"+"?cache="+new Date().getTime(), JSON.stringify(strJson), AtualizaStatus);
}

function AtualizaStatus(){
  ChamaAjax("renave_envio_api.asp?acao=atualizarStatus&registro="+registro+"&tela="+tela, null, retornoAtualizacaoStatus);
}

function retornoAtualizacaoStatus(data){
    $('#buscarChassi').val(chassi);
    $('#btnBuscar').click();
}

function ChamaAjax(caminho, dado, func){
    $.ajax({        
        url: caminho,
        data: dado,
        type: "POST",        
        contentType: "application/json",
        dataType: "json",
        success: function(data){
            if(func != undefined){
                func(data)
            }            
        },
        error: function(erro){
            console.log('teste', erro);
            RetornaErro(erro);
        } 
    })
}


function RetornaErro(erro){
    // 0 - sem comunicacao
    // 400 - dados invalidos
    // 401 - Rotina não encontrada
    // 500 - erro de processamento do servidor
    // 503 - Servidor indisponível
    // <> do valor acima => Erro não catalogado

    switch (erro.status){
        case 0:
            alert("Não está havendo comunicação com a API.");
            break;
        case 400:
            alert("Dados inválidos.");
            break;
        case 401:
            alert("Rotina não encontrada.");
            break;      
        case 500:
            alert("Erro de processamento do servidor.");
            break;
        case 503:     
            alert("Servidor indisponível.");
            break;
        default:
            alert("Erro não catalogado."); 
    }
}