
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
                    url: "allP",
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
            
            function addPO() {
                $.ajax({
                    url: "addPO",
                    data: $("#codeForm").serialize(),
                    dataType: "json",
                    success:
                        function (result) {
                            console.log(result);
                            showError();
                        },
                    error: showError
                });
                return false;
            }

            function showError(xhr, status, message) {
                alert(JSON.parse(xhr.responseText).message);
            }
            
        </script>
        
    </head>
    
    <body>
        
        <table>
            <tr>
                <table>
                    <h1>Passer votre commande</h1>
                    <form id="codeForm" onsubmit="event.preventDefault(); addPO();">
                        <fieldset><legend>Selectionner votre produit et votre quantité</legend>
                            Numero du produit : <input id="id" name="Numero" type="number"><br/>
                            Quantité : <input id="nbr" name="Quantité" type="number"><br/>
                            <input type="submit" value="Ajouter">
                            <li><a href="ClientPurchaseOrder.jsp">Retourner à vos commandes</a></li>
                        </fieldset>
                    </form>
                </table>
            </tr>
            <tr>
                <div id="aff"></div>                
            </tr>
        </table>

        <script id="codesTemplate" type="text/template">
            
            <table>
            
                <tr>
                    <th>Numero du produit</th>
                    <th>Numero du fournisseur</th>
                    <th>Code du produit</th>
                    <th>Prix</th>
                    <th>Quantité disponible</th>
                    <th>Balisage</th>
                    <th>Disponible</th>
                    <th>Description</th>
                    <th></th>
                </tr>
                
                {{#records}}
                    <tr>
                        <th>{{Product_ID}}</th>
                        <th>{{Manufacturer_ID}}</th>
                        <th>{{Product_Code}}</th>
                        <th>{{Purchase_Cost}}</th>
                        <th>{{Quantity_on_hand}}</th>
                        <th>{{markup}}</th>
                        <th>{{available}}</th>
                        <th>{{Description}}</th>
                    </tr>
                {{/records}}
            
            </table>
            
        </script>
                
        
                
    </body>
    
</html>
