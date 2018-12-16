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
                        showCodesPO();
                        showCodesP()
                    }
            );

            function showCodesPO() {
                $.ajax({
                    url: "allPO",
                    dataType: "json",
                    error: showError,
                    success:
                            function (result) {
                                var template = $('#codesTemplate1').html();
                                var processedTemplate = Mustache.to_html(template, result);
                                $('#affPO').html(processedTemplate);
                            }
                });
            }

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

            function addPO(Product_ID) {
                $.ajax({
                    url: "addPO",
                    data: {"Product_ID": Product_ID, "id": '${sessionScope.id}'},
                    dataType: "json",
                    success:
                            function () {
                                showCodesPO();
                            },
                    error: showError
                });
                return false;
            }

            function deleteCode(order_num) {
                $.ajax({
                    url: "deletePO",
                    data: {"order_num": order_num},
                    dataType: "json",
                    success:
                            function () {
                                showCodesPO();
                            },
                    error: showError
                });
                return false;
            }
            
            function modifCode() {
                $.ajax({
                    url: "modifPO",
                    data: $("#codeForm").serialize(),
                    dataType: "json",
                    success: 
                        function () {
                            showCodesPO();
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
            
            <br>

            <h1>Voici vos commandes, ${sessionScope.name}</h1>

            <div id="affPO"></div>
        
            <form id="codeForm" onsubmit="event.preventDefault(); modifCode();">
                <span><p>Numero de commande :</p></span><input id="order_num" name="order_num">
                <span><p>Quantite :</p></span><input id="quantity" name="quantity">
                <br>
                <br>
                <input type="submit" value="Modifier">
            </form>  
        
            <h2>Passer une nouvelle commande</h2>
            <div id="affP"></div>
            
            <form id="trans" method="POST">
                <input id="button" type="SUBMIT" name="action" value="Vos informations">
                <input id="button" type="SUBMIT" name="action" value="Deconnexion">
            </form> 
            
        </div>


        <script id="codesTemplate1" type="text/template">
            
            <table id="StyleTable">
            
                <tr>
                    <th>Numero de commande</th>
                    <th>Numero de client</th>
                    <th>Numero du produit</th>
                    <th>Quantité</th>
                    <th>Prix</th>
                    <th>Date de vente</th>
                    <th>Date de livraison</th>
                    <th>Action</th>
                </tr>
                
                {{#records}}
                    <tr>
                        <td>{{order_num}}</td>
                        <td>{{customer_id}}</td>
                        <td>{{product_id}}</td>
                        <td>{{quantity}}</td>
                        <td>{{shipping_cost}}</td>
                        <td>{{sales_date}}</td>
                        <td>{{shipping_date}}</td>
                        <th>
                            <button onclick="deleteCode('{{order_num}}')">Supprimer</button>
                        </th>
                    </tr>
                {{/records}}
            
            </table>
             
        </script>

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
                        <th>
                            <button onclick="addPO('{{Product_ID}}')">Commander</button>
                            
                        </th>
                    </tr>
                {{/records}}
            
            </table>
            
        </script>

    </body>

</html>

