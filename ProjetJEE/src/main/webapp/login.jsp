<%-- 
    Document   : login
    Created on : 23 nov. 2018, 22:10:12
    Author     : Utilisateur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form method="POST">
            <label> Login : <input name="name"></label>
            <label> Mot de passe : <input name="password"></label>
            <input name="action" value="Connexion" type="SUBMIT">
        </form>  
    </body>
</html>
