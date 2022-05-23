<!DOCTYPE html>
<html lang="pt-BR">
  <html>
    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <title><%=titulo%></title>
      <link 
        rel="stylesheet" 
        href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" 
        integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" 
        crossorigin="anonymous">

        <link 
        rel="stylesheet" 
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"       
        crossorigin="anonymous">       

        <!-- <link href="css/design.css" rel="stylesheet"> -->

        <style type="text/css">
          .navbar-nav{
            min-height: 42px !important;
          }

          .navbar-nav li{
            margin-right: 10px;
            
            text-align: center;
            
          }

          .navbar-nav a{
            width: 115px;
            transition: all .2s;
          }

          .navbar-nav a:hover{
            border-bottom: 2px solid red;
          }

          @media (max-width:  580px){
            .navbar-nav {
              width: 100%;
              flex-direction: column !important;
            }

           .navbar-nav li{
              text-align: -webkit-center;
              width: 100%;
              height: 40px;
           }
          }
        </style>

    </head>

    <body>

      <%
         if visualizarMenu<>"NAO" then
      %>
      <nav class="navbar navbar-expand navbar-light bg-dark">
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link text-white" href="entrada.asp">Entrada</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-white" href="devolucao.asp">Devolução</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-white" href="saida.asp">Saída</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-white" href="buscarChassi.asp">Buscar Chassi</a>
          </li>
        </ul>
      </nav>
      <%
      end if
      %>
      <%

        Function FmtData(strData)
          if isdate(strData) then
            data = cdate(strData)
            dia = right("00"&day(strData),2)
            mes = right("00"&month(strData),2)
            ano = right("0000"&year(strData),4)
            FmtData = dia&"/"&mes&"/"&ano
          else
            FmtData = ""
          end if 
        end Function

        Function FmtDataHora(strDataHora)
          if isDate(strDataHora) then
            dataHora = cdate(strDataHora)
            dia = right("00"&day(strDataHora),2)
            mes = right("00"&month(strDataHora),2)
            ano = right("0000"&year(strDataHora),4)
            hora = right("00"&hour(strDataHora),2)
            minuto = right("00"&minute(strDataHora),2)
            segundo = right("00"&second(strDataHora),2)

            FmtDataHora = dia&"/"&mes&"/"&ano&" "&hora&":"&minuto&":"&segundo

          else
            FmtDataHora = ""
          end if
        end Function

      Function SetaCombo(valor1, valor2)
        if trim(valor1)=trim(valor2) then
          SetaCombo="selected"
        else
          SetaCombo=""
        end if
      end Function
      
      %>