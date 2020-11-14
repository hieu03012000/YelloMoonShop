<%-- 
    Document   : orderDetail
    Created on : Oct 13, 2020, 1:33:37 AM
    Author     : HIEUNGUYEN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detail</title>
        <style>
            <%@include file="css/mycss.css"%>
            p{
                margin: auto;
            }
        </style>
    </head>
    <body class="text-center">
        <c:if test="${empty sessionScope.USER_DTO}">
            <c:redirect url="SearchServlet"/>
        </c:if>
        <c:if test="${not empty sessionScope.USER_DTO}">
            <c:set var="user" value="${sessionScope.USER_DTO}"/>
            <main role="main">
                <section class="jumbotron text-center"  style="background: #e8e9f2">
                    <div class="container">
                        <h3>${user.name}</h3>
                        <a href="LogoutServlet">Logout</a> <br/><br/>
                        <a href="SearchServlet">Back to Home</a>
                    </div>
                </section>
            </main> <br/>
            <div class="out">
                <div class="col-md-4 in">
                    <div class="modal-header">
                        <p><strong>${requestScope.OID}</strong></p>
                    </div> <br/>
                    <c:set var="order" value="${requestScope.O_DTO}"/>
                    <c:set var="list" value="${requestScope.OD_DTO_LIST}"/>
                    <div class="row out">
                        <div class="col-md-2">
                            <p class="in"><strong>No</strong></p>
                        </div>
                        <div class="col-md-4">
                            <p><strong>Cake name</strong></p>
                        </div>
                        <div class="col-md-3">
                            <p class="in"><strong>Quantity</strong></p>
                        </div>
                        <div class="col-md-3">
                            <p class="in"><strong>Price</strong></p>
                        </div>
                    </div>
                    <br/>
                    <c:forEach var="dto" items="${list}" varStatus="counter">
                        <div class="row">
                            <div class="col-md-2">
                                <p class="in"><strong>${counter.count}</strong></p>
                            </div>
                            <div class="col-md-4">
                                <p>${dto.name}</p>
                            </div>
                            <div class="col-md-3">
                                <p class="in">${dto.quantity}</p>
                            </div>
                            <div class="col-md-3">
                                <p class="in">${dto.price}</p>
                            </div>
                        </div>
                        <br/>
                    </c:forEach>
                    <div class="row">
                        <div class="col-md-9">
                            <p><strong>Total: </strong></p>
                        </div>
                        <div class="col-md-3">
                            <p class="in"><strong>${order.total}</strong></p>
                        </div>
                    </div> <br/>
                    <p><strong>Order date: </strong>${order.orderDate}</p><br/>
                    <p><strong>Address:</strong> ${order.oderAddress}</p><br/>
                    <p><strong>Payment method:</strong> ${order.paymentID}</p>
                </div>
            </div>
        </c:if>
    </body>
</html>
