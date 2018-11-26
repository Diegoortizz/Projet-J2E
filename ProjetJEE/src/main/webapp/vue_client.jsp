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
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="style_main_test.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Bienvenue ${sessionScope.name} </h1>
        <!--        <table>
                    <tr>
                        <th>ID</th>
                        <th>Nom</th>
                        <th>Adresse</th>
                        <th>Ville</th>
                        <th>Etat</th>
                        <th>Numero de telephone</th>
                        <th>Numero de fax</th>
                        <th>email</th>
                        <th>Limite de credit</th>
                    </tr>
                    <tr>
                        <td>${sessionScope.customerid}</td>
                        <td>${sessionScope.name}</td>
                        <td>${sessionScope.adress}</td>
                        <td>${sessionScope.city}</td>
                        <td>${sessionScope.state}</td>
                        <td>${sessionScope.phone}</td>
                        <td>${sessionScope.fax}</td>
                        <td>${sessionScope.email}</td>
                        <td>${sessionScope.creditlimit}</td>
                    </tr>
                </table> -->
        <!--<p>---------------------------------------------------------------------------</p>-->

        <p>ID            : ${sessionScope.customerid}</p>
        <p>NOM           : ${sessionScope.name}</p>
        <p>ADRESSE       : ${sessionScope.adress}</p>
        <p>VILLE         : ${sessionScope.city}</p>
        <p>ETAT          : ${sessionScope.state}</p>
        <p>N TELEPHONE   : ${sessionScope.phone}</p>
        <p>N FAX         : ${sessionScope.fax}</p>
        <p>EMAIL         : ${sessionScope.email}</p>
        <p>CREDIT LIMITE : ${sessionScope.creditlimit}</p>

        <!--<p>---------------------------------------------------------------------------</p>-->   


        <form method="POST">
            <input type="SUBMIT" name="action" value="Deconnexion">
        </form>        
        <br>
        <br>
        <br>

<!--        <button type="button" class="btn btn-info" data-toggle="modal" data-target="#contact_dialog">Modifier vos informations</button>

         the div that represents the modal dialog 
        <div class="modal fade" id="contact_dialog" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Enter your name</h4>
                    </div>
                    <div class="modal-body">
                        <form id="contact_form" action="/onlinejson/test.php" method="POST">
                            ID : <input type="text" name="id" value="" readonly ><br/>
                            NOM : <input type="text" name="nomm"><br/>
                            ADRESSE : <input type="text" name="adresse"><br/>
                            VILLE : <input type="text" name="ville"><br/>
                            ETAT : <input type="text" name="etat"><br/>
                            TELEPHONE : <input type="text" name="tel"><br/>
                            FAX : <input type="text" name="fax"><br/>
                            MAIL : <input type="text" name="mail"><br/>
                            CREDIT LIMITE :<input type="text" name="cl" readonly><br/>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" id="submitForm" class="btn btn-default">Send</button>
                    </div>
                </div>
            </div>
        </div-->
    </body>
</html>
