<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.min.js"></script>

        <title>JSP Page</title>
        <script>
            $(document).ready(
                    function () {
                        showCustomersInState();
                    }
            );

            function showCustomersInState() {
                $.ajax({
                    url: "AllPersoInfo",
                    dataType: "json",
                    success:
                            function (result) {
                                var template = $('#customerTemplate').html();
                                var processedTemplate = Mustache.to_html(template, {records: result.datasPerso});
                                console.log(processedTemplate);
                                $('#customerD').html(processedTemplate);
                            },
                    error: showError
                });
            }

            function showError(xhr, status, message) {
                alert(JSON.parse(xhr.responseText).message);
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

        <h1>Bienvenue ${sessionScope.name}</h1>
        <h1>Bienvenue ${sessionScope.email}</h1>

        <div id="customerD"></div>

        </br>

        <form method="POST">
            <input type="SUBMIT" name="action" value="Deconnexion">
        </form>       

        <script id="customerTemplate" type="text/template">

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

    </body>

</html>