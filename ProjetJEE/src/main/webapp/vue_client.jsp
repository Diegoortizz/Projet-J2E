<%-- 
    Document   : vue_client
    Created on : 23 nov. 2018, 22:16:12
    Author     : Utilisateur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.min.js"></script>-->
        <!--<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">-->
        <!--<link rel="stylesheet" type="text/css" href="style_main_test.css">-->

        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <!--                <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
                
                        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
                        <script src="editabletable/jquery.tabledit.js"></script>-->

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.min.js"></script>



        <title>JSP Page</title>
        <script>
            $(document).ready(
                    function () {
                        showCustomersInState();
                    }
            );

            function showError(xhr, status, message) {
                alert(JSON.parse(xhr.responseText).message);
            }

            function showCustomersInState() {
                $.ajax({
                    url: "AllPersoInfo",
                    dataType: "json",
                    success: // La fonction qui traite les résultats
                            function (result) {
                                var template = $('#customerTemplate').html();
//                                console.log("diego", result.datasPerso);
                                var processedTemplate = Mustache.to_html(template, {records: result.datasPerso});
                                console.log(processedTemplate);
                                $('#customerD').html(processedTemplate);
                            },
                    error: showError
                });
            }


        </script>

        <style>
            #customerTemplate {
                font-family: 'Roboto', sans-serif;
                border-collapse: collapse;
                width: 100%;
            }

            #customerTemplate td, #customerTemplate th {
                text-align: center; 
                vertical-align: middle;
                border: 1px solid #ddd;
                padding: 8px;
            }

            #customerTemplate tr:nth-child(even){background-color: #f2f2f2;}

            #customerTemplate tr:hover {background-color: #ddd;}

            #customerTemplate th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                background-color: #4CAF50;
                color: white;
            }
        </style>
    </head>

    <body>
        <h1>Bienvenue ${sessionScope.name} </h1>



        <input type="text" name="ID"> 
        <output type="text" name="ID"> </output>


        <p id="demo"></p>
        <form method="POST">
            <input type="SUBMIT" name="action" value="Deconnexion">
        </form>       
        <br>


        <script id="customerTemplate" type="text/template">
            <h2>Customers datas</h2>
            <table align="center" id="customerTemplate">
            <tr>
            <th>id</th>
            <th>nom</th>
            <th>ville</th>
            </tr>
            {{#records}}
            <tr>
            <td>{{customerid}}</td>
            <td>{{name}}</td>
            <td>{{city}}</td>
            </tr>
            {{/records}}
            </table>
        </script>

        <div id="customerD">
        </div>
    </body>
</html>