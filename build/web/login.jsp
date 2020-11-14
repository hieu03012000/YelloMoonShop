<%-- 
    Document   : login
    Created on : Oct 6, 2020, 7:35:48 PM
    Author     : HIEUNGUYEN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link href="<c:url value="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />" rel="stylesheet">
        <style>
            <%@include file="css/mycss.css"%>
            body{
                background: grey;
            }
            form{
                width:  350px;
                border: 3px solid #f1f1f1;
                padding: 20px;
                left: 38%;
                top: 15%;
                position: absolute;
                background: white;
                height: 475px;
                border-radius: 10px;
            }
        </style>
    </head>
    <body class="text-center">
        <form action="LoginAccountServlet" method="POST" class="form-signin">
            <h1>LOGIN</h1><br/>
            <p><strong> Username: </strong></p>
            <label for="inputEmail" class="sr-only">Username</label>
            <input type="text" id="inputEmail" class="form-control" placeholder="Email address" required autofocus name="txtUsername">
            <br/>
            <p><strong> Password: </strong></p>
            <label for="inputPassword" class="sr-only">Password</label>
            <input type="password" id="inputPassword" class="form-control" placeholder="Password" required name="txtPassword">
            <br/>
            <input type="submit" value="Login" class="btn btn1"/>
            <input type="reset" value="Reset" class="btn" /> <br/>
            <br/>

            <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8084/YellowMoonShop/login-google&response_type=code
               &client_id=1004491668512-lahs9ntaavm731e4humrrn2muu54ch18.apps.googleusercontent.com&approval_prompt=force">Login With Google</a>
            <br/>
            <br/>
            <c:if test="${not empty sessionScope.INVALID}">
                ${sessionScope.INVALID}
            </c:if>
        </form>
    </body>

</html>
