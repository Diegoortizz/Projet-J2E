<!DOCTYPE html>

<html>

    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Projet J2E - PMD</title>

        <script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.min.js"></script>
        
        <style>
            
            #main {
                background: white;
                margin: 0 auto;
                padding: 60px;
                max-width: 1000px;
            }
            
            h1 {
                color: #1abc9c;
                font-family: 'Helvetica Neue', Helvetica, Arial;
            }
            
            h2 {
                color: #1abc9c;
                font-family: 'Helvetica Neue', Helvetica, Arial;
            }
            
            body {
                font-family: 'Helvetica Neue', Helvetica, Arial;
                font-size: 14px;
                line-height: 20px;
                font-weight: 400;
                color: #3b3b3b;
                -webkit-font-smoothing: antialiased;
                font-smoothing: antialiased;
                background: grey;
            }

            #StyleTable {
                font-family: 'Roboto', sans-serif;
                width: 100%;
                margin: 0 0 40px 0;
                box-shadow: 0 1px 3px rgba(0,0,0,0.2);
            }

            #StyleTable td, #StyleTable th {
                text-align: center; 
                vertical-align: middle;
                border: 1px solid #ddd;
                padding: 8px;
            }

            #StyleTable tr:nth-child(even){background-color: #f2f2f2;}

            #StyleTable tr:hover {background-color: #ddd;}

            #StyleTable th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                background-color: #1abc9c;
                color: white;
            }
            
            #codeForm {
                width: 450px;
                font-size: 16px;
                background: #1abc9c;
                margin: 10px auto;
                padding: 30px 30px 15px 30px;
                border: 5px solid #53687E;
            }
            
            #button {
                position: relative;
                display: block;
                padding: 19px 39px 18px 39px;
                color: #FFF;
                margin: 0 auto;
                background: #1abc9c;
                font-size: 18px;
                text-align: center;
                font-style: normal;
                width: 100%;
                border: 1px solid #16a085;
                border-width: 1px 1px 3px;
                margin-bottom: 10px;
            }
            
            p {
                color: white;
            }
            
        </style>
        
        <script>

            $(document).ready(
                    function () {
                        showCodesP();
                    }
            );

            function showCodesP() {
                $.ajax({
                    url: "allP",
                    dataType: "json",
                    error: showError,
                    success:
                            function (result) {
                                var template = $('#codesTemplate2').html();
                                var processedTemplate = Mustache.to_html(template, result);
                                $('#affP').html(processedTemplate);
                            }
                });
            }
            
            function deleteP(Product_ID) {
                $.ajax({
                    url: "deleteP",
                    data: {"Product_ID": Product_ID},
                    dataType: "json",
                    success:
                            function () {
                                showCodesP();
                            },
                    error: showError
                });
                return false;
            } 
            
            function modifP(Product_ID,Manufacturer_ID,Product_Code,Purchase_Cost,Quantity_on_hand,markup,available,Description) {
                
                w = open("",'popup','width=600,height=500,toolbar=no,scrollbars=no,resizable=yes');
                
                w.document.write("<title>"+"Modifitation du produit "+Product_ID+"</title>");
                w.document.write("<body>");
                w.document.write("<h1>Vous pouvez modifier le produit "+Product_ID+"</h1>");
                
                w.document.write("<form id='codeForm' onsubmit='event.preventDefault(); UpdateProduct()';>");
                    w.document.write("<input type='hidden' name='Product_ID' value=Product_ID>");
                    w.document.write("<p>Prix : "+Purchase_Cost+"</p>");
                        w.document.write("<input type='text' name='Purchase_Cost' id='Purchase_Cost'>");
                    w.document.write("<p>Quantité disponible : "+Quantity_on_hand+"</p>");
                        w.document.write("<input type='text' name='Quantity_on_hand' id='Quantity_on_hand'>");
                    w.document.write("<p>Balisage : "+markup+"</p>");
                        w.document.write("<input type='text' name='markup' id='markup'>");
                    w.document.write("<p>Description : "+Description+"</p>");
                        w.document.write("<input type='text' name='Description' id='Description'>");
                    w.document.write("<br>");
                    w.document.write("<br>");
                    w.document.write("<input type='submit'>");
                w.document.write("</form>");
                
                w.document.write("</body>");
                w.document.close();  
                
            }
            
            function UpdateProduct() {
                $.ajax({
                    url: "ModifyInfosProduct",
                    data: $("#codeForm").serialize(),
                    success:
                            function () {
                                showCodesP();
                            },
                    error: showError
                });
            }
            
            function addP() {
                $.ajax({
                    url: "AddP",
                    data: $("#codeForm").serialize(),
                    dataType: "json",
                    success:
                        function () {
                            showCodesP();
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
        
        <div id="main">

            <h1>Voici la liste des produits</h1>

            <div id="affP"></div>

            <h2>Ajouter un nouveau produit</h2>

            <form id="codeForm" onsubmit="event.preventDefault(); addP();">
                PRODUCT_ID : <input id="PRODUCT_ID" name="PRODUCT_ID"><br>
                MANUFACTURER_ID : <input id="MANUFACTURER_ID" name="MANUFACTURER_ID"><br>
                PRODUCT_CODE : <input id="PRODUCT_CODE" name="PRODUCT_CODE"><br>
                PURCHASE_COST : <input id="PURCHASE_COST" name="PURCHASE_COST"><br>
                QUANTITY_ON_HAND : <input id="QUANTITY_ON_HAND" name="QUANTITY_ON_HAND"><br>
                MARKUP : <input id="MARKUP" name="MARKUP"><br>
                DESCRIPTION : <input id="DESCRIPTION" name="DESCRIPTION"><br>
                <input type="submit" value="Ajouter">
            </form>

            <form method="POST">
                <input id="button" type="SUBMIT" name="action" value="Accéder aux statistiques">
                <input id="button" type="SUBMIT" name="action" value="Ajouter un nouveau produit">
                <input id="button" type="SUBMIT" name="action" value="Deconnexion">
            </form> 
            
        </div>
        
        <script id="codesTemplate2" type="text/template">
            
            <table id="StyleTable">
            
                <tr>
                    <th>Numero du produit</th>
                    <th>Numero du fournisseur</th>
                    <th>Code du produit</th>
                    <th>Prix</th>
                    <th>Quantité disponible</th>
                    <th>Balisage</th>
                    <th>Disponible</th>
                    <th>Description</th>
                    <th>Action</th>
                </tr>
                
                {{#records}}
                    <tr>
                        <td>{{Product_ID}}</td>
                        <td>{{Manufacturer_ID}}</td>
                        <td>{{Product_Code}}</td>
                        <td>{{Purchase_Cost}}</td>
                        <td>{{Quantity_on_hand}}</td>
                        <td>{{markup}}</td>
                        <td>{{available}}</td>
                        <td>{{Description}}</td>
                        <td>
                            <button onclick="deleteP('{{Product_ID}}')">Supprimer</button>
                            <form name="f_popup">
                                <p><input type="button" value="Modifier" 
                                onclick="modifP('{{Product_ID}}','{{Manufacturer_ID}}','{{Product_Code}}','{{Purchase_Cost}}',
                                            '{{Quantity_on_hand}}','{{markup}}','{{available}}','{{Description}}')">
                            </form>
                        </td>
                    </tr>
                {{/records}}
            
            </table>
            
        </script>

    </body>

</html>

