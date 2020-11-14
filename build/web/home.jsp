<%-- 
    Document   : home
    Created on : Oct 6, 2020, 11:04:13 PM
    Author     : HIEUNGUYEN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" crossorigin="anonymous">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <style>
            <%@include file="css/mycss.css"%>
        </style>
    </head>
    <body>
        <main role="main">
            <section class="jumbotron text-center" style="background: #e8e9f2">
                <div class="container">
                    <h1>HOME PAGE</h1>
                    <c:if test="${empty sessionScope.USER_DTO}">
                        <a href="LoginAccountServlet">Login</a>
                    </c:if>
                    <c:if test="${not empty sessionScope.USER_DTO}">
                        <c:set var="user" value="${sessionScope.USER_DTO}"/>
                        <h3>Welcome ${user.name}</h3>
                        <a href="LogoutServlet">Logout</a> <br/>
                    </c:if> <br/>
                </div>
            </section>
        </main>
        <div class="row">
            <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block sidebar collapse" style="background: #e8e9f2">
                <div class="sidebar-sticky pt-3">
                    <c:set var="cList" value="${requestScope.CATEGORY_LIST}"/>
                    <c:if test="${user.role!='AD'}">
                        <a href="ShowCartServlet" class="btn nen"><strong>View your cart</strong></a>
                        <br/>
                        <c:set var="cart" value="${sessionScope.CART}"/>
                        <input type="submit" value="Checkout" name="btAction" class="btn" data-toggle="modal" data-target="#ModalCenter"/>
                        <c:if test="${not empty cart}">
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
                        <c:if test="${empty cart}">
                            <p>No cake in your shopping cart</p>
                        </c:if>
                        <br/> 
                    </c:if>
                    <c:if test="${user.role=='AD'}">
                        <input type="submit" value="New Cake" name="btAction" class="btn" data-toggle="modal" data-target="#exampleModalCenter"/>

                        <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">
                                    <form action="CreateNewCakeServlet" method="POST" enctype="multipart/form-data">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="exampleModalLongTitle">New cake</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <p><strong>Name:</strong></p>
                                            <input type="text" class="form-control" id="recipient-name" name="txtNewName">
                                            <p><strong>Price:</strong></p>
                                            <input type="text" class="form-control" id="recipient-name" name="txtNewPrice">
                                            <p><strong>Quantity:</strong></p>
                                            <input type="text" class="form-control" id="recipient-name" name="txtNewQuantity">
                                            <p><strong>Description:</strong></p>
                                            <input type="text" class="form-control" id="recipient-name" name="txtNewDescription">
                                            <p><strong>Category:</strong></p>
                                            <select name="cbNewCategory" class="form-control">
                                                <c:forEach var="cDTO" items="${cList}">
                                                    <option value="${cDTO.categoryID}">
                                                        ${cDTO.name}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <p><strong>Create Date:</strong></p>
                                            <input type="date" name="txtNewCDate" value="" class="form-control"/> <br/>
                                            <p><strong>E Date:</strong></p>
                                            <input type="date" name="txtNewEDate" value="" class="form-control"/> <br/>
                                            <p><strong>Image:</strong></p>
                                            <p><input type="file" name="txtImage" value="" /></p>
                                        </div>
                                        <div class="modal-footer">
                                            <input type="submit" value="Close" class="btn" data-dismiss="modal"/>
                                            <input type="submit" value="Add" name="btAction" class="btn" />
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <form action="SearchServlet" method="POST">
                        <p><strong>Cake name:</strong></p>
                        <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search" value="${param.txtSearch}" name="txtSearch">
                        <c:set var="searchValue" value="${param.txtSearch}"/>
                        <br/>
                        <p><strong>Category:</strong></p>
                        <c:set var="selectedCate" value="${requestScope.SELECTED_CATEGORY}"/>

                        <select name="txtCategory" class="form-control mr-sm-2">
                            <option value="" <c:if test="${selectedCate == ''}">
                                    selected="true"</c:if>>
                                    All category
                                </option>
                            <c:forEach var="cDTO" items="${cList}">
                                <option<c:if test="${selectedCate == cDTO.name}">
                                        selected="true"</c:if>>
                                    ${cDTO.name}
                                </option>
                            </c:forEach>
                        </select>
                        <c:set var="searchCategory" value="${param.txtCategory}"/>
                        <br/>
                        <c:set var="selected" value="${requestScope.SELECTED_COMBOBOX}"/>
                        <p><strong>Category:</strong></p>
                        <select name="cbPrice" class="form-control mr-sm-2">
                            <option <c:if test="${selected=='All price'}">
                                    selected="true"
                                </c:if>>All price</option>
                            <option<c:if test="${selected=='0 - 50000'}">
                                    selected="true"
                                </c:if>>0 - 50000</option>
                            <option<c:if test="${selected=='50000 - 100000'}">
                                    selected="true"
                                </c:if>>50000 - 100000</option>
                            <option<c:if test="${selected=='100000 - 150000'}">
                                    selected="true"
                                </c:if>>100000 - 150000</option>
                            <option<c:if test="${selected=='150000 - 200000'}">
                                    selected="true"
                                </c:if>>150000 - 200000</option>
                            <option<c:if test="${selected=='200000 Above'}">
                                    selected="true"
                                </c:if>>200000 Above</option>
                        </select> 
                        <c:set var="searchPrice" value="${param.cbPrice}"/>
                        <input type="submit" value="Search" name="btAction" class="btn"/> <br/> <br/>    
                    </form>
                    <br/>
                    <c:if test="${user.role=='AD'}">
                        <div class="sidebar-sticky pt-3">
                            <h3>Notification: </h3>
                            <c:if test="${not empty sessionScope.LOG_LIST}">
                                <ul class="nav flex-column mb-2">
                                    <c:forEach var="lDTO" items="${sessionScope.LOG_LIST}">
                                        <li class="nav-item">
                                            <p>${lDTO.email} was 
                                                ${lDTO.type} the cake
                                                ${lDTO.productID} at
                                                ${lDTO.date}</p>
                                        </li>   
                                    </c:forEach>
                                </ul>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </nav>
            <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
                <c:if test="${not empty requestScope.OID}">
                    Your order ID is ${requestScope.OID}
                </c:if>
                <c:if test="${not empty requestScope.NOT_FOUND}">
                    <h3>${requestScope.NOT_FOUND}</h3>
                </c:if>
                <c:if test="${user.role=='U'}">
                    <form action="SearchOrderDetail" method="POST">
                        <div class="row">
                            <nav class="col-md-10 d-md-block collapse">
                                <p><strong> Order ID:</strong> </p>
                                <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search" value="" name="txtSearchOrder">
                            </nav>
                            <input type="submit" value="Search order ID" name="btAction"  class="btn btn1 row col-lg-2"/>
                        </div>
                    </form>
                    <c:if test="${not empty requestScope.NOT_FOUND_DETAIL}">
                        <p>${requestScope.NOT_FOUND_DETAIL}</p>
                    </c:if>
                </c:if>
                <c:if test="${user.role=='AD'}">
                    <c:if test="${not empty sessionScope.ERROR}">
                        <font color="red">${sessionScope.ERROR}</font>
                    </c:if>
                </c:if>
                <form action="SearchServlet" method="POST">
                    <c:set var="countPage" value="${requestScope.PAGE_COUNT}"/>
                    <div style="text-align: center">
                        <input type="hidden" value="${searchValue}" name="txtSearch" />
                        <input type="hidden" value="${searchCategory}" name="txtCategory" />
                        <input type="hidden" value="${searchPrice}" name="cbPrice" />
                        <c:forEach var="num" begin="${1}" end="${countPage}">
                            <input type="submit" value="${num}" name="btnPage" class="btn btn_page btn1"/>
                        </c:forEach>
                    </div>
                </form>
                <div class="row mb-2">
                    <c:if test="${not empty requestScope.PRODUCT_LIST}">
                        <c:set var="list" value="${requestScope.PRODUCT_LIST}"/>
                        <c:forEach var="dto" items="${list}">
                            <br/>
                            <div class="col-md-4">
                                <div class="row no-gutters border rounded overflow-hidden mb-4 shadow-sm h-md-250">
                                    <c:if test="${user.role!='AD'}">
                                        <div class="col p-4 flex-column position-static">
                                            <c:if test="${dto.image != ''}">
                                                <div class="modal-header out_img">
                                                    <img src="${dto.image}" alt="No pic"> 
                                                </div>
                                            </c:if>
                                            <form action="AddToCartServlet" method="POST">
                                                <input type="hidden" name="txtCakeID" value="${dto.productID}" />
                                                <p><strong>Cake name:</strong> ${dto.name} </p>
                                                <input type="hidden" name="txtCakeName" value="${dto.name}" />
                                                <p><strong>Price:</strong> ${dto.price} </p>
                                                <input type="hidden" name="txtCakePrice" value="${dto.price}" />
                                                <input type="hidden" name="txtCakeQuantity" value="${dto.quantity}" />
                                                <p>${dto.description}</p>
                                                <p><strong>Create date:</strong> ${dto.createDate}</p>
                                                <p><strong>Expiration date:</strong> ${dto.expirationDate}</p>
                                                <p><strong>Category:</strong> ${dto.category}</p> 
                                                <input type="submit" value="Add" name="btAction" class="btn btn1" />
                                                <c:set var="addError" value="${sessionScope.ERROR_ADD}"/>
                                                <c:if test="${addError == dto.productID}">
                                                    Out of stock
                                                </c:if>
                                            </form>
                                        </div>
                                    </c:if>
                                    <c:if test="${user.role=='AD'}">
                                        <div class="col p-4 flex-column position-static">
                                            <c:if test="${dto.image != ''}">
                                                <div class="modal-header out_img">
                                                    <img src="${dto.image}" alt="No pic"> 
                                                </div>
                                            </c:if>
                                            <form action="UpdateServlet" method="POST" enctype="multipart/form-data" id="testform">
                                                <input type="hidden" name="txtProductID" value="${dto.productID}" />
                                                <p><strong>Cake name:</strong></p>
                                                <input type="text" class="form-control" id="recipient-name" name="txtName" value="${dto.name}"> 
                                                <br/>
                                                <p><strong>Price:</strong> </p>
                                                <input type="text" class="form-control" id="recipient-name" name="txtPrice" value="${dto.price}">
                                                <br/>
                                                <p><strong>Quantity:</strong> </p>
                                                <input type="text" class="form-control" id="recipient-name" name="txtQuantity" value="${dto.quantity}">
                                                <br/>
                                                <p><strong>Choose image:</strong> </p>
                                                <input type="file" name="txtImage" value="${dto.image}"/> 
                                                <br/> <br/>
                                                <p><strong>Create date:</strong> </p>
                                                <input type="date" name="txtCDate" class="form-control" value="${dto.createDate}"/> <br/>
                                                <p><strong>Expiration date:</strong> </p>
                                                <input type="date" name="txtEDate" class="form-control" value="${dto.expirationDate}"/> <br/>
                                                <p><strong>Category:</strong> </p>
                                                <select name="cbCategory" class="form-control">
                                                    <c:forEach var="cDTO" items="${cList}">
                                                        <option value="${cDTO.categoryID}"
                                                                <c:if test="${cDTO.name == dto.category}">
                                                                    selected="true"</c:if>>
                                                                ${cDTO.name}
                                                        </option>
                                                    </c:forEach>
                                                </select> <br/>
                                                <p><strong>Status:</strong> </p>
                                                <select name="cbStatus"  class="form-control">
                                                    <option<c:if test="${dto.status}">
                                                            selected="true"
                                                        </c:if>>Active</option>
                                                    <option<c:if test="${not dto.status}">
                                                            selected="true"
                                                        </c:if>>Inactive</option>
                                                </select> <br/>
                                                <input type="submit" value="Save" name="btAction" class="btn btn1"/>
                                            </form>
                                            <c:set var="test" value="${requestScope.TEST}"/>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
            </main>
        </div>
    </body>
</html>
