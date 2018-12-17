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
            
            #button:hover {
                background: #109177;
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
            
            function modifP(Product_ID) {
               var Purchase_Cost = $('#'+Product_ID+'_Purchase_Cost').val();
               var Quantity_on_hand = $('#'+Product_ID+'_Quantity_on_hand').val();
               var markup = $('#'+Product_ID+'_markup').val();
               var Description = $('#'+Product_ID+'_Description').val();
               
               $.ajax({
                    url: "ModifyInfosProduct",
                    data: {"Product_ID":Product_ID,"Purchase_Cost":Purchase_Cost,"Quantity_on_hand":Quantity_on_hand,"markup":markup,"Description":Description},
                    success:
                            function () {
                                showCodesP();
                            },
                    error: showError
                });
                
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
                PRODUCT_ID : <input id="PRODUCT_ID" name="PRODUCT_ID" type="number"><br>
                MANUFACTURER_ID :
                <select id="MANUFACTURER_ID" name="MANUFACTURER_ID">
                    <option value="">--Choisissez le manufacturer--</option>
                    <option value="19941212">19941212</option><option value="19948494">19948494</option><option value="19955564">19955564</option>
                    <option value="19955565">19955565</option><option value="19955656">19955656</option><option value="19960022">19960022</option>
                    <option value="19963322">19963322</option><option value="19963323">19963323</option><option value="19963324">19963324</option>
                    <option value="19963325">19963325</option><option value="19965794">19965794</option><option value="19971233">19971233</option>
                    <option value="19974892">19974892</option><option value="19977346">19977346</option><option value="19977347">19977347</option>
                    <option value="19977348">19977348</option><option value="19977775">19977775</option><option value="19978451">19978451</option>
                    <option value="19980198">19980198</option><option value="19982461">19982461</option><option value="19984681">19984681</option>
                    <option value="19984682">19984682</option><option value="19984899">19984899</option><option value="19985590">19985590</option>
                    <option value="19985678">19985678</option><option value="19986196">19986196</option><option value="19986542">19986542</option>
                    <option value="19986982">19986982</option><option value="19987296">19987296</option><option value="19989719">19989719</option>
                </select>
                PRODUCT_CODE : 
                <select id="PRODUCT_CODE" name="PRODUCT_CODE">
                    <option value="">--Choisissez le code de produit--</option>
                    <option value="BK">BK</option>
                    <option value="CB">CB</option>
                    <option value="FW">FW</option>
                    <option value="HW">HW</option>
                    <option value="MS">MS</option>
                    <option value="SW">SW</option>
                </select>
                PURCHASE_COST : <input id="PURCHASE_COST" name="PURCHASE_COST" type="number" step="0.01"><br>
                QUANTITY_ON_HAND : <input id="QUANTITY_ON_HAND" name="QUANTITY_ON_HAND" type="number"><br>
                MARKUP : <input id="MARKUP" name="MARKUP" type="number" step="0.01"><br>
                DESCRIPTION : <input id="DESCRIPTION" name="DESCRIPTION"><br>
                <input type="submit" value="Ajouter">
            </form>

            <form method="POST">
                <input id="button" type="SUBMIT" name="action" value="Accéder aux statistiques">
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
                        <td><input id="{{Product_ID}}_Purchase_Cost" type="number" value="{{Purchase_Cost}}"></td>
                        <td><input id="{{Product_ID}}_Quantity_on_hand" type="number" value="{{Quantity_on_hand}}"></td>
                        <td><input id="{{Product_ID}}_markup" type="number" value="{{markup}}"></td>
                        <td>{{available}}</td>
                        <td><input id="{{Product_ID}}_Description" type="text" value="{{Description}}"></td>
                        <td>
                            <button onclick="deleteP('{{Product_ID}}')">Supprimer</button>
                            <form name="f_popup">
                                <p><input type="button" value="Modifier" onclick="modifP('{{Product_ID}}')">
                            </form>
                        </td>
                    </tr>
                {{/records}}
            
            </table>
            
        </script>

    </body>

</html>

