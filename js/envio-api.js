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
        }  
    })
});