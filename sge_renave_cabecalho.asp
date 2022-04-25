<!DOCTYPE html>
<html lang="en">
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

        <!-- <link href="css/design.css" rel="stylesheet"> -->

    </head>

    <body>

      <ul class="nav nav-tabs">
        <li class="nav-item">
          <a class="nav-link" href="entrada.asp">Entrada</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="devolucao.asp">Devolução</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="saida.asp">Saída</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="buscarChassi.asp">Buscar Chassi</a>
        </li>
      </ul>

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