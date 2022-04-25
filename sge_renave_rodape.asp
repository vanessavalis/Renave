
    </body>

     <script 
        src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" 
        integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" 
        crossorigin="anonymous" 
        referrerpolicy="no-referrer">
      </script>

      <script 
        src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" 
        crossorigin="anonymous">
      </script>

      <script type="text/javascript" src="js/moment.js"> </script>

      <script type="text/javascript">
        $(document).on('blur','input[jamsoft-data-time]',function(){
            var input = $(this);
            var hoje = moment().format("DD/MM/YYYY HH:mm:ss");
            var data =  moment(input.val(), "DD/MM/YYYY HH:mm:ss", "pt", true);
            if(!data.isValid()){ 
              input.val(hoje);               
              alert("Data e horário inválidos! Por favor, informe a data e o horário corretos.");
            }       
        });
        //$('input[jamsoft-data]').trigger('blur');
      </script>

      <script type="text/javascript">
        $(document).on('blur','input[jamsoft-data]',function(){
            var input = $(this);
            var hoje = moment().format("DD/MM/YYYY");
            var data =  moment(input.val(), "DD/MM/YYYY", "pt", true);
            if(!data.isValid()){

              input.val(hoje); 
              alert("Data inválida! Por favor, informe a data correta.");
            }       
        });
        //$('input[jamsoft-data]').trigger('blur');
      </script>

      <script>
        $("#btnEnviar").click(validarCampos);

        function validarCampos(e) {      
          console.log('evento', validarCampos)

          if(document.entradas.chaveNotaFiscal.value.length != 54) {
            alert("A chave da nota fiscal está incompleta!");

            document.entradas.chaveNotaFiscal.focus();
            e.preventDefault();
            //return false;
          }
        }

      </script>

  </html>
</html>
