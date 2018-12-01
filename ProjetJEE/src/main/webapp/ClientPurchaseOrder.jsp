<!DOCTYPE html>

<html>
    
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Projet J2E - PMD</title>
        
        <script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.min.js"></script>
        
        <script>
            
            $(document).ready(
                function () {
                    showCodes();
                }
            );

            function showCodes() {
                $.ajax({
                    url: "allPO",
                    dataType: "json",
                    error: showError,
                    success:
                        function (result) {
                            console.log(result);
                            var template = $('#codesTemplate').html();
                            var processedTemplate = Mustache.to_html(template, result);
                            $('#aff').html(processedTemplate);
                        }
                });
            }

            function showError(xhr, status, message) {
                alert(JSON.parse(xhr.responseText).message);
            }
            
        </script>
        
    </head>
    
    <body>
           
        <div id="aff"></div>

        <script id="codesTemplate" type="text/template">
            
            <table>
            
                <tr>
                    <th>Numero de commande</th>
                    <th>Numero de client</th>
                    <th>Description</th>
                    <th>Numero du produit</th>
                    <th>Quantité</th>
                    <th>Prix</th>
                    <th>Date de vente</th>
                    <th>Date de livraison</th>
                </tr>
                
                {{#records}}
                    <tr>
                        <th>{{order_num}}</th>
                        <th>{{customer_id}}</th>
                        <th>{{description}}</th>
                        <th>{{product_id}}</th>
                        <th>{{quantity}}</th>
                        <th>{{shipping_cost}}</th>
                        <th>{{sales_date}}</th>
                        <th>{{shipping_date}}</th>
                    </tr>
                {{/records}}
            
            </table>
            
        </script>
        
    </body>
    
</html>

