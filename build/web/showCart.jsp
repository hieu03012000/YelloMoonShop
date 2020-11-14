<%-- 
    Document   : showCart
    Created on : Oct 10, 2020, 11:01:57 PM
    Author     : HIEUNGUYEN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Cake</title>
        <style>
            <%@include file="css/mycss.css"%>
        </style>
    </head>
    <body class="text-center">
        <c:set var="user" value="${sessionScope.USER_DTO}"/>
        <main role="main">
            <section class="jumbotron text-center"  style="background: #e8e9f2">
                <div class="container">
                    <h1>Shopping cart</h1>
                    <c:if test="${not empty user}">
                        <h3>${user.name}</h3>
                        <a href="LogoutServlet">Logout</a> <br/><br/>
                    </c:if>
                    <a href="SearchServlet">Add more cake</a>
                </div>
            </section>

        </main>
        <br/>
        <div class="row mb-2">
            <c:set var="cart" value="${sessionScope.CART}"/>
            <c:if test="${not empty cart}">
                <c:set var="list" value="${cart.cakeList}"/>
                <c:if test="${not empty list}">
                    <c:forEach var="cartDetail" items="${list}" varStatus="counter">
                        <div class="col-md-3">
                            <div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                                <div class="col p-4 d-flex flex-column position-static">
                                    <c:set var="info" value="${cartDetail.value}"/>
                                    <div class="modal-header out">
                                        <h4>${counter.count}</h4>
                                    </div>
                                    <br/>
                                    <p><strong>Cake name:</strong> ${info.name}</p>
                                    <p><strong>Price:</strong> ${info.price}</p>
                                    <form action="ChangeQuantityCakeServlet" method="POST">
                                        <c:if test="${info.quantity == '1'}">
                                            <input type="reset" value="-" name="btChange" class="btn1"/>
                                        </c:if>
                                        <c:if test="${info.quantity != '1'}">
                                            <input type="submit" value="-" name="btChange" class="btn1"/>
                                        </c:if>
                                        ${info.quantity}
                                        <input type="hidden" name="txtCakeID" value="${cartDetail.key}" />
                                        <input type="hidden" name="txtCakeName" value="${info.name}" />
                                        <input type="hidden" name="txtCakeQuantity" value="${info.quantity}" />
                                        <input type="hidden" name="txtCakePrice" value="${info.price}" />
                                        <input type="submit" value="+" name="btChange" class="btn1"/>
                                        <c:if test="${requestScope.ERROR_ADD == cartDetail.key}"><br/>
                                            Can not add more
                                        </c:if>
                                        <br/>
                                    </form>
                                    <input type="submit" value="Remove" name="btAction" class="btn btn1" data-toggle="modal" data-target="#exampleModalCenter"/>
                                    <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                            <div class="modal-content">
                                                <form action="RemoveCakeServlet" method="POST">
                                                    <div class="form-group">
                                                        <br/>
                                                        Do you want to remove
                                                    </div>
                                                    <input type="hidden" name="txtKeyValue" value="${cartDetail.key}" />
                                                    <div class="modal-footer">
                                                        <input type="submit" value="Close" class="btn" data-dismiss="modal"/>
                                                        <input type="submit" value="Yes" name="btAction" class="btn" />
                                                    </div>
                                                </form>

                                            </div>
                                        </div>
                                    </div>     
                                </div>  
                            </div>
                        </div>
                    </c:forEach>
                    <br/>
                </div>  
                <h3>Total: ${cart.total}</h3>
                <br/>
                <input type="submit" value="Checkout" name="btAction" class="btn btn1" data-toggle="modal" data-target="#ModalCenter"/>
                <div class="modal fade" id="ModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <form action="CheckOutServlet" method="POST">
                                <p><strong>Your name:</strong></p>
                                <input type="text" class="form-control" id="recipient-name" name="txtUserName" value="${user.name}">
                                <p><strong>Your address:</strong></p>
                                <input type="text" class="form-control" id="recipient-name" name="txtAddress" value="${user.address}">
                                <c:set var="payList" value="${sessionScope.PAYMENT}"/>
                                <p><strong>Payment method:</strong></p>
                                <select name="cpPayment" class="form-control">
                                    <c:forEach var="pDTO" items="${payList}">
                                        <option value="${pDTO.payID}">
                                            ${pDTO.name}
                                        </option>
                                    </c:forEach>
                                </select> <br/>
                                <div class="modal-footer">
                                    <input type="submit" value="Close" class="btn" data-dismiss="modal"/>
                                    <input type="submit" value="Yes" name="btAction" class="btn" />
                                </div>
                            </form>
                        </div>
                    </div>
                </div>             
            </c:if>
            <c:if test="${empty list}">
                <h4>You must add more cake</h4>
            </c:if>
        </c:if>
        <c:if test="${empty cart}">
            <h4>You must add more cake</h4>
        </c:if>

    </body>
</html>
