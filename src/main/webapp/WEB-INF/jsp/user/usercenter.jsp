<%--
  Created by IntelliJ IDEA.
  User: ChenJiayang
  Date: 2017/4/13
  Time: 15:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title><spring:message code="userCenter"/></title>

    <!-- Bootstrap core CSS -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="sticky-footer.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.js"></script>
    <![endif]-->
</head>
<body>

<!-- Begin page content -->
<div class="container">

    <div class="page-header">
        <h1><spring:message code="userCenter"/> —— <small>${userinfo.uName}</small></h1>
    </div>
    <nav style="text-align: right">
        <a class="btn btn-warning" href="<c:url value="/myProductPage?pageNow=1"/>"><spring:message code="back"/></a>
    </nav>

    <p class="lead"><spring:message code="personinfo"/></p>

    <form action="<c:url value="/updatePerson"/>" method="post">
    <div class="row">
        <div class="col-md-12">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th><spring:message code="sex"/></th>
                    <th><spring:message code="address"/></th>
                    <th><spring:message code="phone"/></th>
                    <th><spring:message code="TopUp"/></th>
                    <th><spring:message code="operation"/></th>
                </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <c:if test="${userinfo.sex == 0}">
                                <input type="number" name="sex" class="form-control" id="sex" placeholder="<spring:message code="woman"/>">
                            </c:if>
                            <c:if test="${userinfo.sex == 1}">
                                <input type="number" name="sex" class="form-control" id="sex" placeholder="<spring:message code="man"/>">
                            </c:if>
                        </td>
                        <td>
                            <input type="text" name="address" class="form-control" id="address" placeholder="${userinfo.address}">
                        </td>
                        <td>
                            <input type="text" name="phone" class="form-control" id="phone" placeholder="${userinfo.phone}">
                        </td>
                        <td>
                            <input type="text" name="topup" class="form-control" id="topup" placeholder="${nowMoney}">
                        </td>
                        <td>
                            <button type="submit" class="btn btn-success"><spring:message code="save"/></button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    </form>

    <br><br>

    <p class="lead">Order History</p>
    <form class="navbar-form" action="<c:url value="/orderSearch"/>" method="post">
        <div class="row">
            <div class="form-inline">
                <input name="ordersearch" type="text" class="form-control" placeholder="Search">
                &nbsp;&nbsp;
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="submitted" value="1"><spring:message code="submitted"/>
                    </label>
                </div>
                &nbsp;&nbsp;
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="paid" value="2"><spring:message code="paid"/>
                    </label>
                </div>
                &nbsp;&nbsp;
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="refused" value="0"><spring:message code="refused"/>
                    </label>
                </div>
                &nbsp;&nbsp;
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="accepted" value="3"><spring:message code="accepted"/>
                    </label>
                </div>
                &nbsp;&nbsp;
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="canceled" value="4"><spring:message code="canceled"/>
                    </label>
                </div>
                &nbsp;&nbsp;
                <button type="submit" class="btn btn-default"><spring:message code="search"/></button>
            </div>
        </div>
    </form>

    <div class="row">
        <div class="col-md-12">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th><spring:message code="ordercode"/></th>
                    <th><spring:message code="orderprice"/></th>
                    <th><spring:message code="ordertime"/></th>
                    <th><spring:message code="orderstatus"/></th>
                    <th><spring:message code="orderdetails"/></th>
                    <th><spring:message code="operation"/></th>
                    <th><spring:message code="pay"/></th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${!empty orderhistory}">
                    <c:forEach var="order" items="${orderhistory}" varStatus="status">
                        <tr>
                            <td>${order.ocode}</td>
                            <td>${order.o_amount}</td>
                            <td>${order.o_create_time}</td>
                            <td>
                                <c:if test="${order.o_status == 0}">
                                    <font color="#EE2C2C"><b>Refused</b></font>
                                </c:if>
                                <c:if test="${order.o_status == 1}">
                                    <font color="#EEC900"><b>Submitted</b></font>
                                </c:if>
                                <c:if test="${order.o_status == 2}">
                                    <font color="#4876FF"><b>Paid</b></font>
                                </c:if>
                                <c:if test="${order.o_status == 3}">
                                    <font color="#32CD32"><b>Accepted</b></font>
                                </c:if>
                                <c:if test="${order.o_status == 4}">
                                    <font color="#969696"><b>Canceled</b></font>
                                </c:if>
                            </td>
                            <td>
                                <form action="<c:url value="/viewDetails"/>" method="post">
                                <button value="${order.ocode}" name="ocode" type="submit" class="btn btn-default btn-book-view"><spring:message code="viewdetails"/></button>
                                </form>
                            </td>
                            <td>
                                <c:if test="${order.o_status == 1}">
                                    <form action="<c:url value="/cancelOrder"/>" method="post">
                                    <button type="submit" name="cancelOrder" class="btn btn-primary btn-order-cancel" value="${order.ocode}"><spring:message code="cancelOrder"/></button>
                                    </form>
                                </c:if>
                                <c:if test="${order.o_status != 1}">
                                    <button type="button" class="btn btn-primary" disabled="disabled" data-bid="${order.ocode}"><spring:message code="cancelOrder"/></button>
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${order.o_status == 1}">
                                    <form action="<c:url value="/payWhenSubmitted"/>" method="post">
                                        <button type="submit" name="payOrder" class="btn btn-success btn-order-cancel" value="${order.ocode}"><spring:message code="pay"/></button>
                                    </form>
                                </c:if>
                                <c:if test="${order.o_status != 1}">
                                    <button type="button" class="btn btn-success" disabled="disabled" data-bid="${order.ocode}"><spring:message code="pay"/></button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>

                <c:if test="${empty orderhistory}">
                    Empty
                </c:if>

                </tbody>
            </table>
        </div>
    </div>
    <br>

</div>
<br><br><br>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
<script type="text/javascript">
    var xmlHttpRequest = null;
    function ajaxBook() {
        if(window.ActiveXObject) {
            xmlHttpRequest = new ActionXObject("Microsoft.XMLHTTP");
        }
        else if(window.XMLHttpRequest) {
            xmlHttpRequest = new XMLHttpRequest();
        }
        if(xmlHttpRequest != null) {
            var ocode = document.getElementById("ocode").value;
            xmlHttpRequest.open("POST", "viewDetails?ocode=" + ocode, true);
            xmlHttpRequest.onreadystatechange = ajaxBookCall;
            xmlHttpRequest.send();
        }
    }
    function ajaxBookCall() {
        if(xmlHttpRequest.readyState == 4 ) {
            if(xmlHttpRequest.status == 200) {
                var text = xmlHttpRequest.responseText;
                document.getElementById("bookstore").innerHTML = "<p>"+ text + "</p>";
            }
        }
    }
</script>
</body>
</html>

