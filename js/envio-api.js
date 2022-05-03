 var URL_BASE = "http://localhost:5290";
 $(".btnEnviar").click(function(e){
    e.preventDefault();
    var btn = $(this);
    var tela = btn.attr("tela");
    var registro = btn.attr("registro");
    $.ajax({
        url: "renave_envio_api.asp?acao=enviarDados&registro="+registro+"&tela="+tela,
        type: "POST",        
        contentType: "application/json",
        dataType: "json",
        success: function (data){
            console.log(data)
            EnviarEntrada(data)
        }  
    })
});

 function EnviarEntrada(strJson){
    console.log('retorno api2',strJson);
    $.ajax({
        url: URL_BASE+"/v1/renave-novos/entrada",
        data: strJson,
        type: "POST",        
        contentType: "application/json",
        dataType: "json",
        success: function (data){
            console.log('retorno api',data);
        },
        error: function(erro){
            console.log('teste', erro);
        }  
    })
 }

 function EnviarDevolucao(strJson){    
    $.ajax({
        url: URL_BASE+"/v1/renave-novos/devolucao",
        data: strJson,
        type: "POST",        
        contentType: "application/json",
        dataType: "json",
        success: function (data){
            console.log('retorno api',data);
        },
        error: function(erro){
            console.log('teste', erro);
        }  
    })
 }

  function EnviarSaida(strJson){
    $.ajax({
        url: URL_BASE+"/v1/renave-novos/saida",
        data: strJson,
        type: "POST",        
        contentType: "application/json",
        dataType: "json",
        success: function (data){
            console.log('retorno api',data);
        },
        error: function(erro){
            console.log('teste', erro);
        }  
    })
 }